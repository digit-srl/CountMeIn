import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
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
      .where((element) => element.role == UserRole.scanner)
      .toList();
});

class AddScannerWidget extends HookConsumerWidget {
  final CMIProvider provider;
  final CMIEvent event;

  const AddScannerWidget({
    Key? key,
    required this.provider,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final scanners = ref.watch(scannersProvider(provider.id));
    final selectedScanner = useState<ProviderManager?>(null);

    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nuovo scanner',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 32),
          if (scanners.isNotEmpty) ...[
            const Text(
              'Seleziona uno scanner esistente',
            ),
            Row(
              children: [
                Flexible(
                  child: CMIDropdownButton<ProviderManager?>(
                    value: selectedScanner.value,
                    onChanged: (value) {
                      nameController.clear();
                      emailController.clear();
                      selectedScanner.value = value;
                    },
                    items: scanners
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
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Flexible(
                child: CMITextField(
                  controller: nameController,
                  hintText: 'Nome',
                  enabled: selectedScanner.value == null,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: CMITextField(
                  controller: emailController,
                  hintText: 'Email',
                  enabled: selectedScanner.value == null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final email = emailController.text.trim();
                    final n = Navigator.of(context);
                    await addScanner(name, email);
                    n.pop();
                  },
                  child: const Text('Aggiungi'))),
        ],
      ),
    );
  }

  addScanner(String name, String email) async {
    final newManager = PendingProviderManager(
      id: const Uuid().v4(),
      role: UserRole.scanner,
      name: name,
      status: ProviderManagerStatus.pending,
      invitedOn: DateTime.now(),
      email: email,
      secret: '',
      providerName: provider.name,
      eventsRestriction: [event.id],
    );
    await Cloud.pendingInviteCollection(provider.id)
        .doc(newManager.id)
        .set(newManager.toJson());
  }
}
