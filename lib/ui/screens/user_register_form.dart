import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/user_register/application/user_registering_notifier.dart';
import 'package:countmein/src/user_register/application/user_registering_state.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../src/common/mu_styles.dart';
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

    ref.listen(userRegisteringProvider, (previous, next) {
      if (previous != null &&
          previous is UserRegisteringInitial &&
          next is UserRegisteringLoading) {
        showDialog(
            context: context, builder: (c) => const Dialog(child: UserRegisteringDialog(),));
      } else if (next is UserRegisteringUserCardSentByEmail) {
        nameController.clear();
        surnameController.clear();
        cfController.clear();
        emailController.clear();
      }
    });

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
                if (activity.releaseWom)
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final name = nameController.text.trim();
                        final surname = surnameController.text.trim();
                        final email = emailController.text.trim();
                        final cf = cfController.text.trim().toUpperCase();

                        var user = UserCard(
                          id: const Uuid().v4(),
                          name: name,
                          surname: surname,
                          cf: cf,
                          email: email,
                          addedOn: DateTime.now(),
                          secret: Uuid().v4().substring(0,8)
                        );

                        ref
                            .read(userRegisteringProvider.notifier)
                            .register(activity, user);
                      }
                    },
                    child: const Text('Iscriviti')),
                const SizedBox(height: 16),
                TextButton(
                    onPressed: () {},
                    child: const Text('Recupera una precedente iscrizione')),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserRegisteringDialog extends ConsumerWidget {
  const UserRegisteringDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registeringState = ref.watch(userRegisteringProvider);
    return AnimatedContainer(
      padding: const EdgeInsets.all(16),
      duration: const Duration(milliseconds: 300),
      child: registeringState.when(
        initial: () => const LoadingWidget(),
        loading: () => const LoadingWidget(),
        userCardSentByEmail: (email) {
          return EasyRichText(
            "Potrai scaricare il tuo tesserino dall'email che abbiamo inviato all'indirizzo $email. ",
            defaultStyle: Theme.of(context).textTheme.bodyText1,
            patternList: [
              EasyRichTextPattern(
                  targetString: email,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: Theme.of(context).textTheme.bodyText1?.bold.underline),
            ],
          );
        },
        verificationEmailSent: (bool newUser, String email) {
          return EasyRichText(
            "Abbiamo inviato una email di verifica all'indirizzo $email. "
            "Una volta verificata la tua identità riceverai una mail con il tuo tesserino.\n\n"
            "Non ha ricevuto la nostra email di verifica? Invia di nuovo",
            defaultStyle: Theme.of(context).textTheme.bodyText1,
            patternList: [
              EasyRichTextPattern(
                  targetString: email,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: Theme.of(context).textTheme.bodyText1?.bold.underline),
              EasyRichTextPattern(
                  targetString: 'Invia di nuovo',
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: Theme.of(context).textTheme.bodyText1?.bold.underline),
            ],
          );
        },
        error: (ex, st) => ErrorWidget(ex),
      ),
    );
  }
}
