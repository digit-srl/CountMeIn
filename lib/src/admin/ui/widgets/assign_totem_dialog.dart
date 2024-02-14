import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/src/common/ui/cmi_date_picker.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignTotemDialog extends HookConsumerWidget {
  final String providerId;
  final String eventId;
  final String sessionId;

  const AssignTotemDialog({
    super.key,
    required this.providerId,
    required this.eventId,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems =
        ref.watch(getAvailableTotemsProvider(providerId)).valueOrNull ?? [];
    final selectedTotem = useState<EmbeddedData?>(null);
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CMIDropdownButton<EmbeddedData>(
              value: selectedTotem.value,
              label: 'Seleziona Totem',
              items: totems
                  .map((e) => DropdownMenuItem<EmbeddedData>(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedTotem.value = value;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: selectedTotem.value != null
                  ? () async {
                      if (selectedTotem.value == null) return;
                      final nav = Navigator.of(context);
                      final batch = FirebaseFirestore.instance.batch();
                      batch.set(
                          Cloud.totemDoc(
                              providerId, selectedTotem.value!.id),
                          {
                            'eventId': eventId,
                            'sessionId': sessionId,
                          },
                          SetOptions(merge: true));

                      await batch.commit();
                      nav.pop();
                    }
                  : null,
              child: const Text('Salva'),
            ),
          ],
        ),
      ),
    );
  }
}
