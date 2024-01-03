import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TotemsCardWidget extends ConsumerWidget {
  final String providerId;
  final String eventId;
  final String sessionId;

  const TotemsCardWidget({
    Key? key,
    required this.providerId,
    required this.eventId,
    required this.sessionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems = ref
            .watch(getTotemsProvider(providerId, eventId))
            .valueOrNull ??
        [];
    if (totems.isEmpty) return const SizedBox.shrink();
    return CMICard(
      child: GenericGridViewBuilder(
        itemCount: totems.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text:
                      'https://cmi.digit.srl//embedded/$providerId/$eventId/$sessionId/${totems[index].id}'));
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Link ${totems[index].name} copiato negli appunti')));
            },
            child: Card(
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(totems[index].name),
                  Text('Contatore: ${totems[index].count}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
