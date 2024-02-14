import 'package:countmein/src/totem/ui/totems.dart';
import 'package:countmein/src/totem/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/constants.dart';
import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/ui/widgets/cmi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DedicatedTotemsCardWidget extends ConsumerWidget {
  final String providerId;
  final String eventId;
  final String? sessionId;

  const DedicatedTotemsCardWidget({
    super.key,
    required this.providerId,
    required this.eventId,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems = ref
            .watch(
                getTotemsByEventProvider(providerId, eventId, dedicated: true))
            .valueOrNull ??
        [];
    if (totems.isEmpty) return const SizedBox.shrink();
    return CMICard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Totem dedicati',
            style: TextStyle(fontSize: 26),
          ),
          GenericGridViewBuilder(
            itemCount: totems.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
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
                              enabled: sessionId != null,
                              value: QrCodeAction.goToQrCode,
                              child: const Text('Vai alla pagina'),
                              onTap: () {
                                context.go(
                                    '/embedded/$providerId/${totems[index].id}');
                              },
                            ),
                            PopupMenuItem<QrCodeAction>(
                              value: QrCodeAction.copyQrCodeLink,
                              enabled: sessionId != null,
                              child: const Text('Copia link pagina'),
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text:
                                        'https://cmi.digit.srl//embedded/$providerId/${totems[index].id}'));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Link ${totems[index].name} copiato negli appunti')));
                              },
                            ),
                            PopupMenuItem<QrCodeAction>(
                              value: QrCodeAction.copyQrCode,
                              child: const Text('Copia QR-Code'),
                              onTap: () {
                                final qr = getTotemQRCode(providerId,
                                    totems[index].id, totems[index].requestId);
                                Clipboard.setData(ClipboardData(
                                  text: qr,
                                ));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'QR-Code ${totems[index].name} copiato negli appunti')));
                              },
                            ),
                            PopupMenuItem<QrCodeAction>(
                              value: QrCodeAction.resetCounters,
                              child: const Text('Reset contatori'),
                              onTap: () {
                                Cloud.totemDoc(
                                  providerId,
                                  totems[index].id,
                                ).update({
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
                    Text(totems[index].name),
                    Text('${totems[index].count}/${totems[index].totalCount}'),
                    if (totems[index].isStatic)
                      const CMIChip(
                        text: 'STATICO',
                        color: Colors.purple,
                      ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
