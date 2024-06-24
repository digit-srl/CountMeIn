import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignTotemDialog extends HookConsumerWidget {
  final String providerId;
  final String eventId;
  final String sessionId;
  final String? eventName;
  final String? sessionName;

  const AssignTotemDialog({
    required this.providerId, required this.eventId, required this.eventName, required this.sessionName, required this.sessionId, super.key,
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
            CMIDropdownButton<String>(
              value: selectedTotem.value?.id,
              label: 'Seleziona Totem',
              items: totems
                  .map((e) => DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.name),
                      ),)
                  .toList(),
              onChanged: (value) {
                selectedTotem.value =
                    totems.firstWhere((element) => element.id == value);
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
                          Cloud.totemDoc(providerId, selectedTotem.value!.id),
                          {
                            'eventId': eventId,
                            'sessionId': sessionId,
                            'eventName': eventName,
                            'sessionName': sessionName,
                          },
                          SetOptions(merge: true),);

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
