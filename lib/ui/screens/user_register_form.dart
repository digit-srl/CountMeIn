import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../cloud.dart';
import '../../domain/entities/activity.dart';
import '../../domain/entities/user_card.dart';
import '../validators.dart';
import '../widgets/my_text_field.dart';

final nameControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

final surnameControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

final cfControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

final emailControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

class UserFormScreen extends ConsumerWidget {
  final Activity activity;

  UserFormScreen({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameControllerProvider);
    final surnameController = ref.watch(surnameControllerProvider);
    final cfController = ref.watch(cfControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  activity.name,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                MyTextField(
                  controller: nameController,
                  hintText: 'Nome',
                  validator: nameSurnameValidator,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  controller: surnameController,
                  hintText: 'Cognome',
                  validator: nameSurnameValidator,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: EmailValidator(errorText: 'Email non valida'),
                ),
                const SizedBox(height: 16),
                MyTextField(
                  controller: cfController,
                  hintText: 'Codice Fiscale',
                  textCapitalization: TextCapitalization.characters,
                  validator: CFValidator(),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final name = nameController.text.trim();
                        final surname = surnameController.text.trim();
                        final email = emailController.text.trim();
                        final cf = cfController.text.trim().toUpperCase();
                        final user = UserCard(
                          name: name,
                          surname: surname,
                          cf: cf,
                          id: const Uuid().v4(),
                          email: email,
                        );
                        Cloud.usersCollection.doc(user.id).set(user.toJson());
                        Hive.box('user').put('myUser', user.toJson());
                      }
                    },
                    child: const Text('Iscriviti')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
