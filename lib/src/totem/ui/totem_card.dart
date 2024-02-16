import 'package:countmein/src/admin/ui/screens/new_totem.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:countmein/src/totem/ui/totems.dart';
import 'package:countmein/ui/widgets/cmi_chip.dart';
import 'package:flutter/material.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/src/totem/util.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../utils.dart';

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
        showDialog(
          context: context,
          builder: (context) => NewTotemDialog(
            providerId: providerId,
            totemId: totem.id,
          ),
        );
      },
      child: Card(
        color: Colors.blueGrey[600],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        value: QrCodeAction.goToQrCode,
                        enabled: true,
                        child: const Text('Vai alla pagina'),
                        onTap: () {
                          context.go('/embedded/$providerId/${totem.id}');
                        },
                      ),
                      PopupMenuItem<QrCodeAction>(
                        value: QrCodeAction.copyQrCodeLink,
                        enabled: true,
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
                          //TODO dobbiamo scollegare il totem dalla sessione?
                          Cloud.totemDoc(providerId, totem.id).update({
                            'count': 0,
                            'totalCount': 0,
                          });
                        },
                      ),
                      PopupMenuItem<QrCodeAction>(
                        value: QrCodeAction.deleteTotem,
                        enabled: true,
                        child: const Text(
                          'Elimina',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () async {
                          final res = await ask(context,
                              'Sicuro di voler eliminare questo totem?');
                          if (res ?? false) {
                            Cloud.totemDoc(providerId, totem.id).delete();
                          }
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
              Row(
                children: [
                  if (totem.isStatic) ...[
                    CMIChip(
                      text: 'Statico',
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 4),
                  ],
                  if (!totem.dedicated && totem.eventId != null)
                    CMIChip(
                      text: 'Assegnato',
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
