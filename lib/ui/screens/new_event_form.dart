import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:countmein/cloud.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/session.dart';
import '../validators.dart';
import '../widgets/my_text_field.dart';

final prefixValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  MinLengthValidator(3, errorText: 'Devi inserire 3 caratteri'),
  MaxLengthValidator(3, errorText: 'Devi inserire 3 caratteri'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

final womValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  RangeValidator(
      min: 1,
      max: 50,
      errorText: 'Il valore deve essere compresto tra 1 e 100'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

class NewEventFormScreen extends ConsumerWidget {
  static const String routeName = "/newEventForm";
  final String activityId;

  NewEventFormScreen({
    Key? key,
    required this.activityId,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final womController = useTextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Crea un nuovo evento'),
              const SizedBox(height: 16),
              MyTextField(
                controller: nameController,
                hintText: 'Nome evento',
                validator: nameSurnameValidator,
              ),
              const SizedBox(height: 16),
              MyTextField(
                controller: womController,
                hintText: 'Quanti wom rilasciare?',
                validator: prefixValidator,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final eventId = const Uuid().v4();
                    final s = Event(
                        id: eventId,
                        createdOn: DateTime.now(),
                        name: nameController.text.trim(),
                        status: EventStatus.live,
                        womCount: int.tryParse(womController.text.trim()),
                        );
                    Cloud.eventDoc(activityId, eventId).set(s.toJson());
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Crea evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
