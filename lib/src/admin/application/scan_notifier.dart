import 'dart:ui';

import 'package:countmein/constants.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/domain/entities/qrcode_data.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/ui/screens/scan.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scanControllerProvider =
Provider.autoDispose.family<ScanController, String>((ref, eventId) {
  logger.wtf('Scan controller create');
  return ScanController(ref);
});

class ScanController {
  final alreadyScannedUser = <String>[];

  // Lista di appoggio per evitare che lo scanner continuo faccia chiamate al
  // db per utenti che non hanno effettuato il check in ma stanno
  // facendo il checkout
  final userWithoutCheckIn = <String>{};

  final Ref ref;
  bool processing = false;

  ScanController(this.ref);

  // processScan2(String data,
  //     CMIProvider provider,
  //     CMIEvent event,
  //     ScanMode scanMode, {
  //       Function(EventUser user)? onUpdate,
  //       Function(EventUser? user, String message)? onError,
  //       Function(EventUser? user, String message)? onMessage,
  //     }) async {
  //   logger.i('processScan2 start');
  //   if (processing) return;
  //
  //   logger.i('onProcessing');
  //   try {
  //     final userQrCode = QrCodeData.fromQrCode(data);
  //     final isGroupCard = userQrCode.isGroupCard;
  //     final ids = EventIds(
  //         providerId: provider.id,
  //         eventId: event.id,
  //         sessionId: event.activeSessionId);
  //
  //     final passpartoutAndMineCondition =
  //         event.acceptedCardType == AcceptedCardType.passpartoutAndMine &&
  //             (userQrCode.providerId == provider.id ||
  //                 (event.acceptPassepartout &&
  //                     userQrCode.providerId == 'countmein'));
  //
  //     final onlyMineCondition =
  //         event.acceptedCardType == AcceptedCardType.mine &&
  //             userQrCode.providerId == provider.id;
  //
  //     final allUserCardCondition =
  //         event.acceptedCardType == AcceptedCardType.all;
  //
  //     if (allUserCardCondition ||
  //         passpartoutAndMineCondition ||
  //         onlyMineCondition) {
  //       // if (userWithoutCheckIn.contains(userQrCode.id)) {
  //       //   return;
  //       // }
  //
  //       if (userQrCode.isAnonymous && userQrCode.privateId == null) {
  //         onError?.call(null, 'Utente anonimo deve contenere il privateId');
  //         return;
  //       }
  //
  //       var eventUser = EventUser(
  //         isGroup: isGroupCard,
  //         id: isGroupCard ? userQrCode.groupId! : userQrCode.userId,
  //         name: userQrCode.name,
  //         surname: userQrCode.surname,
  //         email: userQrCode.isExternalOrganization
  //             ? '${userQrCode.email}${provider.domainRequirement}'
  //             : userQrCode.email,
  //         cf: userQrCode.cf,
  //         fromExternalOrganization: userQrCode.isExternalOrganization,
  //         privateId: userQrCode.privateId,
  //         groupName: userQrCode.groupName,
  //         groupCount: userQrCode.groupCount,
  //         averageAge: userQrCode.averageAge,
  //         manPercentage: userQrCode.manPercentage,
  //         womanPercentage: userQrCode.womanPercentage,
  //         isAnonymous: userQrCode.isAnonymous,
  //         providerId: provider.id,
  //         userCardProviderId: userQrCode.providerId,
  //
  //       );
  //
  //       if (!alreadyScannedUser.contains(
  //           eventUser.isAnonymous ? eventUser.privateId! : eventUser.id)) {
  //         logger.i('onProcessing new user id on local list');
  //         processing = true;
  //
  //         final isSingleAccessType = event.accessType == EventAccessType.single;
  //
  //         logger.i('get user ${eventUser.id} from ${event.activeSessionId}');
  //         final userSubEventDocRef = Cloud.sessionDoc(ids)
  //             .collection('users')
  //             .doc(eventUser.isAnonymous ? eventUser.privateId : eventUser.id);
  //         final userSubEventDoc = await userSubEventDocRef.get();
  //         final userSubEventData = userSubEventDoc.data() ?? {};
  //         logger.i('get user ${eventUser.id} complete');
  //
  //         //Check out
  //         if (!isSingleAccessType && scanMode == ScanMode.checkOut) {
  //           // se l utente esiste vuol dire che ha fatto il check in
  //           if (userSubEventDoc.exists) {
  //             logger.i('processScan2: checkOut user exists');
  //             // Se non è stato fatto ancora il check out aggiungo la data di check out
  //             if (!userSubEventData.containsKey('checkOutAt') ||
  //                 userSubEventData['checkOutAt'] == null) {
  //               userSubEventDocRef.update({'checkOutAt': DateTime.now()});
  //               onUpdate?.call(eventUser);
  //             }
  //           } else {
  //             logger.i('processScan2: checkOut user doesnt exist');
  //             //userWithoutCheckIn.add(eventUser.id);
  //             processing = false;
  //             final message = eventUser.isGroup
  //                 ? '${eventUser.groupName ??
  //                 'Il gruppo'} non ha effettuato il check in!'
  //                 : eventUser.isAnonymous
  //                 ? 'L\'utente anonimo non ha effettuato il check in!'
  //                 : '${eventUser.name} ${eventUser
  //                 .surname} non ha effettuato il check in!';
  //             onError?.call(eventUser, message);
  //             return;
  //           }
  //         }
  //
  //         //Check in
  //         if (!userSubEventDoc.exists) {
  //           logger.i('processScan2: checkin user doesnt exist');
  //
  //           // Se è un gruppo controllo che il rappresentante abbia fatto checkin
  //           if (eventUser.isGroup) {
  //             final groupLeaderDoc = await Cloud.sessionDoc(ids)
  //                 .collection('users')
  //                 .doc(userQrCode.userId)
  //                 .get();
  //             if (!groupLeaderDoc.exists) {
  //               processing = false;
  //               onError?.call(
  //                   eventUser, 'Il capogruppo non ha effettuato il check in');
  //               return;
  //             }
  //           }
  //
  //           if (isSingleAccessType && scanMode == ScanMode.checkOut) {
  //             eventUser = eventUser.copyWith(checkOutAt: DateTime.now());
  //           } else if (!isSingleAccessType && scanMode == ScanMode.checkIn) {
  //             eventUser = eventUser.copyWith(checkInAt: DateTime.now());
  //           }
  //
  //           final batch = FirebaseFirestore.instance.batch();
  //           final json = eventUser.toJson();
  //           json.removeWhere((key, value) => value == null);
  //           batch.set(userSubEventDocRef, json);
  //           if (!eventUser.isGroup && eventUser.privateId != null) {
  //             logger.i('processScan2: checkin user has private id');
  //             final privateUserSubEventDocRef = Cloud.sessionDoc(ids)
  //                 .collection('privateUsers')
  //                 .doc(eventUser.privateId);
  //             batch.set(privateUserSubEventDocRef, {'id': eventUser.privateId});
  //           }
  //           batch.commit();
  //           //userSubEventDocRef.set(eventUser.toJson());
  //           onUpdate?.call(eventUser);
  //
  //           final eventUsersCollectionRef = Cloud.eventUsersCollection(EventIds(
  //             providerId: provider.id,
  //             eventId: event.id,
  //           )).doc(eventUser.isAnonymous ? eventUser.privateId : eventUser.id);
  //           final globalUserDoc = await eventUsersCollectionRef.get();
  //           if (!globalUserDoc.exists) {
  //             logger.i('processScan2: checkin global user doesnt exist');
  //             json.remove('checkOutAt');
  //             json.remove('checkInAt');
  //             json.remove('privateId');
  //             json.addAll({'participationCount': 1});
  //             eventUsersCollectionRef.set(json, SetOptions(merge: true));
  //             if (!eventUser.isGroup && eventUser.privateId != null) {
  //               logger.i('processScan2: checkin global user has privateId');
  //               Cloud.eventDoc(provider.id, event.id)
  //                   .collection('privateUsers')
  //                   .doc(eventUser.privateId)
  //                   .set({'id': eventUser.privateId});
  //             }
  //           }
  //         } else {
  //           logger.i('User exists, increment participation count');
  //           await Cloud.eventUsersCollection(
  //             EventIds(
  //               providerId: provider.id,
  //               eventId: event.id,
  //             ),
  //           )
  //               .doc(eventUser.isAnonymous ? eventUser.privateId : eventUser.id)
  //               .update({'participationCount': FieldValue.increment(1)});
  //           const message = 'Utente già presente nel db';
  //           onMessage?.call(null, message);
  //         }
  //
  //         alreadyScannedUser
  //             .add(eventUser.isAnonymous ? eventUser.privateId! : eventUser.id);
  //         processing = false;
  //       } else {
  //         const message = 'Utente già scansionato';
  //         logger.i(message);
  //         onMessage?.call(null, message);
  //       }
  //     } else {
  //       final message = 'Tesserino non è valido per questo evento.\n'
  //           'L\'eveno accetta tesserini: ${event.acceptedCardType.text}';
  //       logger.i(message);
  //       onMessage?.call(null, message);
  //     }
  //   } catch (ex, st) {
  //     logger.e(ex);
  //     logger.e(st);
  //     processing = false;
  //     const message = 'QR-Code non valido';
  //     logger.i(message);
  //     onError?.call(null, message);
  //   }
  // }

