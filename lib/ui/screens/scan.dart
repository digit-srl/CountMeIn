import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:oktoast/oktoast.dart';
import 'package:countmein/ui/screens/admin.dart';

import '../../cloud.dart';
import '../../constants.dart';
import '../../domain/entities/activity.dart';
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/user_card.dart';
import 'package:soundpool/soundpool.dart';

import '../../domain/entities/user_qr_code.dart';

// uof%gian marco%di francesco%DFRGMR89M02I348U%uof

final usersCountProvider =
    Provider.autoDispose.family<int, EventIds>((ref, ids) {
  return ref.watch(usersStreamProvider(ids)).asData?.value.length ?? 0;
});

class ScanScreen extends ConsumerStatefulWidget {
  final String eventId;
  final Activity activity;

  const ScanScreen({
    Key? key,
    required this.eventId,
    required this.activity,
  }) : super(key: key);

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  bool processing = false;
  final list = <String>[];

  UserCard? lastUSer;

  late EventIds ids;

  @override
  void initState() {
    super.initState();
    ids = EventIds(activityId: widget.activity.id, eventId: widget.eventId);
    loadSound();
  }

  @override
  void dispose() {
    pool.dispose();
    super.dispose();
  }

  int? soundId;
  late Soundpool pool;

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
                      onDetect: (barcode, args) {
                        final data = barcode.rawValue;

                        if (processing) return;

                        if (data != null) {
                          print('detected data');

                          try {
                            final userQrCode = UserQrCode.fromOldQrCode(data);

                            if (userQrCode.activityId == widget.activity.id ||
                                (widget.activity.acceptPassepartout &&
                                    userQrCode.activityId ==
                                        'wom-count-me-in')) {
                              if (!list.contains(userQrCode.id)) {
                                processing = true;
                                if (soundId != null) {
                                  pool.play(soundId!);
                                }

                                /*   Future.delayed(Duration(seconds: 3), () {
                                  setState(() {
                                    result = barcode;
                                    lastUSer = user;
                                  });
                                  Future.delayed(Duration(seconds: 1), () {
                                    setState(() {
                                      result = null;
                                      lastUSer = null;
                                    });
                                  });
                                  processing = false;
                                  list.add(userId);

                                  showToast(
                                      '${user.name} ${user.surname} aggiunto al database',
                                      position: ToastPosition.bottom);
                                });*/

                                final user = userQrCode.toUserCard();
                                Cloud.eventUsersCollection(
                                        widget.activity.id, widget.eventId)
                                    .doc(user.id)
                                    .set(user.toJson(), SetOptions(merge: true))
                                    .then((value) {
                                  setState(() {
                                    result = barcode;
                                    lastUSer = user;
                                  });
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    setState(() {
                                      result = null;
                                      lastUSer = null;
                                    });
                                  });
                                  processing = false;
                                  list.add(userQrCode.id);

                                  showToast(
                                      '${user.name} ${user.surname} aggiunto al database',
                                      position: ToastPosition.bottom);
                                });
                              } else {
                                print('utente gia in lista');
                                // showToast(
                                //     'Utente già in lista',
                                //     position: ToastPosition.bottom);
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
                      color: lastUSer != null ? Colors.green : Colors.white,
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
                            lastUSer != null
                                ? '${lastUSer!.name} ${lastUSer!.surname} ${lastUSer!.cf}'
                                : 'SCAN QR CODE',
                            textAlign: lastUSer != null
                                ? TextAlign.start
                                : TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
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
