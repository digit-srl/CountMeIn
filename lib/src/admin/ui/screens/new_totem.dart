import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/screens/new_event.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:countmein/ui/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

class NewTotemScreen extends HookConsumerWidget {
  final String providerId;
  final String? totemId;
  static const String routeName = "new-totem";

  const NewTotemScreen({
    super.key,
    required this.providerId,
    this.totemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    EmbeddedData? initialTotem;
    if (totemId != null) {
      initialTotem = ref
          .watch(getProviderTotemsProvider(providerId))
          .value
          ?.firstWhereOrNull((t) => t.id == totemId);
    }
    final totemController =
        useTextEditingController(text: initialTotem?.name ?? 'Totem');
    final radiusController = useTextEditingController(
        text: initialTotem?.radius.toString() ?? '100');
    final latController = useTextEditingController(
        text: initialTotem?.position?.latitude.toString());
    final longController = useTextEditingController(
        text: initialTotem?.position?.longitude.toString());
    final events =
        ref.watch(eventsStreamProvider(providerId)).valueOrNull ?? [];
    final initialSelectedEvent =
        events.firstWhereOrNull((e) => e.id == initialTotem?.eventId);
    final selectedEvent = useState<CMIEvent?>(initialSelectedEvent);
    final isStatic = useState<bool>(initialTotem?.isStatic ?? true);
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: 700),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: totemController,
                      validator: nameSurnameValidator,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Statico'),
                      Switch(
                        value: isStatic.value,
                        onChanged: (value) {
                          isStatic.value = value;
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: latController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,8}'))
                      ],
                      decoration: const InputDecoration(hintText: 'Latitude'),
                      validator: geoValidator,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: TextFormField(
                      controller: longController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,8}'))
                      ],
                      decoration: const InputDecoration(hintText: 'Longitude'),
                      validator: geoValidator,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: TextFormField(
                      controller: radiusController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                          hintText: 'Raggio', suffixText: 'metri'),
                      validator: geoValidator,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              /*        Row(
                children: [
                  Text('WOM', style: titleStyle),
                  Switch(
                      value: releaseWom.value,
                      onChanged: totemEnabled.value
                          ? null
                          : (v) {
                              releaseWom.value = v;
                            }),
                ],
              ),
              if (totemEnabled.value)
                const Text(
                  'I WOM sono obbligatori con i totem',
                  style: TextStyle(color: Colors.orange),
                ),
              if (releaseWom.value) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: CMITextField(
                        controller: womController,
                        keyboardType: TextInputType.number,
                        hintText: accessType.value == EventAccessType.inOut
                            ? 'Numero max di wom da rilasciare'
                            : 'Quanti wom rilasciare?',
                        validator: womValidator,
                      ),
                    ),
                    if (provider?.aims != null && provider!.aims!.isNotEmpty) ...[
                      const SizedBox(width: 16),
                      Flexible(
                        child: CMIDropdownButton<String>(
                          label: 'Seleziona l\'AIM',
                          value: selectedAim.value,
                          items: provider.aims!
                              .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(aims
                                          ?.firstWhereOrNull((a) => a.code == e)
                                          ?.title(languageCode: 'it') ??
                                      e)))
                              .toList(),
                          onChanged: (item) {
                            selectedAim.value = item;
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ],
              const SizedBox(height: 16),*/
              // DropdownButtonFormField<CMIEvent>(
              //   value: selectedEvent.value,
              //   items: events
              //       .map<DropdownMenuItem<CMIEvent>>(
              //         (e) => DropdownMenuItem(
              //           value: e,
              //           child: Text(e.name),
              //         ),
              //       )
              //       .toList(),
              //   onChanged: (value) {
              //     selectedEvent.value = value;
              //   },
              // ),
              // const SizedBox(height: 16),
              // CMICard(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              //       InfoText(
              //         label: 'Evento',
              //         value: selectedEvent.value?.name,
              //       ),
              //       Row(
              //         children: [
              //
              //           InfoText(
              //             label: 'WOM',
              //             value: selectedEvent.value?.maxWomCount.toString(),
              //           ),
              //           const SizedBox(width: 16),
              //           InfoText(
              //             label: 'AIM',
              //             value: selectedEvent.value?.aim,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!(formKey.currentState?.validate() ?? false)) {
                    return;
                  }

                  final position = latController.text.trim().isNotEmpty &&
                          longController.text.trim().isNotEmpty
                      ? GeoPoint(double.parse(latController.text.trim()),
                          double.parse(longController.text.trim()))
                      : null;

                  final totem = EmbeddedData(
                    name: totemController.text.trim(),
                    id: initialTotem?.id ?? const Uuid().v4(),
                    isStatic: isStatic.value,
                    requestId: isStatic.value ? null : 'abcded',
                    position: position,
                    eventId: selectedEvent.value?.id,
                    updatedOn: DateTime.now(),
                    dedicated: false,
                    radius: int.parse(radiusController.text.trim()),
                  );
                  final navigator = Navigator.of(context);

                  final batch = FirebaseFirestore.instance.batch();

                  batch.set(
                    Cloud.totemDoc(
                      providerId,
                      totem.id,
                    ),
                    totem.toJson(),
                  );

                  await batch.commit();
                  navigator.pop();
                },
                child: Text(initialTotem != null ? 'Salva' : 'Crea totem'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
