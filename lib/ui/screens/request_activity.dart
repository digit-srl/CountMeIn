import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:dart_wom_connector/dart_wom_connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/cmi_provider_request.dart';
import '../../src/auth/ui/screens/sign_in.dart';
import '../../src/common/ui/widgets/cmi_container.dart';
import '../../src/common/ui/widgets/my_button.dart';
import '../../src/common/ui/widgets/my_text_field.dart';

final releaseWomProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

final womIntegrationProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
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

    return Scaffold(
      appBar: AppBar(title:Text('Richiesta nuovo provider')),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(64),
              constraints: BoxConstraints(maxWidth: 600, minHeight: 600),
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
                          controller: nameController,
                          labelText: 'Nome Amministratore',
                          validator: textValidator,
                        ),
                        MUTextField(
                          controller: surnameController,
                          labelText: 'Cognome Amministratore',
                          validator: textValidator,
                        ),

                        MUTextField(
                          controller: emailController,
                          labelText: 'Email Amministatore',
                          validator: emailValidator,
                        ),MUTextField(
                          controller: cfController,
                          labelText: 'C.F. Amministratore',
                          validator: textValidator,
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
                          labelText: 'Restrizione dominio email',
                          // validator: textValidator,
                        ),
                        const SizedBox(height: 16),
                        const WomIntegrationPanel(),
                        const SizedBox(height: 32),
                        Center(
                          child: MUButton(
                            text: 'Richiedi attivazione',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final name = nameController.text.trim();
                                final surname = surnameController.text.trim();
                                final email = emailController.text.trim();
                                final activityName =
                                    providerNameController.text.trim();
                                final restrictionDomain =
                                    restrictionDomainController.text.trim();
                                _signUp(
                                  ref,
                                  context,
                                  name,
                                  surname,
                                  email,
                                  activityName,
                                  restrictionDomain,
                                  releaseWom,
                                );
                              }
                            },
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
    String activityName,
    String restrictionDomain,
    bool releaseWom,
  ) async {
    final activity = CMIProviderRequest(
      id: const Uuid().v4(),
      providerName: activityName,
      adminEmail: email,
      adminName: name,
      adminSurname: surname,
      requestedOn: DateTime.now(),
      domainRequirement: restrictionDomain,
      releaseWom: releaseWom,
    );
    try {
      setState(() {
        isLoading = true;
      });
      await Cloud.providerRequests.doc(activity.id).set(activity.toJson());
      setState(() {
        isLoading = false;
      });
      CoolAlert.show(context: context, type: CoolAlertType.success);
    } catch (ex) {
      print(ex);
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
    final womEmailController = useTextEditingController();
    final womPasswordController = useTextEditingController();
    final instrumentUser = useState<InstrumentUser?>(null);
    final selectedInstrument = useState<Instrument?>(null);

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
              Spacer(),
              Switch(
                  value: womIntegration,
                  onChanged: (v) {
                    ref.read(womIntegrationProvider.notifier).state = v;
                  })
            ],
          ),
          Text(
              'Se sei già proprietario di un Instrument puoi collegare le due piattaforme'),
          if (womIntegration)
            if (instrumentUser.value != null) ...[
              const SizedBox(height: 16),
              DropdownButton<Instrument>(
                underline: Divider(),
                value: selectedInstrument.value,
                hint: Text('Seleziona instrument'),
                items: instrumentUser.value!.instruments
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (instrument) {
                  setState(() {
                    selectedInstrument.value = instrument;
                  });
                },
              ),
              if (selectedInstrument.value != null &&
                  selectedInstrument.value!.enabledAims.isNotEmpty) ...[
                Text('Aim abilitati'),
                const SizedBox(height: 8),
                Row(
                  children: selectedInstrument.value!.enabledAims
                      .map((e) => Chip(label: Text(e)))
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
                  final username = womEmailController.text.trim();
                  final password = womPasswordController.text;

                  final instrument = await InstrumentClient.authenticate(
                      username, password, 'dev.wom.social');
                  // final instrument = await InstrumentClient.authenticate(
                  //     'alessandro.bogliolo@uniurb.it',
                  //     'D1GIT!',
                  //     'dev.wom.social');
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
