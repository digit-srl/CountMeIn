import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/ui/validators.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

final scannersProvider = Provider.family
    .autoDispose<List<ProviderManager>, String>((ref, providerId) {
  final managers =
      ref.watch(singleCMIProviderProvider(providerId)).valueOrNull?.managers ??
          {};
  return managers.values
      .where((element) => collaboratorsEventRole.contains(element.role))
      .toList();
});

class AddScannerWidget extends HookConsumerWidget {
  final CMIProvider provider;
  final CMIEvent event;

  const AddScannerWidget({
    super.key,
    required this.provider,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final selectedScanner = useState<ProviderManager?>(null);
    final selectedRole = useState<UserRole>(UserRole.scanner);
    final providerCollaborators = ref.watch(scannersProvider(provider.id));
    final eventCollaborators = providerCollaborators
        .where((c) => !(event.managers?.keys.contains(c.id) ?? false));

    return Form(
      key: formKey,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 650),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nuovo collaboratore',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 32),
            const Text(
              'Seleziona ruolo',
            ),
            const SizedBox(height: 4),
            CMIDropdownButton<UserRole>(
              value: selectedRole.value,
              onChanged: (value) {
                if (value == null) return;
                selectedRole.value = value;
              },
              items: collaboratorsEventRole
                  .map(
                    (e) => DropdownMenuItem<UserRole>(
                      value: e,
                      child: Text(e.text),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            if (eventCollaborators.isNotEmpty) ...[
              const Text(
                'Seleziona uno scanner esistente',
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Flexible(
                    child: CMIDropdownButton<ProviderManager?>(
                      value: selectedScanner.value,
                      onChanged: (value) {
                        selectedScanner.value = value;
                        nameController.text = value?.name ?? '';
                        emailController.text = value?.email ?? '';
                        formKey.currentState!.validate();
                      },
                      items: eventCollaborators
                          .map(
                            (e) => DropdownMenuItem<ProviderManager?>(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    color: Colors.red,
                    onPressed: () {
                      selectedScanner.value = null;
                      nameController.clear();
                      emailController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            const Text('oppure invita un nuovo utente come scanner'),
            const SizedBox(height: 4),
            Row(
              children: [
                Flexible(
                  child: CMITextField(
                    controller: nameController,
                    hintText: 'Nome',
                    enabled: selectedScanner.value == null,
                    validator: nameSurnameValidator,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CMITextField(
                    controller: emailController,
                    hintText: 'Email',
                    enabled: selectedScanner.value == null,
                    validator: emailValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final n = Navigator.of(context);
                  await addCollaborator(name, email, selectedRole.value);
                  n.pop();
                },
                child: const Text('Aggiungi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addCollaborator(String name, String email, UserRole role) async {
    final newManager = PendingProviderManager(
      id: const Uuid().v4(),
      role: role,
      name: name,
      status: ProviderManagerStatus.pending,
      invitedOn: DateTime.now(),
      email: email,
      secret: '',
      providerName: provider.name,
      eventId: event.id,
    );
    await Cloud.pendingInviteCollection(provider.id)
        .doc(newManager.id)
        .set(newManager.toJson());
  }
}
