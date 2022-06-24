import 'package:countmein/domain/entities/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:countmein/cloud.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/session.dart';
import '../screens/home.dart';
import '../validators.dart';
import 'my_text_field.dart';

final nameControllerProvider = Provider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

final prefixControllerProvider = Provider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

final prefixValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  MinLengthValidator(3, errorText: 'Devi inserire 3 caratteri'),
  MaxLengthValidator(3, errorText: 'Devi inserire 3 caratteri'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

class AddSessionDialog extends ConsumerWidget {
  final String activityId;

  AddSessionDialog({
    Key? key,
    required this.activityId,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameControllerProvider);
    // final prefixController = ref.watch(surnameControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Crea un nuovo evento'),
            const SizedBox(height: 16),
            MyTextField(
              controller: nameController,
              hintText: 'Nome evento',
              validator: nameSurnameValidator,
            ),
            const SizedBox(height: 16),
            // MyTextField(
            //   controller: prefixController,
            //   hintText: 'Prefisso',
            //   validator: prefixValidator,
            // ),
            // const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final eventId = const Uuid().v4();
                    final s = Event(
                        id: eventId,
                        createdOn: DateTime.now(),
                        name: nameController.text.trim(),
                        status: EventStatus.live
                        // prefix: prefixController.text.trim(),
                        );
                    Cloud.eventDoc(activityId, eventId).set(s.toJson());
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Crea evento')),
          ],
        ),
      ),
    );
  }
}
