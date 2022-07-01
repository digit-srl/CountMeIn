import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../app.dart';
import '../../../../main.dart';
import '../../../common/ui/widgets/my_button.dart';
import '../../../common/ui/widgets/my_text_field.dart';
import '../../../common/mu_styles.dart';
import '../../application/auth_notifier.dart';
import '../../domain/entities/exceptions.dart';
import 'sign_up.dart';
import 'package:form_field_validator/form_field_validator.dart';

final textValidator = MultiValidator([
  RequiredValidator(errorText: 'Field required'),
  MinLengthValidator(3, errorText: 'Il testo deve essere > di 3 caratteri'),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: 'enter a valid email address')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

class SignInScreen extends HookConsumerWidget {
  static const routeName = '/signIn';

  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  _signIn(String email, String password, WidgetRef ref)async {
    print('$email, $password');
    try {
     final result =  await ref.read(signInNotifierProvider.notifier).signIn(email, password);
     if(result){
       ref.read(goRouterProvider).pop();
     }
    } on SignInException catch (ex) {
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = ref.watch(signInNotifierProvider);
    return Scaffold(
      appBar: AppBar(),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
                controller: passwordController,
                labelText: 'Password',
                validator: passwordValidator,
              ),
              const SizedBox(height: 32),
              MUButton(
                text: 'sign in',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    _signIn(email, password, ref);

                  }
                },
              ),
              const SizedBox(height: 16),
              EasyRichText(
                "Non hai un account? Registrati",
                defaultStyle: Theme.of(context).textTheme.bodyText1,
                patternList: [
                  EasyRichTextPattern(
                      targetString: 'Registrati',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(SignUpScreen.routeName);
                        },
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.bold
                          .underline),
                ],
              ),
               const SizedBox(height: 8),
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
                        ..onTap = () {
                          print('password dimenticata');
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
    );
  }
}
