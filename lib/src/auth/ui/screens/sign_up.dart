import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/src/common/ui/widgets/my_text_field.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:go_router/go_router.dart';

import 'package:countmein/src/auth/domain/entities/exceptions.dart';

class SignUpScreen extends HookConsumerWidget {
  static const routeName = '/signUp';

  final _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpException?>(signUpErrorProvider,
        (SignUpException? previous, SignUpException? next) {
      if (next != null) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Error $next',
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
                validator: textValidator.call,
              ),
              MUTextField(
                controller: surnameController,
                labelText: 'Cognome',
                validator: textValidator.call,
              ),
              MUTextField(
                controller: emailController,
                labelText: 'Email',
                validator: emailValidator.call,
              ),
              MUTextField(
                labelText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordController,
                validator: passwordValidator.call,
              ),
              MUTextField(
                labelText: 'Ripeti Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (val) =>
                    MatchValidator(errorText: 'Le password non corrispondono')
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
      WidgetRef ref, BuildContext context,) async {
    logger.i('$name, $surname, $email, $password');

    try {
      final nav = GoRouter.of(context);
      await ref
          .read(signUpNotifierProvider.notifier)
          .signUp(name, surname, email, password);
      nav.pop();
    } on SignInException catch (ex) {
      showError(
        ref.context,
        title: 'Spiacenti',
        description: ex.message,
      );
    }
  }
}
