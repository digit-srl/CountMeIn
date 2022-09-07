import 'package:countmein/domain/entities/nation.dart';
import 'package:countmein/nazioni.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/domain/entities/gender.dart';
import 'package:countmein/src/common/ui/cmi_date_picker.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/user/data/dto/user_request.dart';
import 'package:countmein/src/user_register/application/user_registering_notifier.dart';
import 'package:countmein/src/user_register/application/user_registering_state.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:countmein/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codice_fiscale/codice_fiscale.dart';
import 'package:flutter_codice_fiscale/dao/city_dao.dart';
import 'package:flutter_codice_fiscale/models/city.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../src/common/mu_styles.dart';
import '../../domain/entities/cmi_provider.dart';
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

final selectedGenderProvider = StateProvider.autoDispose<Gender?>((ref) {
  return null;
});

class UserFormScreen extends ConsumerWidget {
  static const routeName = '/userForm';
  final CMIProvider cmiProvider;

  UserFormScreen({
    Key? key,
    required this.cmiProvider,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  DateTime? selectedBornDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameControllerProvider);
    final surnameController = ref.watch(surnameControllerProvider);
    final cfController = ref.watch(cfControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final selectedGender = ref.watch(selectedGenderProvider);

    ref.listen(userRegisteringProvider, (previous, next) {
      if (next is UserRegisteringLoading) {
        showDialog(
            context: context,
            builder: (c) => const Dialog(
                  child: UserRegisteringDialog(),
                ));
      }

      if (next is UserRegisteringUserCardSentByEmail ||
          next is UserRegisteringVerificationEmailSent) {
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
                  cmiProvider.name,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                CMITextField(
                  controller: nameController,
                  hintText: 'Nome',
                  validator: nameSurnameValidator,
                ),
                const SizedBox(height: 16),
                CMITextField(
                  controller: surnameController,
                  hintText: 'Cognome',
                  validator: nameSurnameValidator,
                ),
                const SizedBox(height: 16),
                // if (cmiProvider.releaseWom)
                CMITextField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: MyEmailValidator(errorText: 'Email non valida'),
                ),
                const SizedBox(height: 16),
                CMIDropdownButton<Gender>(
                  label: 'Sesso percepito',
                  validator: (v) {
                    if (v == null) {
                      return 'Questo campo è obbligatorio';
                    }
                    return null;
                  },
                  value: selectedGender,
                  onChanged: (v) {
                    if (v == null) return;
                    ref.read(selectedGenderProvider.notifier).state = v;
                  },
                  items: Gender.values
                      .map((e) => DropdownMenuItem<Gender>(
                          value: e, child: Text(e.text)))
                      .toList(),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Flexible(
                      child: CMITextField(
                        controller: cfController,
                        hintText: 'Codice Fiscale',
                        textCapitalization: TextCapitalization.characters,
                        validator: CFValidator(),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final cf = await showDialog(
                            context: context,
                            builder: (c) => Dialog(
                                  child: Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      child: const FormCodiceFiscale()),
                                ));

                        if (cf != null && cf is String && cf.isNotEmpty) {
                          cfController.text = cf;
                        }
                      },
                      child: const Text('Calcola'),
                    ),
                  ],
                ),

                // const FormCodiceFiscale(),
                const SizedBox(height: 32),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final name = nameController.text.trim();
                        final surname = surnameController.text.trim();
                        final email = emailController.text.trim();
                        final cf = cfController.text.trim().toUpperCase();
                        final gender =
                            enumToString(selectedGender) ?? 'notDeclared';

                        // if(cmiProvider.releaseWom){
                        if (email.isNotEmpty) {
                          ref.read(userRegisteringProvider.notifier).register(
                                UserRequest(
                                  name: name,
                                  surname: surname,
                                  cf: cf,
                                  email: email,
                                  providerId: cmiProvider.id,
                                  providerName: cmiProvider.name,
                                  gender: gender,
                                ),
                              );
                        }
                        // } else {
                        //   var user = UserCard(
                        //     id: const Uuid().v4(),
                        //     name: name,
                        //     surname: surname,
                        //     cf: cf,
                        //     email: email,
                        //     gender: gender,
                        //     addedOn: DateTime.now(),
                        //     secret: const Uuid().v4().substring(0, 8),
                        //   );
                        //
                        //   ref
                        //       .read(userRegisteringProvider.notifier)
                        //       .registerLocalUser(user);
                        // }
                      }
                    },
                    child: const Text('Iscriviti')),
                const SizedBox(height: 16),
                // TextButton(
                //     onPressed: () {},
                //     child: const Text('Recupera una precedente iscrizione')),
                // const SizedBox(height: 16),
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
        initial: () =>
            const SizedBox(height: 100, width: 100, child: LoadingWidget()),
        loading: () =>
            const SizedBox(height: 100, width: 100, child: LoadingWidget()),
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
            newUser
                ? "Abbiamo inviato una email di verifica all'indirizzo $email. "
                    "Una volta verificata la tua identità riceverai una mail con il tuo tesserino.\n\n"
                    "Non ha ricevuto la nostra email di verifica? Invia di nuovo"
                : "Non hai ancora verificato la tua email $email, controlla la tua casella postale e completa la verifica",
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
        invalidFiscalCode: () {
          return Column(
            children: [
              Text('Attenzione: il codice fiscale inserito non è valido!')
            ],
          );
        },
      ),
    );
  }
}

