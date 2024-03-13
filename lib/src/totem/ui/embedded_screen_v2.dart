import 'dart:math';

import 'package:countmein/my_logger.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/util.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:universal_io/io.dart';

final dateFormat = DateFormat('dd MMMM yyyy HH:mm');

class EmbeddedScreen2 extends ConsumerStatefulWidget {
  final String totemId;

  final String providerId;

  const EmbeddedScreen2({
    super.key,
    required this.totemId,
    required this.providerId,
  });

  @override
  ConsumerState<EmbeddedScreen2> createState() => _EmbeddedScreen2State();
}

class _EmbeddedScreen2State extends ConsumerState<EmbeddedScreen2> {
  final screenshotController = ScreenshotController();

  Future<void> downloadQRCode(String totemId) async {
    await screenshotController
        .capture(pixelRatio: 2, delay: const Duration(milliseconds: 10))
        .then((Uint8List? bytes) async {
      if (bytes != null) {
        // final directory = await getApplicationDocumentsDirectory();
        // final imagePath = await File('${directory.path}/$totemId.png').create();
        // await imagePath.writeAsBytes(image);

        if (Platform.isMacOS || kIsWeb) {
          final path = await FileSaver.instance.saveFile(
              name: totemId, bytes: bytes, mimeType: MimeType.png, ext: 'png');
          logger.i(path);
        } else {
          throw Exception('only macos and web are supported');
          // await Share.shareFiles([imagePath.path]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state =
        ref.watch(getTotemDataProvider(widget.providerId, widget.totemId));
    final totem = state.valueOrNull;
    final size = MediaQuery.sizeOf(context);
    final width = min(size.width, size.height) / 2;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (totem != null && totem.isStatic) ...[
            IconButton(
              icon: const Icon(Icons.download),
              color: Colors.white,
              onPressed: () {
                downloadQRCode(totem.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              color: Colors.white,
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text: getTotemQRCode(
                        widget.providerId, totem.id, totem.requestId)));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Link ${totem.name} copiato negli appunti',
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
      body: Center(
        child: state.when(
          data: (data) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.name,
                style: const TextStyle(fontSize: 26),
              ),
              Text('Scansioni: ${data.count}'),
              const SizedBox(height: 16),
              Screenshot(
                controller: screenshotController,
                child: SizedBox(
                  width: width,
                  height: width,
                  child: QrImageView(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    data: getTotemQRCode(
                        widget.providerId, widget.totemId, data.requestId),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('aggiornato il ${dateFormat.format(data.updatedOn)}'),
            ],
          ),
          error: (e, s) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
