import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/domain/entities/qcode_data.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/ui/screens/scan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';

final scanControllerProvider =
    Provider.autoDispose.family<ScanController, String>((ref, eventId) {
  logger.wtf('Scan controller create');
  return ScanController();
});

class ScanController {
  final alreadyScannedUser = <String>[];

  // Lista di appoggio per evitare che lo scanner continuo faccia chiamate al
  // db per utenti che non hanno effettuato il check in ma stanno
  // facendo il checkout
  final userWithoutCheckIn = <String>{};

  bool processing = false;

  processScan2(
    String data,
    CMIProvider provider,
    CMIEvent event,
    ScanMode scanMode, {
    Function(EventUser user)? onUpdate,
    Function(EventUser? user, String message)? onError,
    Function(EventUser? user, String message)? onMessage,
  }) async {
    logger.i('processScan2 start');
    if (processing) return;

    logger.i('onProcessing');
    try {
      final userQrCode = QrCodeData.fromQrCode(data);
      final isGroupCard = userQrCode.isGroupCard;

      if (userQrCode.providerId == provider.id ||
          (event.acceptPassepartout && userQrCode.providerId == 'countmein')) {
        if (userWithoutCheckIn.contains(userQrCode.id)) {
          return;
        }
        final ids = EventIds(
            providerId: provider.id,
            eventId: event.id,
            sessionId: event.activeSessionId);

        var eventUser = EventUser(
          isGroup: isGroupCard,
          id: isGroupCard ? userQrCode.groupId! : userQrCode.id,
          name: userQrCode.name,
          surname: userQrCode.surname,
          email: userQrCode.isExternalOrganization
              ? '${userQrCode.email}${provider.domainRequirement}'
              : userQrCode.email,
          cf: userQrCode.cf,
          fromExternalOrganization: userQrCode.isExternalOrganization,
          privateId: userQrCode.privateId,
          groupName: userQrCode.groupName,
          groupCount: userQrCode.groupCount,
          averageAge: userQrCode.averageAge,
          manPercentage: userQrCode.manPercentage,
          womanPercentage: userQrCode.womanPercentage,
        );

        if (!alreadyScannedUser.contains(eventUser.id)) {
          logger.i('onProcessing new user id on local list');
          processing = true;



          final isSingleAccessType = event.accessType == EventAccessType.single;

          final userSubEventDocRef =
              Cloud.sessionDoc(ids).collection('users').doc(eventUser.id);

          logger.i('get user ${eventUser.id} from ${event.activeSessionId}');
          final userSubEventDoc = await userSubEventDocRef.get();
          logger.i('get user ${eventUser.id} complete');
          final userSubEventData = userSubEventDoc.data() ?? {};

          //Check out
          if (!isSingleAccessType && scanMode == ScanMode.checkOut) {
            // se l utente esiste vuol dire che ha fatto il check in
            if (userSubEventDoc.exists) {
              logger.i('processScan2: checkOut user exists');
              // Se non è stato fatto ancora il check out aggiungo la data di check out
              if (!userSubEventData.containsKey('checkOutAt') ||
                  userSubEventData['checkOutAt'] == null) {
                userSubEventDocRef.update({'checkOutAt': DateTime.now()});
                onUpdate?.call(eventUser);
              }
            } else {
              logger.i('processScan2: checkOut user doesnt exist');
              userWithoutCheckIn.add(eventUser.id);
              processing = false;
              final message = eventUser.isGroup
                  ? '${eventUser.groupName ?? 'Il gruppo'} non ha effettuato il check in!'
                  : '${eventUser.name} ${eventUser.surname} non ha effettuato il check in!';
              // showToast(message,
              //     duration: const Duration(seconds: 1),
              //     position: ToastPosition.bottom);
              onError?.call(eventUser, message);
              return;
            }
          }

          //Check in
          if (!userSubEventDoc.exists) {
            logger.i('processScan2: checkin user doesnt exist');

            // Se è un gruppo controllo che il rappresentante abbia fatto checkin
            if (eventUser.isGroup) {
              final groupLeaderDoc = await Cloud.sessionDoc(ids)
                  .collection('users')
                  .doc(userQrCode.id)
                  .get();
              if (!groupLeaderDoc.exists) {
                processing = false;
                onError?.call(
                    eventUser, 'Il capogruppo non ha effettuato il check in');
                return;
              }
            }

            if (isSingleAccessType && scanMode == ScanMode.checkOut) {
              eventUser = eventUser.copyWith(checkOutAt: DateTime.now());
            } else if (!isSingleAccessType && scanMode == ScanMode.checkIn) {
              eventUser = eventUser.copyWith(checkInAt: DateTime.now());
            }

            final batch = FirebaseFirestore.instance.batch();
            batch.set(userSubEventDocRef, eventUser.toJson());
            if (!eventUser.isGroup && eventUser.privateId != null) {
              logger.i('processScan2: checkin user has private id');
              final privateUserSubEventDocRef = Cloud.sessionDoc(ids)
                  .collection('privateUsers')
                  .doc(eventUser.privateId);
              batch.set(privateUserSubEventDocRef, {'id': eventUser.privateId});
            }
            batch.commit();
            //userSubEventDocRef.set(eventUser.toJson());
            onUpdate?.call(eventUser);

            final userRef = Cloud.eventUsersCollection(
              EventIds(
                providerId: provider.id,
                eventId: event.id,
              ),
            ).doc(eventUser.id);
            final globalUserDoc = await userRef.get();
            if (!globalUserDoc.exists) {
              logger.i('processScan2: checkin global user doesnt exist');
              final u = eventUser.toJson();
              u.remove('checkOutAt');
              u.remove('checkInAt');
              u.remove('privateId');
              u.addAll({'participationCount': 1});
              userRef.set(u, SetOptions(merge: true));
              if (!eventUser.isGroup && eventUser.privateId != null) {
                logger.i('processScan2: checkin global user has privateId');
                Cloud.eventDoc(provider.id, event.id)
                    .collection('privateUsers')
                    .doc(eventUser.privateId)
                    .set({'id': eventUser.privateId});
              }
            }
          } else {
            logger.i('User exists, increment participation count');
            await Cloud.eventUsersCollection(
              EventIds(
                providerId: provider.id,
                eventId: event.id,
              ),
            )
                .doc(eventUser.id)
                .update({'participationCount': FieldValue.increment(1)});
          }

          alreadyScannedUser.add(eventUser.id);
          processing = false;
        } else {
          const message = 'Utente già scansionato';
          logger.i(message);
          onMessage?.call(null, message);
          // showToast(message,
          //     duration: const Duration(milliseconds: 250),
          //     position: ToastPosition.bottom);
        }
      } else {
        const message =
            'Il provider del tesserino non è valido per questo evento.';
        logger.i(message);
        onMessage?.call(null, message);
        // showToast(message, position: ToastPosition.bottom);
      }
    } catch (ex, st) {
      logger.e(ex);
      logger.e(st);
      processing = false;
      const message = 'QR-Code non valido';
      logger.i(message);
      onError?.call(null, message);
      // showToast(message, position: ToastPosition.bottom);
    }
  }
}
