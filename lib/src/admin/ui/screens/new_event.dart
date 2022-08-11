import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/common/ui/cmi_date_picker.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:countmein/cloud.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../ui/validators.dart';
import 'package:intl/intl.dart';

final womValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  RangeValidator(
      min: 1,
      max: 1000,
      errorText: 'Il valore deve essere compresto tra 1 e 100'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

final acceptPassepartoutProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

class NewEventFormScreen extends HookConsumerWidget {
  static const String routeName = "/newEventForm";
  final String providerId;

  NewEventFormScreen({
    Key? key,
    required this.providerId,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final durationController = useTextEditingController();
    final repsController = useTextEditingController();
    final nameController = useTextEditingController();
    final womController = useTextEditingController();
    final accessType = useState<EventAccessType>(EventAccessType.single);
    final anonymous = useState<bool>(false);
    final recurring = useState<bool>(false);
    final releaseWom = useState<bool>(false);
    final emailEnabled = useState<bool>(false);
    final startAt = useState<DateTime>(DateTime.now());
    final acceptPassepartout = ref.watch(acceptPassepartoutProvider);
    final selectedFrequency = useState<FrequencyType>(FrequencyType.daily);
    final titleStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          padding: const EdgeInsets.all(16.0),
          child: CMICard(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    'Crea un nuovo evento',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 48),
                  MyTextField(
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
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Ricorrente', style: titleStyle),
                      Switch(
                          value: recurring.value,
                          onChanged: (v) {
                            recurring.value = v;
                          }),
                    ],
                  ),
                  if (recurring.value) ...[
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
                                    value: e,
                                    child: Text(enumToString(e) ?? '-')))
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: MyTextField(
                            controller: repsController,
                            hintText: 'Numero di ripetizioni',
                            validator: numberValidator,
                          ),
                        ),
                      ],
                    )
                  ],
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('WOM', style: titleStyle),
                      Switch(
                          value: releaseWom.value,
                          onChanged: (v) {
                            releaseWom.value = v;
                          }),
                    ],
                  ),
                  if (releaseWom.value) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        /* Flexible(
                          flex: 1,
                          child: CMIDropdownButton<WomReleaseType>(
                            value: releaseType.value,
                            onChanged: (t) {
                              if (t == null) return;
                              releaseType.value = t;
                            },
                            items: WomReleaseType.values
                                .map(
                                  (e) => DropdownMenuItem<WomReleaseType>(
                                    value: e,
                                    child: Text(enumToString(e)),
                                  ),
                                )
                                .toList(),
                          ),
                        ),*/
                        // if (releaseType.value == WomReleaseType.fixed) ...[
                        //   const SizedBox(width: 8),
                        Flexible(
                          child: MyTextField(
                            controller: womController,
                            keyboardType: TextInputType.number,
                            hintText: 'Quanti wom rilasciare?',
                            validator: womValidator,
                          ),
                        ),
                        // ]
                      ],
                    ),
                  ],
                  const Divider(),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final eventId = const Uuid().v4();
                          final currentSubEvent =
                              DateFormat('y-MM-dd').format(startAt.value);

                          final womCount =
                              int.tryParse(womController.text.trim()) ?? 0;

                          final recurrence = recurring.value
                              ? int.tryParse(repsController.text.trim()) ?? 1
                              : 1;

                          final start = startAt.value.midnightUTC;

                          final days =
                              recurrence * selectedFrequency.value.multiplier;
                          final endAt = start.add(Duration(
                              days: recurring.value
                                  ? selectedFrequency.value.multiplier
                                  : 1));

                          print('days to end: $days');
                          //TODO
                          final subEventDeadline = endAt;

                          final s = CMIEvent(
                            id: eventId,
                            currentSubEvent: currentSubEvent,
                            recurrence: recurrence,
                            subEventDeadline: subEventDeadline,
                            name: nameController.text.trim(),
                            acceptPassepartout: acceptPassepartout,
                            anonymous: anonymous.value,
                            recurring: recurring.value,
                            // TODO isOpen is not necessary, use status
                            isOpen: true,
                            remaining: recurring.value ? recurrence - 1 : 0,
                            frequency: recurring.value
                                ? selectedFrequency.value
                                : null,
                            accessType: accessType.value,
                            maxWomCount: releaseWom.value ? womCount : 0,
                            status: EventStatus.live,
                            createdOn: DateTime.now().toUtc(),
                            startAt: start,
                          );

                          final firstSubEvent = CMISubEvent(
                            id: currentSubEvent,
                            startAt: start,
                            endAt: endAt,
                          );

                          final navigator = Navigator.of(context);

                          //TODO use transaction
                          await Cloud.eventDoc(providerId, eventId)
                              .set(s.toJson());
                          await Cloud.eventDoc(providerId, eventId)
                              .collection('subEvents')
                              .doc(firstSubEvent.id)
                              .set(firstSubEvent.toJson());
                          // navigator.pop();
                        }
                      },
                      child: const Text('Crea evento'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
