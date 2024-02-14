import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:countmein/src/totem/ui/totems.dart';
import 'package:flutter/material.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/src/totem/util.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class TotemCardWidget extends StatelessWidget {
  final EmbeddedData totem;
  final String providerId;

  const TotemCardWidget({
    super.key,
    required this.providerId,
    required this.totem,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/embedded/$providerId/${totem.id}');
      },
      child: Card(
        color: Colors.red[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton<QrCodeAction>(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<QrCodeAction>>[
                    PopupMenuItem<QrCodeAction>(
                      value: QrCodeAction.copyQrCodeLink,
                      enabled: false,
                      child: const Text('Copia link pagina'),
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text: getTotemScreenURL(providerId, totem.id)));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Link ${totem.name} copiato negli appunti',
                            ),
                          ),
                        );
                      },
                    ),
                    PopupMenuItem<QrCodeAction>(
                      value: QrCodeAction.copyQrCode,
                      child: const Text('Copia QR-Code'),
                      onTap: () {
                        final qr = getTotemQRCode(
                            providerId, totem.id, totem.requestId);
                        Clipboard.setData(ClipboardData(
                          text: qr,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'QR-Code ${totem.name} copiato negli appunti'),
                          ),
                        );
                      },
                    ),
                    PopupMenuItem<QrCodeAction>(
                      value: QrCodeAction.resetCounters,
                      child: const Text('Reset contatori'),
                      onTap: () {
                        Cloud.totemDoc(providerId, totem.id).update({
                          'count': 0,
                          'totalCount': 0,
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(totem.name),
            Text('${totem.count}/${totem.totalCount}'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
