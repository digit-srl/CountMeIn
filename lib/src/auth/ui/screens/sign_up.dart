import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../common/ui/widgets/my_button.dart';
import '../../../common/ui/widgets/my_text_field.dart';
import '../../application/auth_notifier.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/exceptions.dart';

class SignUpScreen extends HookConsumerWidget {
  static const routeName = '/signUp';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpException?>(signUpErrorProvider,
        (SignUpException? previous, SignUpException? next) {
      if (next != null) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Error $next",
        );
      }
    });

    final nameController = useTextEditingController();
    final surnameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = ref.watch(signUpNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              MUTextField(
                controller: nameController,
                labelText: 'Nome',
                validator: textValidator,
              ),
              MUTextField(
                controller: surnameController,
                labelText: 'Cognome',
                validator: textValidator,
              ),
              MUTextField(
                controller: emailController,
                labelText: 'Email',
                validator: emailValidator,
              ),
              MUTextField(
                controller: passwordController,
                labelText: 'Password',
                validator: passwordValidator,
              ),
              MUTextField(
                labelText: 'Ripeti Password',
                validator: (val) =>
                    MatchValidator(errorText: 'passwords do not match')
                        .validateMatch(val ?? '', passwordController.text),
              ),
              const SizedBox(height: 16),
              MUButton(
                text: 'Registrati',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = nameController.text.trim();
                    final surname = surnameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    _signUp(name, surname, email, password, ref, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signUp(String name, String surname, String email, String password,
      WidgetRef ref, BuildContext context) async {
    print('$name, $surname, $email, $password');
    final result = await ref
        .read(signUpNotifierProvider.notifier)
        .signUp(name, surname, email, password);
    if (result) {
      context.pop();
    }
  }
}
