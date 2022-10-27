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
    Provider.family<ScanController, String>((ref, eventId) {
  return ScanController();
});

class ScanController {
  final list = <String>[];

  // Lista di appoggio per evitare che lo scanner continuo faccia chiamate al
  // db per utenti che non hanno effettuato il check in ma stanno
  // facendo il checkout
  final userWithoutCheckIn = <String>{};

  bool processing = false;

  processScan(
    String data,
    CMIProvider provider,
    CMIEvent event,
    ScanMode scanMode,
    Function(EventUser user)? onUpdate,
  ) async {
    if (processing) return;

    logger.i('detected data');

    try {
      final userQrCode = QrCodeData.fromQrCode(data);
      final isGroupCard = userQrCode.isGroupCard;

      // if(isGroupCard) return;
      if (userQrCode.providerId == provider.id ||
          (event.acceptPassepartout && userQrCode.providerId == 'countmein')) {
        if (userWithoutCheckIn.contains(userQrCode.id)) {
          return;
        }

        if (!list.contains(userQrCode.id)) {
          processing = true;

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

          final isSingleAccessType = event.accessType == EventAccessType.single;

          final userSubEventDocRef = Cloud.eventsCollection(provider.id)
              .doc(event.id)
              .collection('subEvents')
              .doc(event.currentSubEvent)
              .collection('users')
              .doc(eventUser.id);

          final userSubEventDoc = await userSubEventDocRef.get();

          if (userSubEventDoc.exists) {
            final userSubEventData = userSubEventDoc.data() ?? {};
            if (!isSingleAccessType &&
                scanMode == ScanMode.checkOut &&
                (!userSubEventData.containsKey('checkOutAt') ||
                    userSubEventData['checkOutAt'] == null)) {
              userSubEventDocRef.update({'checkOutAt': DateTime.now()});
              onUpdate?.call(eventUser);
            }
          } else {
            if (!isSingleAccessType && scanMode == ScanMode.checkOut) {
              userWithoutCheckIn.add(eventUser.id);
              processing = false;
              final message = eventUser.isGroup
                  ? '${eventUser.groupName ?? 'Il gruppo'} non ha effettuato il check in!'
                  : '${eventUser.name} ${eventUser.surname} non ha effettuato il check in!';
              showToast(message,
                  duration: const Duration(seconds: 1),
                  position: ToastPosition.bottom);
              return;
            }

            if (isSingleAccessType && scanMode == ScanMode.checkOut) {
              eventUser = eventUser.copyWith(checkOutAt: DateTime.now());
            } else if (!isSingleAccessType && scanMode == ScanMode.checkIn) {
              eventUser = eventUser.copyWith(checkInAt: DateTime.now());
            }

            final batch = FirebaseFirestore.instance.batch();
            batch.set(userSubEventDocRef, eventUser.toJson());
            // use this or increment on client the users with groupcount
            // if (isGroupCard &&
            //     isSingleAccessType &&
            //     scanMode == ScanMode.checkOut) {
            //   final subEventDocRef =
            //       Cloud.eventsCollection(provider.id)
            //           .doc(eventId)
            //           .collection('subEvents')
            //           .doc(event.currentSubEvent);
            //   batch.update(subEventDocRef, {
            //     'totalUsers': FieldValue.increment(
            //         eventUser.groupCount ?? 0)
            //   });
            // }
            if (!eventUser.isGroup && eventUser.privateId != null) {
              final privateUserSubEventDocRef =
                  Cloud.eventsCollection(provider.id)
                      .doc(event.id)
                      .collection('subEvents')
                      .doc(event.currentSubEvent)
                      .collection('privateUsers')
                      .doc(eventUser.privateId);
              batch.set(privateUserSubEventDocRef, {'id': eventUser.privateId});
            }
            batch.commit();
            //userSubEventDocRef.set(eventUser.toJson());
            onUpdate?.call(eventUser);
          }

          final userRef = Cloud.eventUsersCollection(
            EventIds(
              providerId: provider.id,
              eventId: event.id,
            ),
          ).doc(eventUser.id);
          final globalUserDoc = await userRef.get();
          if (!globalUserDoc.exists) {
            final u = eventUser.toJson();
            u.remove('checkOutAt');
            u.remove('checkInAt');
            u.remove('privateId');
            userRef.set(u, SetOptions(merge: true));
          }
          processing = false;
          list.add(userQrCode.id);
        } else {
          const message = 'Utente già scansionato';
          logger.i(message);
          showToast(message,
              duration: const Duration(milliseconds: 250),
              position: ToastPosition.bottom);
        }
      } else {
        const message =
            'Il provider del tesserino non è valido per questo evento.';
        logger.i(message);
        showToast(message, position: ToastPosition.bottom);
      }
    } catch (ex) {
      logger.e(ex);
      processing = false;
      const message = 'QR-Code non valido';
      logger.i(message);
      showToast(message, position: ToastPosition.bottom);
    }
  }
}
