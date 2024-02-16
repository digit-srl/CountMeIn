import 'package:countmein/cloud.dart';
import 'package:countmein/constants.dart';
import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/ui/totem_card.dart';
import 'package:countmein/src/totem/util.dart';
import 'package:countmein/ui/widgets/cmi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum QrCodeAction {
  goToQrCode,
  copyQrCodeLink,
  copyQrCode,
  resetCounters,
  deleteTotem,
}

class AssignedTotemsWidget extends ConsumerWidget {
  final String providerId;
  final String eventId;

  const AssignedTotemsWidget({
    super.key,
    required this.providerId,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems = ref
            .watch(
                getTotemsByEventProvider(providerId, eventId, false))
            .valueOrNull ??
        [];
    if (totems.isEmpty) return const SizedBox.shrink();
    return CMICard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Totem assegnati',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 16),
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
