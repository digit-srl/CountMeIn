import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/src/admin/ui/screens/new_event.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:countmein/ui/validators.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';


class NewTotemDialog extends ConsumerWidget {
  final String providerId;
  final String? totemId;

  const NewTotemDialog({
    required this.providerId,
    this.totemId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EmbeddedData? initialTotem;
    if (totemId != null) {
      initialTotem =
          ref.watch(getTotemDataProvider(providerId, totemId!)).value;
    }
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        padding: const EdgeInsets.all(16),
        child: totemId == null || initialTotem != null
            ? _NewTotemDialogWidget(
                providerId: providerId,
                totem: initialTotem,
              )
            : null,
      ),
    );
  }
}

class _NewTotemDialogWidget extends HookConsumerWidget {
  final String providerId;
  final EmbeddedData? totem;
  static const String routeName = 'new-totem';

  const _NewTotemDialogWidget({
    required this.providerId,
    this.totem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final totemController = useTextEditingController(text: totem?.name);
    final radiusController =
        useTextEditingController(text: totem?.radius.toString() ?? '100');
    final latController =
        useTextEditingController(text: totem?.position?.latitude.toString());
    final longController =
        useTextEditingController(text: totem?.position?.longitude.toString());
    final isStatic = useState<bool>(totem?.isStatic ?? true);
    final isLinked = useState<bool>(totem?.eventId != null);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              '${totem != null ? '' : 'Nuovo '}Totem ${totem != null ? totem!.dedicated ? 'Dedicato' : 'Indipendente' : ''}',),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: totemController,
                  validator: nameSurnameValidator.call,
                  decoration: const InputDecoration(
                      hintText: 'Inserisci il nome per il tuo totem',),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Statico'),
                  Switch(
                    value: isStatic.value,
                    onChanged: totem != null
                        ? null
                        : (value) {
                            isStatic.value = value;
                          },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!(totem?.dedicated ?? false))
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: latController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,8}'),),
                    ],
                    decoration: const InputDecoration(hintText: 'Latitude'),
                    validator: latitudeValidator,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TextFormField(
                    controller: longController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,8}'),),
                    ],
                    decoration: const InputDecoration(hintText: 'Longitude'),
                    validator: longitudeValidator,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TextFormField(
                    controller: radiusController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        hintText: 'Raggio', suffixText: 'metri',),
                    validator: radiusValidator,
                  ),
                ),
              ],
            ),
          if (isLinked.value && !(totem?.dedicated ?? true)) ...[
            const SizedBox(height: 8),
            InfoText(
              label: 'Evento Collegato:',
              value: totem?.eventName ?? totem?.eventId,
            ),
            InfoText(
              label: 'Sessione:',
              value: totem!.sessionName ?? totem!.sessionId!,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text(
                  'Rimuovi collegamento',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () async {
                  if (totem?.id == null) return;
                  final res = await ask(context,
                      'Sicuro di voler rimuove il collegamento dell\'evento?',);
                  if (res ?? false) {
                    isLinked.value = false;
                    Cloud.totemDoc(providerId, totem!.id).update({
                      'eventId': null,
                      'sessionId': null,
                      'eventName': null,
                      'sessionName': null,
                    });
                  }
                },
              ),
            ),
          ],
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  final position = latController.text.trim().isNotEmpty &&
                          longController.text.trim().isNotEmpty
                      ? GeoPoint(double.parse(latController.text.trim()),
                          double.parse(longController.text.trim()),)
                      : null;

                  final t = EmbeddedData(
                    name: totemController.text.trim(),
                    id: totem?.id ?? const Uuid().v4(),
                    isStatic: isStatic.value,
                    requestId: isStatic.value ? null : 'abcded',
                    position: position,
                    eventId: totem?.eventId,
                    sessionId: totem?.sessionId,
                    eventName: totem?.eventName,
                    sessionName: totem?.sessionName,
                    totalCount: totem?.totalCount ?? 0,
                    count: totem?.count ?? 0,
                    updatedOn: DateTime.now(),
                    dedicated: totem?.dedicated ?? false,
                    radius: int.parse(radiusController.text.trim()),
                  );

                  final navigator = Navigator.of(context);

                  final batch = FirebaseFirestore.instance.batch();

                  batch.set(
                    Cloud.totemDoc(
                      providerId,
                      t.id,
                    ),
                    t.toJson(),
                    SetOptions(merge: true),
                  );

                  await batch.commit();
                  navigator.pop();
                }
              },
              child: Text(totem != null ? 'Salva' : 'Crea totem'),
            ),
          ),
        ],
      ),
    );
  }
}
