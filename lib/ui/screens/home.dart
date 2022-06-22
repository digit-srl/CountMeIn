import 'dart:io';

import 'package:countmein/ui/screens/activities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:countmein/ui/screens/user_qr_code.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/session.dart';
import '../../domain/entities/user.dart';
import 'admin.dart';

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

final nameSurnameValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  MinLengthValidator(3, errorText: 'Devi inserire almeno 3 caratteri'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

/*final cfValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  MinLengthValidator(16,
      errorText: 'Il codice fiscale è composto da 16 caratteri'),
  MaxLengthValidator(16,
      errorText: 'Il codice fiscale è composto da 16 caratteri'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);*/

class UserFormScreen extends ConsumerWidget {
  final Session session;

  UserFormScreen({
    Key? key,
    required this.session,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameControllerProvider);
    final surnameController = ref.watch(surnameControllerProvider);
    final cfController = ref.watch(cfControllerProvider);
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
                  session.name,
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
                        final cf = cfController.text.trim().toUpperCase();
                        final user = User(
                          name: name,
                          surname: surname,
                          cf: cf,
                          id: const Uuid().v4(),
                        );
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

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;

  const MyTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.validator,
      this.textCapitalization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
          hintText: hintText, border: const OutlineInputBorder()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const ActivitiesScreen();
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Count Me In',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (c, AsyncSnapshot<PackageInfo> snap) {
                return Text(snap.data?.version ?? '-');
              },
            ),
          ],
        ),
      ),
    );
    return Container();
  }
}

class CFValidator extends TextFieldValidator {
  CFValidator(
      {String errorText = 'Il codice fiscale è composto da 16 caratteri'})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if (value.toUpperCase() == 'NA') {
      return true;
    } else if (value.length == 16) {
      return true;
    }
    return false;
  }
}
