import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:uuid/uuid.dart';

import '../../src/auth/ui/screens/sign_in.dart';
import '../../src/common/ui/widgets/my_button.dart';
import '../../src/common/ui/widgets/my_text_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final surnameController = useTextEditingController();
    final emailController = useTextEditingController();
    final activityNameController = useTextEditingController();
    final isLoading = false;

    return Scaffold(
      appBar: AppBar(),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
                labelText: 'Email',
                validator: emailValidator,
              ),
              MUTextField(
                controller: activityNameController,
                labelText: 'Nome Attivit??',
                validator: textValidator,
              ),
              const SizedBox(height: 16),
              MUButton(
                text: 'Richiedi attivit??',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = nameController.text.trim();
                    final surname = surnameController.text.trim();
                    final email = emailController.text.trim();
                    final activityName = activityNameController.text.trim();
                    _signUp(name, surname, email, activityName, ref, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signUp(String name, String surname, String email, String activityName,
      WidgetRef ref, BuildContext context) async {
    print('$name, $surname, $email, $activityName');
    final activity = CMIProvider(
      id: Uuid().v4(),
      name: activityName,
      status: CMIProviderStatus.pending,
      requestedOn: DateTime.now(),
      createdOn: DateTime.now()
    );
    await Cloud.providerRequests.doc(activity.id).set(activity.toJson());
  }
}
