import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
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
    final nameController = useTextEditingController();
    final womController = useTextEditingController();
    final acceptPassepartout = ref.watch(acceptPassepartoutProvider);

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
                  MyTextField(
                    controller: womController,
                    keyboardType: TextInputType.number,
                    hintText: 'Quanti wom rilasciare?',
                    validator: womValidator,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                        }
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