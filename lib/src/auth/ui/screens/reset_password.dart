import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/src/common/ui/widgets/my_text_field.dart';
import 'package:countmein/ui/screens/activities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../ui/screens/error.dart';
import '../../../../ui/screens/home.dart';
import '../../../../ui/widgets/loading.dart';
import '../../application/auth_notifier.dart';
import '../../application/reset_password_state.dart';
import '../../application/reset_password_notifier.dart';
import 'email_not_verified.dart';

//http://localhost:9099/emulator/action?mode=resetPassword&lang=en&oobCode=oocUYJyjjtVPHftvDw1JLVNb9CsRjtTitXkNGxYio35MWE-SW3ekES&apiKey=fake-api-key
class ResetPasswordScreen extends HookConsumerWidget {
  static const routeName = '/reset';

  final String oobCode;
  final String fullName;

  const ResetPasswordScreen({
    Key? key,
    required this.oobCode,
    required this.fullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final state = ref.watch(resetPasswordProvider(oobCode));
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500,maxHeight: 500),
            padding: const EdgeInsets.all(16.0),
            child: state.when(
              complete: () {
                return Text('La password è stata reimpostata correttamente');
              },
              data: () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fullName,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    MUTextField(
                      controller: controller,
                      hintText: 'Inserisci la nuova password',
                      validator: passwordValidator,
                    ),
                     const SizedBox(height: 16),
                    MUButton(
                      text: 'Reimposta',
                      onPressed: () async {
                        final newPassword = controller.text.trim();
                        ref
                            .read(resetPasswordProvider(oobCode).notifier)
                            .confirmNewPassword(newPassword);
                      },
                    )
                  ],
                );
              },
              firebaseException: (ex) {
                return Text(ex.message);
              },
              loading: () => LoadingWidget(),
              error: (e, s) => ErrorScreen(exception: e,),
              weakPassword: () {
                return Text('password troppo debole');
              },
            ),
          ),
        ),
      ),
    );
  }
}
