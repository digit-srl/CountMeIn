import 'package:countmein/constants.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/auth/ui/screens/auht_gate.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/screens/request_activity.dart';
import 'package:countmein/utils.dart';
import 'package:dio/dio.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../common/ui/widgets/my_button.dart';
import '../../../common/ui/widgets/my_text_field.dart';
import '../../../common/mu_styles.dart';
import '../../application/auth_notifier.dart';
import '../../domain/entities/exceptions.dart';
import 'package:form_field_validator/form_field_validator.dart';

final textValidator = MultiValidator([
  RequiredValidator(errorText: 'Campo obbligatorio'),
  MinLengthValidator(3, errorText: 'Il testo deve essere > di 3 caratteri'),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Campo obbligatorio'),
  EmailValidator(errorText: 'enter a valid email address')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Campo obbligatorio'),
  MinLengthValidator(6, errorText: 'password must be at least 8 digits long'),
/*  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')*/
]);

class SignInScreen extends HookConsumerWidget {
  static const routeName = '/signIn';

  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  _signIn(String email, String password, WidgetRef ref) async {
    logger.i('$email, $password');
    try {
      final result = await ref
          .read(signInNotifierProvider.notifier)
          .signIn(email, password);
      Hive.box('user').put('email', email);
      Hive.box('user').put('password', password);
    } on SignInException catch (ex) {
      logger.i(ex);
      showError(
        ref.context,
        title: 'Spiacenti',
        description: ex.message,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController =
        useTextEditingController(text: Hive.box('user').get('email'));
    final passwordController =
        useTextEditingController(text: Hive.box('user').get('password'));
    final isLoading = ref.watch(signInNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Count Me In'),
        actions: [
          if (isWebDevice)
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                context.go(AuthGate.routeName);
              },
            ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
            child: CMICard(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Accedi',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    /*SignInButton(
                      Buttons.Facebook,
                      text: 'Continua con Facebook',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    SignInButton(
                      Buttons.Google,
                      text: 'Continua con Google',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    SignInButton(
                      Buttons.Apple,
                      text: 'Continua con Apple',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    Center(child: Text('oppure')),
                    const SizedBox(height: 8),*/
                    MUTextField(
                      controller: emailController,
                      labelText: 'Email',
                      validator: emailValidator,
                    ),
                    MUTextField(
                      maxLines: 1,
                      controller: passwordController,
                      obscureText: true,
                      labelText: 'Password',
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: MUButton(
                        text: 'Accedi',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            _signIn(email, password, ref);
                          }
                        },
                      ),
                    ),
                    // if (isWebDevice) ...[
                    const SizedBox(height: 32),
                    EasyRichText(
                      "Vuoi registrare un tuo provider? Clicca qui",
                      defaultStyle: Theme.of(context).textTheme.bodyText1,
                      patternList: [
                        EasyRichTextPattern(
                            targetString: 'qui',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // if (isWebDevice) {
                                context.push(ActivityRequestScreen.routeName);
                                // } else {
                                // final uri = 'https://cmi.digit.srl';
                                // }
                              },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.bold
                                .underline),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // ],
                    EasyRichText(
                      "Hai dimenticato la password? Clicca qui",
                      defaultStyle: Theme.of(context).textTheme.bodyText1,
                      patternList: [
                        // EasyRichTextPattern(
                        //   targetString: 'https://pub.dev/packages/easy_rich_text',
                        //   urlType: 'web',
                        //   style: TextStyle(
                        //     decoration: TextDecoration.underline,
                        //   ),
                        // ),
                        EasyRichTextPattern(
                            targetString: 'qui',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                logger.i('password dimenticata');

                                await showDialog(
                                    context: context,
                                    builder: (_) => const Dialog(
                                        child: ResetPasswordRequestDialog()));
                              },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.bold
                                .underline),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordRequestDialog extends HookConsumerWidget {
  const ResetPasswordRequestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final isCompleted = useState(false);
    final emailController = useTextEditingController();
    return Container(
      margin: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading.value)
            const CircularProgressIndicator()
          else if (isCompleted.value) ...[
            const Icon(
              Icons.check,
              color: Colors.green,
              size: 50,
            ),
            const Text('Email inviata con successo'),
            const SizedBox(height: 16),
          ] else
            MUTextField(
              maxLines: 1,
              controller: emailController,
              labelText: 'Email',
              validator: emailValidator,
            ),
          if (!isCompleted.value)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : () async {
                          try {
                            isLoading.value = true;
                            await ref.read(dioProvider).post(
                              sendResetPasswordUrl,
                              data: <String, dynamic>{
                                'email': emailController.text.trim()
                              },
                            );
                            isLoading.value = false;
                            isCompleted.value = true;
                          } on DioException catch (ex) {
                            logger.e(ex);
                            isLoading.value = false;
                          } catch (ex) {
                            logger.e(ex);
                            isLoading.value = false;
                          }
                        },
                  child: const Text('Richiedi')),
            )
        ],
      ),
    );
  }
}
