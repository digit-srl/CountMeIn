import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/cmi_provider_request.dart';
import '../../src/auth/ui/screens/sign_in.dart';
import '../../src/common/ui/widgets/my_button.dart';
import '../../src/common/ui/widgets/my_text_field.dart';

final releaseWomProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
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
    final providerNameController = useTextEditingController();
    final restrictionDomainController = useTextEditingController();
    final releaseWom = ref.watch(releaseWomProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                context.push(AdminDashboardScreen.routeName);
              }),
        ],
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 600,maxHeight: 600),
            alignment: Alignment.center,
            child: Card(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text('Registra un provider',style: Theme.of(context).textTheme.headline4,),
                    MUTextField(
                      controller: nameController,
                      labelText: 'Nome',
                      validator: textValidator,
                    ),
                    MUTextField(
                      controller: surnameController,
                      labelText: 'Cognome',
                      validator: textValidator,
                    ),
                    MUTextField(
                      controller: emailController,
                      labelText: 'Email amministatore',
                      validator: emailValidator,
                    ),
                    MUTextField(
                      controller: providerNameController,
                      labelText: 'Nome Provider',
                      validator: textValidator,
                    ),
                    MUTextField(
                      controller: restrictionDomainController,
                      labelText: 'Restrizione dominio email',
                      // validator: textValidator,
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: MUButton(
                        text: 'Richiedi attivazione',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final name = nameController.text.trim();
                            final surname = surnameController.text.trim();
                            final email = emailController.text.trim();
                            final activityName = providerNameController.text.trim();
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
