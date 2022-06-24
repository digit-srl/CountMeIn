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
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/user_card.dart';
import 'package:soundpool/soundpool.dart';

// uof%gian marco%di francesco%DFRGMR89M02I348U%uof

final usersCountProvider =
    Provider.autoDispose.family<int, EventIds>((ref, ids) {
  return ref.watch(usersStreamProvider(ids)).asData?.value.length ?? 0;
});

class ScanScreen extends ConsumerStatefulWidget {
  final String eventId;
  final String activityId;

  const ScanScreen({
    Key? key,
    required this.eventId,
    required this.activityId,
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
    ids = EventIds(activityId: widget.activityId, eventId: widget.eventId);
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

                        if (data != null &&
                            data.startsWith(qrCodePrefix) &&
                            data.endsWith(qrCodePrefix)) {
                          print('detected data');

                          final split = data.split('%');
                          if (split.length == 7) {
                            print(split);
                            print(split.length);
                            final userId = split[1];
                            final name = split[2];
                            final surname = split[3];
                            final cf = split[4];
                            final activityId = split[5];

                            print('activityId: $activityId');

                            if (activityId == widget.activityId) {
                              if (!list.contains(userId)) {
                                processing = true;
                                if (soundId != null) {
                                  pool.play(soundId!);
                                }

                                final user = UserCard(
                                  name: name,
                                  surname: surname,
                                  cf: cf,
                                  id: userId,
                                  addedOn: DateTime.now(),
                                );

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

                                Cloud.eventUsersCollection(
                                        widget.activityId, widget.eventId)
                                    .doc(user.id)
                                    .set(user.toJson(), SetOptions(merge: true))
                                    .then((value) {
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
                                });
                              } else {
                                print('utente gia in lista');
                                // showToast(
                                //     'Utente già in lista',
                                //     position: ToastPosition.bottom);
                              }
                            }
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
