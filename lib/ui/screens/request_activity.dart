import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/ui/screens/user_register_form.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../src/common/mu_styles.dart';
import 'package:dart_wom_connector/dart_wom_connector.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:uuid/uuid.dart';
import '../../constants.dart';
import '../../domain/entities/cmi_provider_request.dart';
import '../../src/auth/ui/screens/sign_in.dart';
import '../../src/common/ui/widgets/cmi_container.dart';
import '../../src/common/ui/widgets/my_button.dart';
import '../../src/common/ui/widgets/my_text_field.dart';

final acceptPolicyProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final releaseWomProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

final womIntegrationProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final selectedInstrumentProvider = StateProvider<Instrument?>((ref) {
  return null;
});

final womPasswordControllerProvider = Provider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

final womEmailControllerProvider = Provider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() {
    c.dispose();
  });
  return c;
});

class ActivityRequestScreen extends StatefulHookConsumerWidget {
  static const routeName = '/activityRequest';

  const ActivityRequestScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ActivityRequestScreenState();
}

class _ActivityRequestScreenState extends ConsumerState<ActivityRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final surnameController = useTextEditingController();
    final emailController = useTextEditingController();
    final adminCfController = useTextEditingController();
    final cfController = useTextEditingController();
    final providerNameController = useTextEditingController();
    final restrictionDomainController = useTextEditingController();
    final releaseWom = ref.watch(releaseWomProvider);
    final acceptPolicy = ref.watch(acceptPolicyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Richiesta nuovo provider')),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(64),
              constraints: const BoxConstraints(maxWidth: 600, minHeight: 600),
              alignment: Alignment.center,
              child: CMICard(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          'Registra un provider',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        MUTextField(
                          controller: providerNameController,
                          labelText: 'Nome Provider',
                          validator: textValidator,
                        ),
                        MUTextField(
                          controller: cfController,
                          labelText: 'P. Iva o CF',
                          validator: textValidator,
                        ),
                        MUTextField(
                          controller: restrictionDomainController,
                          labelText:
                              'Restrizione dominio email utenti (facoltativo)',
                          // validator: textValidator,
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        MUTextField(
                          controller: nameController,
                          labelText: 'Nome Richiedente',
                          validator: textValidator,
                        ),
                        MUTextField(
                          controller: surnameController,
                          labelText: 'Cognome Richiedente',
                          validator: textValidator,
                        ),
                        MUTextField(
                          controller: emailController,
                          labelText: 'Email Richiedente',
                          validator: emailValidator,
                        ),
                        MUTextField(
                          controller: adminCfController,
                          labelText: 'C.F. Richiedente',
                          validator: textValidator,
                        ),
                        const SizedBox(height: 16),
                        const WomIntegrationPanel(),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                                value: acceptPolicy,
                                onChanged: (v) {
                                  if (v == null) return;
                                  ref
                                      .read(acceptPolicyProvider.notifier)
                                      .state = v;
                                }),
                            const SizedBox(width: 16),
                            Flexible(
                              child: EasyRichText(
                                'Accetta l\'informativa per richiedere l\'attivazione di un nuovo provider',
                                defaultStyle:
                                    Theme.of(context).textTheme.caption,
                                patternList: [
                                  EasyRichTextPattern(
                                      targetString: 'informativa',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //context.push(ActivityRequestScreen.routeName);
                                        },
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.bold
                                          .underline),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: MUButton(
                            text: 'Richiedi attivazione',
                            onPressed: acceptPolicy
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      final name = nameController.text.trim();
                                      final surname =
                                          surnameController.text.trim();
                                      final email = emailController.text.trim();
                                      final cf = adminCfController.text.trim();
                                      final pIva = cfController.text.trim();
                                      final activityName =
                                          providerNameController.text.trim();
                                      final restrictionDomain =
                                          restrictionDomainController.text
                                              .trim();

                                      final selectedInstrument =
                                          ref.read(selectedInstrumentProvider);
                                      final result = await _signUp(
                                        ref,
                                        context,
                                        name,
                                        surname,
                                        email,
                                        cf,
                                        activityName,
                                        restrictionDomain,
                                        releaseWom,
                                        pIva,
                                        selectedInstrument,
                                      );

                                      if (result) {
                                        nameController.clear();
                                        surnameController.clear();
                                        emailController.clear();
                                        cfController.clear();
                                        adminCfController.clear();
                                        providerNameController.clear();
                                        restrictionDomainController.clear();
                                        ref
                                            .read(
                                                womIntegrationProvider.notifier)
                                            .state = false;
                                        ref
                                            .read(selectedInstrumentProvider
                                                .notifier)
                                            .state = null;
                                        ref
                                            .read(womEmailControllerProvider)
                                            .clear();
                                        ref
                                            .read(womPasswordControllerProvider)
                                            .clear();

                                        CoolAlert.show(
                                            context: context,
                                            width: 400,
                                            type: CoolAlertType.success,
                                            text:
                                                'La richiesta è stata inviata con successo!');
                                      }
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signUp(
    WidgetRef ref,
    BuildContext context,
    String name,
    String surname,
    String email,
    String cf,
    String providerName,
    String restrictionDomain,
    bool releaseWom,
    String pIva,
    Instrument? instrument,
  ) async {
    try {
      String? apiKey;
      if (instrument != null) {
        final u = ref.read(womEmailControllerProvider).text.trim();
        final p = ref.read(womPasswordControllerProvider).text.trim();

        apiKey = await InstrumentClient.createNewApiKey(
          u,
          p,
          womDomain,
          'cmi-wom-integration',
          instrument.id,
        );
      }

      final activity = CMIProviderRequest(
        id: const Uuid().v4(),
        name: providerName,
        adminEmail: email,
        adminName: name,
        adminSurname: surname,
        adminCF: cf,
        requestedOn: DateTime.now(),
        domainRequirement: restrictionDomain,
        releaseWom: releaseWom,
        womApiKey: apiKey,
        pIva: pIva,
        aims: instrument?.enabledAims.toList() ?? <String>[],
        status: CMIProviderStatus.pending,
      );

      setState(() {
        isLoading = true;
      });
      await Cloud.providerRequests.doc(activity.id).set(activity.toJson());
      setState(() {
        isLoading = false;
      });
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}

class WomIntegrationPanel extends StatefulHookConsumerWidget {
  const WomIntegrationPanel({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _WomIntegrationPanelState();
}

class _WomIntegrationPanelState extends ConsumerState<WomIntegrationPanel> {
  @override
  Widget build(BuildContext context) {
    final womIntegration = ref.watch(womIntegrationProvider);
    final womEmailController = ref.watch(womEmailControllerProvider);
    final womPasswordController = ref.watch(womPasswordControllerProvider);
    final instrumentUser = useState<InstrumentUser?>(null);
    final loading = useState<bool>(false);
    final selectedInstrument = ref.watch(selectedInstrumentProvider);

    return CMICard(
      inverseColor: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Integrazione WOM',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
              Switch(
                  value: womIntegration,
                  onChanged: (v) {
                    ref.read(womIntegrationProvider.notifier).state = v;
                  })
            ],
          ),
          const Text(
              'Se sei già proprietario di un Instrument puoi collegare le due piattaforme'),
          if (womIntegration)
            if (loading.value)
              SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (instrumentUser.value != null) ...[
              const SizedBox(height: 16),
              InputDecorator(
                decoration: InputDecoration(),
                child: DropdownButton<Instrument>(
                  isDense: true,
                  isExpanded: true,
                  underline: Container(),
                  value: selectedInstrument,
                  hint: const Text('Seleziona instrument'),
                  items: instrumentUser.value!.instruments
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                  onChanged: (instrument) {
                    ref.read(selectedInstrumentProvider.notifier).state =
                        instrument;
                  },
                ),
              ),
              if (selectedInstrument != null &&
                  selectedInstrument.enabledAims.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Aim abilitati'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4.0,
                  children: selectedInstrument.enabledAims
                      .map((e) =>
                          Tooltip(message: e, child: Chip(label: Text(e))))
                      .toList(),
                ),
              ]
            ] else ...[
              MUTextField(
                controller: womEmailController,
                labelText: 'Email Instrument',
                validator: emailValidator,
              ),
              MUTextField(
                controller: womPasswordController,
                labelText: 'Password Instrument',
                validator: passwordValidator,
              ),
              const SizedBox(height: 32),
              MUButton(
                text: 'Connetti piattaforma WOM',
                onPressed: () async {
                  loading.value = true;
                  final username = womEmailController.text.trim();
                  final password = womPasswordController.text;

                  final instrument = await InstrumentClient.authenticate(
                      username, password, womDomain);
                  // final instrument = await InstrumentClient.authenticate(
                  //     'alessandro.bogliolo@uniurb.it',
                  //     'D1GIT!',
                  //     'dev.wom.social');
                  loading.value = false;
                  print(instrument);
                  setState(() {
                    instrumentUser.value = instrument;
                  });
                },
              ),
            ],
        ],
      ),
    );
  }
}
