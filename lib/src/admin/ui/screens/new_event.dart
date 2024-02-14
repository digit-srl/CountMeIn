import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:dart_wom_connector/dart_wom_connector.dart';
import 'package:countmein/src/admin/application/aim_notifier.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/common/ui/cmi_date_picker.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:countmein/cloud.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';
import '../../../../ui/validators.dart';
import 'package:intl/intl.dart';

final womValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  RangeValidator(
      min: 1,
      max: 1000,
      errorText: 'Il valore deve essere compreso tra 1 e 100'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

String? geoValidator(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  if (double.tryParse(value) == null) {
    return 'Valore non valido';
  }
  return null;
}

final acceptPassepartoutProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

class NewEventFormScreen extends HookConsumerWidget {
  static const String routeName = "create-event";
  final String providerId;

  NewEventFormScreen({
    super.key,
    required this.providerId,
  });

  final _formKey = GlobalKey<FormState>();

  final dayFormat = DateFormat('EEEE', 'it');



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        ref.watch(singleCMIProviderProvider(providerId)).valueOrNull;
    final repsController = useTextEditingController(text: "2");
    final latController = useTextEditingController();
    final longController = useTextEditingController();
    final radiusController = useTextEditingController(text: '100');
    final repsCount = useState<int>(2);
    final nameController = useTextEditingController();
    final womController = useTextEditingController();
    final accessType = useState<EventAccessType>(EventAccessType.single);
    final eventType = useState<EventType>(EventType.manual);
    final acceptedCardType = useState<AcceptedCardType>(AcceptedCardType.mine);
    final anonymous = useState<bool>(false);
    final totemEnabled = useState<bool>(false);
    final totems = useState<List<(TextEditingController, bool)>>([]);
    final releaseWom = useState<bool>(false);
    final emailEnabled = useState<bool>(false);
    final startAt = useState<DateTime>(DateTime.now());
    final acceptPassepartout = ref.watch(acceptPassepartoutProvider);
    final selectedFrequency = useState<FrequencyType>(FrequencyType.daily);
    final titleStyle = Theme.of(context).textTheme.headline6;
    final selectedAim = useState<String?>(null);
    final aims = ref.watch(getAimsProvider)?.valueOrNull;

    final form = Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Crea un nuovo evento',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 48),
          CMITextField(
            controller: nameController,
            hintText: 'Nome evento',
            validator: nameSurnameValidator,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Flexible(
              //   child: MyTextField(
              //     keyboardType: TextInputType.number,
              //     controller: durationController,
              //     hintText: 'Durata in ore',
              //     validator: numberValidator,
              //   ),
              // ),
              // const SizedBox(width: 8),
              Flexible(
                child: CMIDatePicker(
                  onChanged: (d) {
                    startAt.value = d;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: CMIDropdownButton<EventAccessType>(
                  label: 'Tipo di accesso',
                  value: accessType.value,
                  onChanged: (t) {
                    if (t == null) return;
                    if (t == EventAccessType.inOut) {
                      totemEnabled.value = false;
                    }
                    accessType.value = t;
                  },
                  items: EventAccessType.values
                      .map(
                        (e) => DropdownMenuItem<EventAccessType>(
                          value: e,
                          child: Text(enumToString(e) ?? '-'),
                        ),
                      )
                      .toList(),
                ),
              ),

              // Flexible(
              //     child: CMITimePicker(
              //   onChanged: (DateTime value) {},
              // )),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Anonimo', style: titleStyle),
              Switch(
                  value: anonymous.value,
                  onChanged: (v) {
                    anonymous.value = v;
                  }),
            ],
          ),
          if (!anonymous.value) ...[
            const SizedBox(height: 8),
            const OptionSelector(
              text: 'Nome e Cognome',
              value: true,
            ),
            const OptionSelector(
              text: 'C.F.',
              value: true,
            ),
            OptionSelector(
              text: 'Email',
              value: emailEnabled.value,
              onChanged: (v) {
                if (v == null) return;
                emailEnabled.value = v;
              },
            )
          ],
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          // Row(
          //   children: [
          //     Text('Ricorrente', style: titleStyle),
          //     Switch(
          //         value: recurring.value,
          //         onChanged: (v) {
          //           recurring.value = v;
          //         }),
          //   ],
          // ),
          Row(
            children: [
              Flexible(
                child: CMIDropdownButton<EventType>(
                  label: 'Tipo di evento',
                  value: eventType.value,
                  onChanged: (t) {
                    if (t == null) return;
                    eventType.value = t;
                  },
                  items: EventType.values
                      .map(
                        (e) => DropdownMenuItem<EventType>(
                          value: e,
                          child: Text(e.text),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: CMIDropdownButton<AcceptedCardType>(
                  label: 'Accettazione',
                  value: acceptedCardType.value,
                  onChanged: (t) {
                    if (t == null) return;
                    acceptedCardType.value = t;
                  },
                  items: AcceptedCardType.values
                      .map(
                        (e) => DropdownMenuItem<AcceptedCardType>(
                          value: e,
                          child: Text(e.text),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          if (eventType.value == EventType.periodic) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: CMIDropdownButton<FrequencyType>(
                    value: selectedFrequency.value,
                    onChanged: (f) {
                      if (f == null) return;
                      selectedFrequency.value = f;
                    },
                    items: FrequencyType.values
                        .map((e) => DropdownMenuItem<FrequencyType>(
                            value: e, child: Text(e.text)))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: CMITextField(
                    controller: repsController,
                    hintText: 'Numero di ripetizioni',
                    validator: numberValidator,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (v) {
                      final value = int.tryParse(v.trim());
                      if (value != null && value > 0) {
                        repsCount.value = value;
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
                'L\'evento si ripeterà ogni ${selectedFrequency.value == FrequencyType.weekly ? dayFormat.format(startAt.value) : 'giorno'} per ${repsCount.value} volte'),
          ],
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Text('Posizione Evento', style: titleStyle),
          const SizedBox(height: 8),
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
          Row(
            children: [
              Text('Totem', style: titleStyle),
              Switch(
                value: totemEnabled.value,
                onChanged: accessType.value == EventAccessType.single
                    ? (v) {
                        if (v) {
                          releaseWom.value = true;
                        }
                        totemEnabled.value = v;
                        totems.value = [
                          (TextEditingController(text: 'Totem 1'), true)
                        ];
                      }
                    : null,
              ),
            ],
          ),
          if (accessType.value == EventAccessType.inOut)
            const Text(
              'I totem non possono essere aggiunti per eventi con accesso in/out',
              style: TextStyle(color: Colors.orange),
            ),
          if (totemEnabled.value) ...[
            const SizedBox(height: 8),
            for (int i = 0; i < totems.value.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(child: Text('${i + 1}')),
                    const SizedBox(width: 16),
                    Flexible(
                      child: TextFormField(
                        controller: totems.value[i].$1,
                        validator: nameSurnameValidator,
                        decoration: InputDecoration(
                          suffix: totems.value.length == 1
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.clear),
                                  color: Colors.red,
                                  onPressed: () {
                                    final tmp = totems.value.toList();
                                    tmp.removeAt(i);
                                    totems.value = tmp;
                                  },
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Statico'),
                        Switch(
                          value: totems.value[i].$2,
                          onChanged: (value) {
                            final tmp = totems.value.toList();
                            final o = tmp.removeAt(i);
                            tmp.insert(i, (o.$1, value));
                            totems.value = tmp;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ElevatedButton(
                onPressed: () {
                  totems.value.forEach((element) => print(element.$1.text));
                  totems.value = [
                    ...totems.value,
                    (
                      TextEditingController(
                          text: 'Totem ${totems.value.length + 1}'),
                      true
                    )
                  ];
                },
                child: const Text('Nuovo totem'))
          ],
          const SizedBox(height: 16),
          Row(
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
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final isRecurring = eventType.value == EventType.periodic;
                  if (_formKey.currentState!.validate()) {
                    final eventId = const Uuid().v4();
                    final currentSubEventId =
                        DateFormat('y-MM-dd').format(startAt.value);

                    final womCount =
                        int.tryParse(womController.text.trim()) ?? 0;

                    final recurrence = isRecurring
                        ? int.tryParse(repsController.text.trim()) ?? 1
                        : 1;

                    final sessionStartAt = startAt.value.midnightUTC;
                    // final end = sessionStartAt.add(const Duration(days: 1));

                    // Data di fine prima sessione
                    final sessionEndAt = isRecurring
                        ? sessionStartAt.add(
                            Duration(days: selectedFrequency.value.multiplier),
                          )
                        : null;

                    final position = latController.text.trim().isNotEmpty &&
                            longController.text.trim().isNotEmpty
                        ? GeoPoint(double.parse(latController.text.trim()),
                            double.parse(longController.text.trim()))
                        : null;

                    // if (totemEnabled.value && position == null) {
                    //   CoolAlert.show(
                    //     context: context,
                    //     type: CoolAlertType.error,
                    //     title: 'Posizione obbligatoria',
                    //     text:
                    //         'Con i totem abilitati devi inserire una posizione valida',
                    //     width: 300,
                    //   );
                    //   return;
                    // }

                    final s = CMIEvent(
                      id: eventId,
                      type: eventType.value,
                      activeSessionId: currentSubEventId,
                      recurrence: recurrence,
                      subEventDeadline: sessionEndAt,
                      name: nameController.text.trim(),
                      acceptPassepartout: acceptPassepartout,
                      anonymous: anonymous.value,
                      emailShowed: anonymous.value ? false : emailEnabled.value,
                      recurring: isRecurring,
                      remaining: isRecurring ? recurrence - 1 : 0,
                      frequency: isRecurring ? selectedFrequency.value : null,
                      accessType: accessType.value,
                      maxWomCount: releaseWom.value ? womCount : 0,
                      status: EventStatus.live,
                      createdOn: DateTime.now().toUtc(),
                      startAt: sessionStartAt,
                      acceptedCardType: acceptedCardType.value,
                      position: position,
                      aim: selectedAim.value,
                    );

                    final session = CMISubEvent(
                      id: currentSubEventId,
                      startAt: sessionStartAt,
                      endAt: sessionEndAt,
                    );

                    final t = <EmbeddedData>[];
                    if (totemEnabled.value) {
                      for (int i = 0; i < totems.value.length; i++) {
                        final tmp = EmbeddedData(
                          name: totems.value[i].$1.text.trim(),
                          id: const Uuid().v4(),
                          isStatic: totems.value[i].$2,
                          requestId: totems.value[i].$2 ? null : 'abcded',
                          position: position,
                          updatedOn: DateTime.now(),
                          radius: int.parse(radiusController.text.trim()),
                          dedicated: true,
                          eventId: eventId,
                          sessionId: session.id,
                        );
                        t.add(tmp);
                      }
                    }

                    final navigator = Navigator.of(context);

                    final batch = FirebaseFirestore.instance.batch();
                    batch.set(Cloud.eventDoc(providerId, eventId), s.toJson());
                    batch.set(
                        Cloud.sessionDoc(EventIds(
                            providerId: providerId,
                            eventId: eventId,
                            sessionId: session.id)),
                        session.toJson());
                    for (int i = 0; i < t.length; i++) {
                      batch.set(
                        Cloud.totemDoc(
                          providerId,
                          t[i].id,
                        ),
                        t[i].toJson(),
                      );
                    }
                    await batch.commit();
                    navigator.pop();
                  }
                } catch (ex, st) {
                  logger.e(ex);
                  logger.e(st);

                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: 'Si è verificato un errore',
                    text: ex.toString(),
                    width: 300,
                  );
                }
              },
              child: const Text('Crea evento'),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: isLargeScreen(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  // padding: const EdgeInsets.all(16.0),
                  // alignment: Alignment.center,
                  child: Card(child: form),
                ),
              ],
            )
          : form,
    );
  }
}

class OptionSelector extends StatelessWidget {
  final bool value;
  final String text;
  final ValueChanged<bool?>? onChanged;

  const OptionSelector(
      {Key? key, required this.value, required this.text, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(text),
      ],
    );
  }
}
