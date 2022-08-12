import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/src/admin/application/users_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:oktoast/oktoast.dart';
import 'package:countmein/ui/screens/admin.dart';

import '../../cloud.dart';
import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/user_card.dart';
import 'package:soundpool/soundpool.dart';

import '../../domain/entities/user_qr_code.dart';

// uof%gian marco%di francesco%DFRGMR89M02I348U%uof

final usersCountProvider =
    Provider.autoDispose.family<int, EventIds>((ref, ids) {
  return ref.watch(eventUsersStreamProvider(ids)).asData?.value.length ?? 0;
});

enum ScanMode { checkIn, checkOut }

class ScanScreen extends ConsumerStatefulWidget {
  final CMIEvent event;
  final CMIProvider provider;
  final ScanMode scanMode;

  const ScanScreen({
    Key? key,
    required this.event,
    required this.provider,
    required this.scanMode,
  }) : super(key: key);

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool processing = false;
  final list = <String>[];
  final userWithoutCheckIn = <String>{};

  String get eventId => widget.event.id;

  EventUser? lastUser;
  late EventIds ids;
  Barcode? result;

  @override
  void initState() {
    super.initState();
    ids = EventIds(providerId: widget.provider.id, eventId: eventId);
    loadSound();
  }

  @override
  void dispose() {
    pool.dispose();
    super.dispose();
  }

  int? soundId;
  late Soundpool pool;

  showUpdate(Barcode? barcode, EventUser user) {
    if (soundId != null) {
      pool.play(soundId!);
    }
    setState(() {
      result = barcode;
      lastUser = user;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        result = null;
        lastUser = null;
      });
    });

    showToast('${user.name} ${user.surname} aggiunto al database',
        duration: const Duration(milliseconds: 250),
        position: ToastPosition.bottom);
  }

  loadSound() async {
    pool = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);
    soundId =
        await rootBundle.load("assets/beep.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(usersCountProvider(ids));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: MobileScanner(
                      allowDuplicates: true,
                      controller: MobileScannerController(
                          facing: CameraFacing.back, torchEnabled: false),
                      onDetect: (barcode, args) async {
                        final data = barcode.rawValue;

                        if (processing) return;

                        if (data != null) {
                          print('detected data');

                          try {
                            final userQrCode = UserQrCode.fromOldQrCode(data);

                            if (userQrCode.activityId == widget.provider.id ||
                                (widget.event.acceptPassepartout &&
                                    userQrCode.activityId == 'countmein')) {
                              if (userWithoutCheckIn.contains(userQrCode.id)) {
                                return;
                              }

                              if (!list.contains(userQrCode.id)) {
                                processing = true;

                                // final user = userQrCode.toUserCard();
                                var user = EventUser(
                                  id: userQrCode.id,
                                  name: userQrCode.name,
                                  surname: userQrCode.surname,
                                  email: userQrCode.email,
                                  cf: userQrCode.cf,
                                );

                                final isSingleAccessType =
                                    widget.event.accessType ==
                                        EventAccessType.single;
                                // if (isSingleAccessType ||
                                //     widget.scanMode == ScanMode.checkOut) {
                                //   user =
                                //       user.copyWith(checkOutAt: DateTime.now());
                                // } else {
                                //   user =
                                //       user.copyWith(checkInAt: DateTime.now());
                                // }

                                final userSubEventDocRef =
                                    Cloud.eventsCollection(widget.provider.id)
                                        .doc(eventId)
                                        .collection('subEvents')
                                        .doc(widget.event.currentSubEvent)
                                        .collection('users')
                                        .doc(user.id);
                                final userSubEventDoc =
                                    await userSubEventDocRef.get();

                                if (userSubEventDoc.exists) {
                                  final userSubEventData =
                                      userSubEventDoc.data() ?? {};
                                  if (!isSingleAccessType &&
                                      widget.scanMode == ScanMode.checkOut &&
                                      (!userSubEventData
                                              .containsKey('checkOutAt') ||
                                          userSubEventData['checkOutAt'] ==
                                              null)) {
                                    userSubEventDocRef
                                        .update({'checkOutAt': DateTime.now()});
                                    showUpdate(barcode, user);
                                  }
                                } else {
                                  if (!isSingleAccessType &&
                                      widget.scanMode == ScanMode.checkOut) {
                                    userWithoutCheckIn.add(user.id);
                                    processing = false;
                                    showToast(
                                        '${user.name} ${user.surname} non ha effettuato il check in!',
                                        duration: const Duration(seconds: 1),
                                        position: ToastPosition.bottom);
                                    return;
                                  }

                                  if (isSingleAccessType &&
                                      widget.scanMode == ScanMode.checkOut) {
                                    user = user.copyWith(
                                        checkOutAt: DateTime.now());
                                  } else if (!isSingleAccessType &&
                                      widget.scanMode == ScanMode.checkIn) {
                                    user = user.copyWith(
                                        checkInAt: DateTime.now());
                                  }

                                  userSubEventDocRef.set(user.toJson());
                                  showUpdate(barcode, user);
                                }

                                final userRef = Cloud.eventUsersCollection(
                                        EventIds(
                                            providerId: widget.provider.id,
                                            eventId: eventId))
                                    .doc(user.id);
                                final globalUserDoc = await userRef.get();
                                if (!globalUserDoc.exists) {
                                  final u = user.toJson();
                                  u.remove('checkOutAt');
                                  u.remove('checkInAt');
                                  userRef.set(u, SetOptions(merge: true));
                                }
                                processing = false;
                                list.add(userQrCode.id);
                              } else {
                                showToast('Utente già scansionato',
                                    duration: const Duration(milliseconds: 250),
                                    position: ToastPosition.bottom);
                              }
                            }
                          } catch (ex) {
                            processing = false;
                            showToast('QR-Code non valido',
                                position: ToastPosition.bottom);
                          }
                        }
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: lastUser != null ? Colors.green : Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (kDebugMode && result != null)
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.rawValue}'),
                        const SizedBox(height: 8),
                        Text(
                          lastUser != null
                              ? '${lastUser!.name} ${lastUser!.surname} ${lastUser!.cf}'
                              : 'SCAN QR CODE',
                          textAlign: lastUser != null
                              ? TextAlign.start
                              : TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(
                        enumToString(widget.scanMode)?.toUpperCase() ?? ''),
                  )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Text(count.toString()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
