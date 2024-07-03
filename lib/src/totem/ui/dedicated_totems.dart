import 'package:countmein/src/admin/ui/screens/new_totem.dart';
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
  final String eventName;
  final int womCount;
  final String? activeSessionName;
  final String? activeSessionId;

  const DedicatedTotemsCardWidget({
    required this.providerId,
    required this.eventId,
    required this.eventName,
    required this.womCount,
    required this.activeSessionId,
    required this.activeSessionName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems = ref
            .watch(getTotemsByEventProvider(providerId, eventId, true))
            .valueOrNull ??
        [];
    return CMICard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Totem dedicati',
            style: TextStyle(fontSize: 26),
          ),
          if (womCount == 0)
            const Text(
              'Un evento che non rilascia WOM non può creare totem!',
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          GenericGridViewBuilder(
            itemCount: totems.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                if (activeSessionId == null) {
                  return const SizedBox.shrink();
                }
                return CMICard(
                  enabled: womCount > 0,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => NewTotemDialog(
                        providerId: providerId,
                        eventId: eventId,
                        eventName: eventName,
                        activeSessionId: activeSessionId,
                        activeSessionName: activeSessionName,
                        isDedicated: true,
                      ),
                    );
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.add,
                        size: 50,
                      ),
                      Text('Nuovo Totem'),
                    ],
                  ),
                );
              }
              return TotemCardWidget(
                providerId: providerId,
                totem: totems[index - 1],
              );
            },
          ),
        ],
      ),
    );
  }
}
