import 'dart:async';
import 'dart:typed_data';

import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/scan_notifier.dart';
import 'package:countmein/src/admin/application/users_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/ui/screens/event_details.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:oktoast/oktoast.dart';
import 'package:soundpool/soundpool.dart';

import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/user_card.dart';
import 'package:collection/collection.dart';

final mobileScannerControllerProvider =
    Provider.autoDispose<MobileScannerController>((ref) {
  final c =
      MobileScannerController(facing: CameraFacing.back, torchEnabled: false);
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});
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

  final Duration messageDuration = const Duration(seconds: 2);

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

  String? error;
  String? message;
  ScanStatus? scanStatus;
  bool waitingTimer = false;

  onError(EventUser? user, String message) {
    if (waitingTimer) return;
    setState(() {
      error = message;
    });
    waitingTimer = true;
    Future.delayed(messageDuration, () {
      waitingTimer = false;
      reset();
    });
  }

  onMessage(EventUser? user, String m) {
    if (waitingTimer) return;
    setState(() {
      message = m;
    });
    waitingTimer = true;
    Future.delayed(messageDuration, () {
      waitingTimer = false;
      reset();
    });
  }

  onMessage2(EventUser? user, ScanStatus s) {
    if (soundId != null) {
      pool.play(soundId!);
    }
    // if (waitingTimer) return;
    setState(() {
      lastUser = user;
      scanStatus = s;
    });
    // waitingTimer = true;
    Future.delayed(messageDuration, () {
      // waitingTimer = false;
      reset();
    });
  }

  showUpdate(Barcode? barcode, EventUser user) {
    if (soundId != null) {
      pool.play(soundId!);
    }
    setState(() {
      result = barcode;
      lastUser = user;
      error = null;
      message = null;
    });
    showToast('${user.name} ${user.surname} aggiunto al database',
        duration: const Duration(milliseconds: 250),
        position: ToastPosition.bottom);

    if (waitingTimer) return;
    logger.i('ScanScreen set timer');
    waitingTimer = true;
    Future.delayed(messageDuration, () {
      logger.i('ScanScreen reset info');
      waitingTimer = false;
      reset();
    });
  }

  reset() {
    setState(() {
      result = null;
      scanStatus = null;
      lastUser = null;
      message = null;
    });
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
    final scanner = ref.watch(mobileScannerControllerProvider);
    ref.listen(scanControllerProvider(ids.eventId), (previous, next) {});
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: MobileScanner(
                    controller: scanner,
                    errorBuilder: (context, exception, child){
                      return Center(child: Text(exception.errorDetails?.message.toString() ?? ''));
                    },
                    onDetect: (BarcodeCapture barcodeCapture) {
                      final barcode = barcodeCapture.barcodes.firstOrNull;
                      if (barcode == null || barcode.rawValue == null) return;
                      ref
                          .read(scanControllerProvider(widget.event.id))
                          .processScan3(
                            barcode.rawValue!,
                            widget.provider,
                            widget.event,
                            widget.scanMode,
                            onMessage: onMessage2,
                            // onUpdate: (user) => showUpdate(barcode, user),
                            // onError: onError,
                          );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: scanStatus != null
                        ? scanStatus!.color
                        : lastUser != null
                            ? Colors.green
                            : Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!kDebugMode && result != null)
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)}  Data: ${result!.rawValue}'),
                        const SizedBox(height: 8),
                        if (scanStatus != null) ...[
                          Text(scanStatus!.message),
                          if (lastUser != null)
                            Text(
                              lastUser!.isAnonymous
                                  ? 'AGGIUNTO Utente anonimo'
                                  : '${lastUser!.isGroup ? 'GRUPPO ' : ''}AGGIUNTO\n${lastUser!.name} ${lastUser!.surname}\n${lastUser!.cf}',
                              textAlign: lastUser != null
                                  ? TextAlign.start
                                  : TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ] else
                          Text(
                            'SCAN QR CODE',
                            textAlign: lastUser != null
                                ? TextAlign.start
                                : TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        // if (error == null && message == null)
                        //   if (lastUser != null)
                        //     Text(
                        //       lastUser!.isAnonymous
                        //           ? 'AGGIUNTO\nUtente anonimo'
                        //           : '${lastUser!.isGroup ? 'GRUPPO ' : ''}AGGIUNTO\n${lastUser!.name} ${lastUser!.surname}\n${lastUser!.cf}',
                        //       textAlign: lastUser != null
                        //           ? TextAlign.start
                        //           : TextAlign.center,
                        //       style: const TextStyle(
                        //         fontSize: 22,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     )
                        //   else
                        //     Text(
                        //       'SCAN QR CODE',
                        //       textAlign: lastUser != null
                        //           ? TextAlign.start
                        //           : TextAlign.center,
                        //       style: const TextStyle(
                        //         fontSize: 24,
                        //         color: Colors.green,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     )
                        // else
                        //   Text(
                        //     error ?? message ?? '',
                        //     style: const TextStyle(
                        //         color: Colors.white, fontSize: 24),
                        //   ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            if (kDebugMode)
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.developer_mode),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (c) {
                        return Dialog(
                          child: ScanSimulationWidget(
                            event: widget.event,
                            provider: widget.provider,
                            onScan: (url) {
                              ref
                                  .read(scanControllerProvider(widget.event.id))
                                  .processScan3(
                                    url,
                                    widget.provider,
                                    widget.event,
                                    widget.scanMode,
                                    onMessage: onMessage2,
                                  );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            if (widget.event.accessType != EventAccessType.single)
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
