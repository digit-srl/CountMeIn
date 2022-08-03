import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/screens/request_activity.dart';
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
    print('$email, $password');
    try {
      final result = await ref
          .read(signInNotifierProvider.notifier)
          .signIn(email, password);
      Hive.box('user').put('email', email);
      Hive.box('user').put('password', password);
      // if(result){
      //   ref.read(goRouterProvider).pop();
      // }
    } on SignInException catch (ex) {
      print(ex);
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
      appBar: AppBar(),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
            child: CMICard(
              child: Form(
                key: _formKey,
                child: ListView(
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
                    const SizedBox(height: 32),
                    EasyRichText(
                      "Vuoi registrare un tuo provider? Clicca qui",
                      defaultStyle: Theme.of(context).textTheme.bodyText1,
                      patternList: [
                        EasyRichTextPattern(
                            targetString: 'qui',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(ActivityRequestScreen.routeName);
                              },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.bold
                                .underline),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // EasyRichText(
                    //   "Hai dimenticato la password? Clicca qui",
                    //   defaultStyle: Theme.of(context).textTheme.bodyText1,
                    //   patternList: [
                    //     // EasyRichTextPattern(
                    //     //   targetString: 'https://pub.dev/packages/easy_rich_text',
                    //     //   urlType: 'web',
                    //     //   style: TextStyle(
                    //     //     decoration: TextDecoration.underline,
                    //     //   ),
                    //     // ),
                    //     EasyRichTextPattern(
                    //         targetString: 'qui',
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () {
                    //             print('password dimenticata');
                    //           },
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1
                    //             ?.bold
                    //             .underline),
                    //   ],
                    // ),
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
