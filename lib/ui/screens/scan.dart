import 'dart:async';
import 'dart:typed_data';

import 'package:countmein/src/admin/application/scan_notifier.dart';
import 'package:countmein/src/admin/application/users_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
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
                    onDetect: (barcode, args) {
                      final data = barcode.rawValue;
                      if (data == null) return;
                      ref.read(scanControllerProvider(widget.event.id)).processScan2(
                            data,
                            widget.provider,
                            widget.event,
                            widget.scanMode,
                            (user) => showUpdate(barcode, user),
                          );
                    },
                  ),
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