  Future processScan3(String data,
      CMIProvider provider,
      CMIEvent event,
      ScanMode scanMode, {
        // Function(EventUser user)? onUpdate,
        // Function(EventUser? user, String message)? onError,
        Function(EventUser? user, ScanStatus status)? onMessage,
      }) async {
    logger.i('processScan2 start for ${event.id}');
    if (processing) return;

    logger.i('onProcessing');
    try {
      final userQrCode = QrCodeData.fromQrCode(data);
      final isGroupCard = userQrCode.isGroupCard;
      // final ids = EventIds(
      //     providerId: provider.id,
      //     eventId: event.id,
      //     sessionId: event.activeSessionId);

      final passpartoutAndMineCondition =
          event.acceptedCardType == AcceptedCardType.passpartoutAndMine &&
              (userQrCode.providerId == provider.id ||
                  (event.acceptPassepartout &&
                      userQrCode.providerId == countMeInProviderId));

      final onlyMineCondition =
          event.acceptedCardType == AcceptedCardType.mine &&
              userQrCode.providerId == provider.id;

      final allUserCardCondition =
          event.acceptedCardType == AcceptedCardType.all;

      if (allUserCardCondition ||
          passpartoutAndMineCondition ||
          onlyMineCondition) {
        if (userQrCode.isAnonymous && userQrCode.privateId == null) {
          onMessage?.call(null, ScanStatus.missingPrivateId);
          return;
        }

        /*const eventId = data.eventId;
      const userId = data.userId;
      const privateId = data.privateId;
      const providerId = data.providerId;
      const isSingleAccessType = data.isSingleAccessType;
      const scanMode = data.scanMode;
      const isGroup = data.isGroup;
      const groupLeaderId = data.groupLeaderId;
      const isAnonymous = data.isAnonymous;
      const groupName = data.groupName;
      const name = data.name;
      const surname = data.surname;
      const cf = data.cf;
      const fromExternalOrganization = data.fromExternalOrganization;
      const email = data.email;
      const groupCount = data.groupCount;
      const averageAge = data.averageAge;
      const manPercentage = data.manPercentage;
      const womanPercentage = data.womanPercentage;
      const timestamp = new Date(data.timestamp);
      */
        var eventUser = EventUser(
          id: isGroupCard ? userQrCode.groupId! : userQrCode.userId,
          privateId: userQrCode.privateId,
          providerId: provider.id,
          userCardProviderId: userQrCode.providerId,
          isGroup: isGroupCard,
          isAnonymous: userQrCode.isAnonymous,
          groupName: userQrCode.groupName,
          name: userQrCode.name,
          surname: userQrCode.surname,
          cf: userQrCode.cf,
          fromExternalOrganization: userQrCode.isExternalOrganization,
          email: userQrCode.isExternalOrganization
              ? '${userQrCode.email}${provider.domainRequirement}'
              : userQrCode.email,
          groupCount: userQrCode.groupCount,
          averageAge: userQrCode.averageAge,
          manPercentage: userQrCode.manPercentage,
          womanPercentage: userQrCode.womanPercentage,
        );

        if (!alreadyScannedUser.contains(
            eventUser.isAnonymous ? eventUser.privateId! : eventUser.id)) {
          logger.i('onProcessing new user id on local list');
          processing = true;

          final isSingleAccessType = event.accessType == EventAccessType.single;

          /*
           check_out_completed: check out successfully
           missing_check_in: check out is not possible without checkin
           participation_count_incremented: user exists, check in successfully, user count incremented
           leader_group_not_exist: group leader didnt made the check in
           check_in_completed:
          */
          // chiamata a firebase function
          final json = eventUser.toJson();
          json['eventId'] = event.id;
          json['groupId'] = userQrCode.groupId;
          json['userId'] = userQrCode.userId;
          json['isSingleAccessType'] = isSingleAccessType;
          json['scanMode'] = scanMode.name;
          json['groupLeaderId'] = eventUser.isGroup ? userQrCode.userId : null;
          json['timestamp'] = DateTime
              .now()
              .millisecondsSinceEpoch;
          json['hasPrivateInfo'] = userQrCode.privateId != null;

          const url = '$functionBaseUrl/scanner-scan';
          final res = await ref.read(dioProvider).post(url, data: json);
          if (res.statusCode == 200) {
            final map = Map.from(res.data);
            final status = map['status'] as String;
            onMessage?.call(eventUser, ScanStatus.fromString(status));
            logger.i(status);
            alreadyScannedUser.add(
                eventUser.isAnonymous ? eventUser.privateId! : eventUser.id);
          } else {
            logger.e(res);
            throw Exception(res.statusCode);
          }

          processing = false;
        } else {
          const message = 'Utente già scansionato';
          logger.i(message);
          onMessage?.call(null, ScanStatus.alreadyScanned);
        }
      } else {
        final message = 'Tesserino non è valido per questo evento.\n'
            'L\'evento accetta tesserini: ${event.acceptedCardType.text}';
        logger.i(message);
        onMessage?.call(null, ScanStatus.notValidForThisEvent);
      }
    } catch (ex, st) {
      logger.e(ex);
      logger.e(st);
      processing = false;
      onMessage?.call(null, ScanStatus.unknown);
    }
  }

