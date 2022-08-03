import 'package:countmein/src/common/ui/cmi_dropdown.dart';
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

import '../../../../domain/entities/session.dart';
import '../../../../ui/validators.dart';

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

enum WomReleaseType { predetermined, inOut }

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
    final frequencyController = useTextEditingController();
    final durationController = useTextEditingController();
    final repsController = useTextEditingController();
    final nameController = useTextEditingController();
    final womController = useTextEditingController();
    final releaseType = useState<WomReleaseType>(WomReleaseType.predetermined);
    final anonymous = useState<bool>(false);
    final recurring = useState<bool>(false);
    final releaseWom = useState<bool>(false);
    final emailEnabled = useState<bool>(false);
    final acceptPassepartout = ref.watch(acceptPassepartoutProvider);
    final selectedType = useState<CMIEventType>(CMIEventType.standard);

    final titleStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 700),
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
                    OptionSelector(
                      text: 'Nome e Cognome',
                      value: true,
                    ),
                    OptionSelector(
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
                  Divider(),
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
                  const SizedBox(height: 8),
                  MyTextField(
                    keyboardType: TextInputType.number,
                    controller: durationController,
                    hintText: 'Durata in ore',
                    validator: numberValidator,
                  ),
                  if (recurring.value) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: MyTextField(
                            keyboardType: TextInputType.number,
                            controller: frequencyController,
                            hintText: 'Frequenza',
                            validator: numberValidator,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: MyTextField(
                            controller: repsController,
                            hintText: 'Ripetizioni',
                            validator: numberValidator,
                          ),
                        ),
                      ],
                    )
                  ],
                  Divider(),
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
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
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
                        ),
                        if (releaseType.value == WomReleaseType.predetermined) ...[
                          const SizedBox(width: 8),
                          Flexible(
                            child: MyTextField(
                              controller: womController,
                              keyboardType: TextInputType.number,
                              hintText: 'Quanti wom rilasciare?',
                              validator: womValidator,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                  Divider(),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        /*if (_formKey.currentState!.validate()) {
                          final eventId = const Uuid().v4();
                          final s = Event(
                            id: eventId,
                            createdOn: DateTime.now(),
                            name: nameController.text.trim(),
                            status: EventStatus.live,
                            womCount: int.tryParse(womController.text.trim()),
                            acceptPassepartout: acceptPassepartout,
                          );
                          Cloud.eventDoc(providerId, eventId).set(s.toJson());
                          Navigator.of(context).pop();
                        }*/
                      },
                      child: Text('Crea evento'),
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
