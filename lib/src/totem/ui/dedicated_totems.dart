import 'package:countmein/src/totem/ui/totem_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DedicatedTotemsCardWidget extends ConsumerWidget {
  final String providerId;
  final String eventId;
  final String? sessionId;

  const DedicatedTotemsCardWidget({
    required this.providerId, required this.eventId, required this.sessionId, super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems = ref
            .watch(getTotemsByEventProvider(providerId, eventId, true))
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
              return TotemCardWidget(
                providerId: providerId,
                totem: totems[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