  // ScanStatus statusFromString(String status) {
  //   return switch (status) {
  //     'missing_check_in' => ScanStatus.missingCheckIn,
  //     'check_out_completed' => ScanStatus.checkOutCompleted,
  //     'participation_count_incremented' =>
  //     ScanStatus.participationCountIncremented,
  //     'leader_group_not_exist' => ScanStatus.leaderGroupNotExist,
  //     'check_in_completed' => ScanStatus.checkInCompleted,
  //     _ => ScanStatus.unknown,
  //   };
  // }
}

enum ScanStatus {
  missingCheckIn,
  missingPrivateId,
  checkOutCompleted,
  participationCountIncremented,
  leaderGroupNotExist,
  checkInCompleted,
  alreadyScanned,
  notValidForThisEvent,
  unknown;

  Color get color {
    return switch (this) {
      ScanStatus.missingCheckIn || ScanStatus
          .notValidForThisEvent || missingPrivateId => Colors.red,
      ScanStatus.leaderGroupNotExist || alreadyScanned => Colors.orange,
      ScanStatus.checkOutCompleted || ScanStatus
          .participationCountIncremented || ScanStatus
          .checkInCompleted => Colors.green,
      _ => Colors.grey,
    };
  }

  String get message {
    return switch (this) {
      ScanStatus.missingCheckIn => 'Non hai effettuato il checkIn',
      ScanStatus
          .missingPrivateId => 'Utente anonimo deve contenere il privateId',
    ScanStatus.checkOutCompleted => 'Check out completato',
    ScanStatus.participationCountIncremented =>
    'Contatore partecipante incrementato',
    ScanStatus.leaderGroupNotExist =>
    'Il leader di questo gruppo non ha effettuato il check in',
    ScanStatus.checkInCompleted => 'Check in completato',
    ScanStatus.alreadyScanned => 'Tesserino già scansionato',
    ScanStatus.notValidForThisEvent => 'Tesserino non valido per questo evento',
    _ => 'Stato sconosciuto',
    };
  }


  factory ScanStatus.fromString(String status){
    return switch (status) {
      'missing_check_in' => ScanStatus.missingCheckIn,
      'check_out_completed' => ScanStatus.checkOutCompleted,
      'participation_count_incremented' =>
      ScanStatus.participationCountIncremented,
      'leader_group_not_exist' => ScanStatus.leaderGroupNotExist,
      'check_in_completed' => ScanStatus.checkInCompleted,
      _ => ScanStatus.unknown,
    };
  }
}
