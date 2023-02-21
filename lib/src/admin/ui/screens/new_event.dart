import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/common/ui/cmi_date_picker.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static const String routeName = "create-event";
  final String providerId;

  NewEventFormScreen({
    Key? key,
    required this.providerId,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final dayFormat = DateFormat('EEEE', 'it');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final durationController = useTextEditingController();
    final repsController = useTextEditingController(text: "2");
    final repsCount = useState<int>(2);
    final nameController = useTextEditingController();
    final womController = useTextEditingController();
    final accessType = useState<EventAccessType>(EventAccessType.single);
    final eventType = useState<EventType>(EventType.manual);
    final anonymous = useState<bool>(false);
    // final recurring = useState<bool>(false);
    final releaseWom = useState<bool>(false);
    final emailEnabled = useState<bool>(false);
    final startAt = useState<DateTime>(DateTime.now());
    final acceptPassepartout = ref.watch(acceptPassepartoutProvider);
    final selectedFrequency = useState<FrequencyType>(FrequencyType.daily);
    final titleStyle = Theme.of(context).textTheme.headline6;

    final form =  Form(
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
            CMIDropdownButton<EventType>(
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
                    child: CMITextField(
                      controller: womController,
                      keyboardType: TextInputType.number,
                      hintText: accessType.value == EventAccessType.inOut
                          ? 'Numero max di wom da rilasciare'
                          : 'Quanti wom rilasciare?',
                      validator: womValidator,
                    ),
                  ),
                  // ]
                ],
              ),
            ],
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final isRecurring =
                      eventType.value == EventType.periodic;
                  if (_formKey.currentState!.validate()) {
                    final eventId = const Uuid().v4();
                    final currentSubEventId =
                    DateFormat('y-MM-dd').format(startAt.value);

                    final womCount =
                        int.tryParse(womController.text.trim()) ?? 0;

                    final recurrence = isRecurring
                        ? int.tryParse(repsController.text.trim()) ?? 1
                        : 1;

                    final start = startAt.value.midnightUTC;

                    // Data di fine prima sessione
                    final subEventEndAt = start.add(
                      Duration(
                          days: isRecurring
                              ? selectedFrequency.value.multiplier
                              : 1),
                    );

                    //TODO
                    final subEventDeadline = subEventEndAt;

                    final s = CMIEvent(
                      id: eventId,
                      type: eventType.value,
                      activeSessionId: currentSubEventId,
                      recurrence: recurrence,
                      subEventDeadline: subEventDeadline,
                      name: nameController.text.trim(),
                      acceptPassepartout: acceptPassepartout,
                      anonymous: anonymous.value,
                      emailShowed:
                      anonymous.value ? false : emailEnabled.value,
                      recurring: isRecurring,
                      remaining: isRecurring ? recurrence - 1 : 0,
                      frequency:
                      isRecurring ? selectedFrequency.value : null,
                      accessType: accessType.value,
                      maxWomCount: releaseWom.value ? womCount : 0,
                      status: EventStatus.live,
                      createdOn: DateTime.now().toUtc(),
                      startAt: start,
                    );

                    final firstSubEvent = CMISubEvent(
                      id: currentSubEventId,
                      startAt: start,
                      endAt: subEventEndAt,
                    );

                    final navigator = Navigator.of(context);

                    //TODO use transaction
                    await Cloud.eventDoc(providerId, eventId)
                        .set(s.toJson());
                    await Cloud.sessionDoc(EventIds(
                        providerId: providerId,
                        eventId: eventId,
                        sessionId: firstSubEvent.id))
                        .set(firstSubEvent.toJson());
                    navigator.pop();
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
      body: isLargeScreen(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 700),
            // padding: const EdgeInsets.all(16.0),
            // alignment: Alignment.center,
            child: Card(
              child: form
            ),
          ),
        ],
      ) : form,
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
