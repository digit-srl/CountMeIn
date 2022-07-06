import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/user_card.dart';

class UserQRCodeScreen extends ConsumerWidget {
  final UserCard user;
  final CMIProvider session;

  const UserQRCodeScreen({
    Key? key,
    required this.user,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 32),
          Text(
            session.name,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          UserCardDialog(
            user: user,
            activity: session,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  Hive.box('user').clear();
                },
                child: Text('Resetta utente')),
          ),
          /*TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (c) => Dialog(
                    child: UserCardDialog(
                      user: user,
                      session: session,
                    ),
                  ),
                );
              },
              child: Text('Genera card')),*/
        ],
      ),
    );
  }
}

class UserCardDialog extends StatefulWidget {
  final UserCard user;
  final CMIProvider activity;

  const UserCardDialog({Key? key, required this.user, required this.activity})
      : super(key: key);

  @override
  State<UserCardDialog> createState() => _UserCardDialogState();
}

class _UserCardDialogState extends State<UserCardDialog> {
  final key = GlobalKey();
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.grey, fontSize: 10);
    const dataStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Card(
                child: RepaintBoundary(
                  key: key,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.activity.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              height: 120,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  QrImage(
                                    data: widget.user.qrCodeUrl(widget.activity.id),
                                    version: QrVersions.auto,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.stretch,
                                    children: [
                                      Text('Nome', style: labelStyle),
                                      Text(widget.user.name, style: dataStyle),
                                      const SizedBox(height: 8),
                                      Text('Cognome', style: labelStyle),
                                      Text(widget.user.surname,
                                          style: dataStyle),
                                      const SizedBox(height: 8),
                                      Text('C.F.', style: labelStyle),
                                      Text(
                                        widget.user.cf.toUpperCase(),
                                        style: dataStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                final bytes = await captureImage();
                if (bytes == null) return;
                await FileSaver.instance.saveFile('my_card_1', bytes, 'png',
                      mimeType: MimeType.PNG);

                /*final fileSaverPlugin = FlutterFileSaver();
                 final path= await fileSaverPlugin.writeFileAsBytes(
                    fileName: 'my_card_2.png',
                    bytes: bytes,
                  );
                 print(path);

                js.context.callMethod("webSaveAs", [
                  html.Blob([bytes]),
                  "my_card_3js.png"
                ]);

                saveFile();*/
              },
              child: Text('Download card')),
        ],
      ),
    );
  }

  Future<Uint8List?> captureImage() async {
    double pixelRatio = 5;
    try {
      RenderRepaintBoundary? boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: pixelRatio);
      ByteData? byteData =
          await image?.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

/*  saveFile() async {
    RenderRepaintBoundary? boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image? image = await boundary?.toImage(pixelRatio: 5);
    ByteData? byteData =
        await image?.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    if (pngBytes == null) return;
    final blob = html.Blob([pngBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'my_card_4.png';
    html.document.body?.children.add(anchor);

// download
    anchor.click();

// cleanup
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }*/
}