class FormCodiceFiscale extends HookConsumerWidget {
  const FormCodiceFiscale({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = useState<MyCity?>(null);
    final italian = useState<bool>(true);
    final selectedGender = useState<CodiceFiscaleGender>(CodiceFiscaleGender.M);
    final selectedDate = useState<DateTime?>(null);
    final nameController = ref.watch(nameControllerProvider);
    final surnameController = ref.watch(surnameControllerProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Calcola il tuo codice fiscale'),
          const SizedBox(height: 32),
          CMITextField(
            controller: nameController,
            hintText: 'Nome',
            validator: nameSurnameValidator,
          ),
          const SizedBox(height: 16),
          CMITextField(
            controller: surnameController,
            hintText: 'Cognome',
            validator: nameSurnameValidator,
          ),
          const SizedBox(height: 16),
          CMIDropdownButton<CodiceFiscaleGender>(
            label: 'Sesso',
            validator: (v) {
              if (v == null) {
                return 'Questo campo è obbligatorio';
              }
              return null;
            },
            value: selectedGender.value,
            onChanged: (v) {
              if (v == null) return;
              selectedGender.value = v;
            },
            items: CodiceFiscaleGender.values
                .map((e) => DropdownMenuItem<CodiceFiscaleGender>(
                    value: e, child: Text(enumToString(e) ?? '')))
                .toList(),
          ),
          const SizedBox(height: 16),
          CMIDatePicker(
            labelText: 'Data di nascita',
            onChanged: (DateTime value) {
              selectedDate.value = value;
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Sei un cittadino straniero?'),
              Switch(
                value: !italian.value,
                onChanged: (bool value) {
                  italian.value = !italian.value;
                  selectedCity.value = null;
                },
              ),
            ],
          ),
          /* CMIDropdownButton<MyCity>(
            label: italian.value
                ? 'Seleziona un comune di nascita'
                : 'Seleziona lo stato di nascita',
            value: selectedCity.value,
            onChanged: (c) {
              selectedCity.value = c;
            },
            items: italian.value
                ? allCities
                    .map((e) =>
                        DropdownMenuItem<MyCity>(value: e, child: Text(e.name)))
                    .toList()
                : nations
                    .map((e) =>
                        DropdownMenuItem<Nation>(value: e, child: Text(e.name)))
                    .toList(),
          ),*/
          const SizedBox(height: 16),
          DropdownSearch<MyCity>(
            compareFn: (c1, c2) {
              return c1.code == c2.code;
            },
            popupProps: const PopupProps.menu(
              searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(hintText: 'Cerca qui')),
              showSelectedItems: true, showSearchBox: true,
              // disabledItemFn: (String s) => s.startsWith('I'),
            ),
            items: italian.value ? allCities : nations,
            dropdownButtonProps: const DropdownButtonProps(autofocus: true),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText:
                    italian.value ? 'Comune di nascita' : 'Nazione nativa',
                hintText: italian.value
                    ? 'Seleziona un comune di nascita'
                    : 'Seleziona la tua nazione nativa',
              ),
            ),
            onChanged: (city) {
              selectedCity.value = city;
            },
            selectedItem: selectedCity.value,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final cod = CodiceFiscale(
                firstName: nameController.text.trim(),
                lastName: surnameController.text.trim(),
                birthCity: selectedCity.value,
                gender: selectedGender.value,
                birthDate: selectedDate.value ?? DateTime.now(),
              );
              if (CodiceFiscale.check(cod.fiscalCode)) {
                Navigator.of(context).pop(cod.fiscalCode);
              }
            },
            child: const Text('Calcola'),
          ),
        ],
      ),
    );
  }
}
