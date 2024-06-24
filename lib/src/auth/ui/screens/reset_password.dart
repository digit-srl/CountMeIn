import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/src/common/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:countmein/ui/screens/error.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:countmein/src/auth/application/reset_password_state.dart';
import 'package:countmein/src/auth/application/reset_password_notifier.dart';

//http://localhost:9099/emulator/action?mode=resetPassword&lang=en&oobCode=oocUYJyjjtVPHftvDw1JLVNb9CsRjtTitXkNGxYio35MWE-SW3ekES&apiKey=fake-api-key
class ResetPasswordScreen extends HookConsumerWidget {
  static const routeName = '/reset';

  final ResetPasswordRequest resetPasswordRequest;

  const ResetPasswordScreen({
    required this.resetPasswordRequest, super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resetPasswordProvider(resetPasswordRequest));
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
            padding: const EdgeInsets.all(16.0),
            child: state.when(
              complete: () {
                return const Text(
                    'La password è stata reimpostata correttamente',);
              },
              data: () {
                return ResetPasswordForm(
                  onSave: (newPassword) async {
                    ref
                        .read(resetPasswordProvider(resetPasswordRequest)
                            .notifier,)
                        .confirmNewPassword(newPassword);
                  },
                  fullName: resetPasswordRequest.fullName,
                );
              },
              firebaseException: (ex) {
                return Text(ex.message);
              },
              loading: () => const LoadingWidget(),
              error: (e, s) => ErrorScreen(
                exception: e,
              ),
              weakPassword: () {
                return const Text('password troppo debole');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends HookConsumerWidget {
  final Function(String) onSave;
  final String fullName;

  const ResetPasswordForm({
    required this.onSave, required this.fullName, super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final controller = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fullName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          MUTextField(
            controller: controller,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            hintText: 'Inserisci la nuova password',
            validator: passwordValidator.call,
          ),
          MUTextField(
            controller: confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            hintText: 'Conferma la nuova password',
            validator: (value) {
              if (value == null) return null;
              if (value.trim() != controller.text.trim()) {
                return 'Le password non corrispondono';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          MUButton(
            text: 'Reimposta',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newPassword = controller.text.trim();
                final confirmPassword = controller.text.trim();
                if (newPassword == confirmPassword) {
                  onSave(newPassword);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
