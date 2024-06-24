import 'package:countmein/src/admin/application/confirm_invite_state.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/ui/widgets/cf_text_field.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/src/common/ui/widgets/my_text_field.dart';

class InviteFormConfirmScreen extends HookConsumerWidget {
  static const routeName = '/confirmInvite';

  final InviteRequest request;

  InviteFormConfirmScreen({required this.request, super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(confirmInviteProvider(request));
    final nameController = useTextEditingController();
    final surnameController = useTextEditingController();
    final adminCfController = useTextEditingController();
    final isLoading = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Conferma invito')),
      body: LoadingOverlay(
        isLoading: isLoading.value,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(64),
              constraints: const BoxConstraints(maxWidth: 600, minHeight: 600),
              alignment: Alignment.center,
              child: CMICard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Sei invitato a gestire il provider ${request.providerName}.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    state.when(
                      loading: () => const LoadingWidget(),
                      inviteExpired: () =>
                          const Text('Il tuo invito è scaduto.'),
                      userAlreadyRegistered: () {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                        confirmInviteProvider(request).notifier,)
                                    .confirmInvite();
                              },
                              child: const Text('Conferma invito'),
                            ),
                          ],
                        );
                      },
                      newUser: () {
                        return Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'Registrati alla piattaforma per confermare l\'invito.',),
                                const SizedBox(height: 16),
                                MUTextField(
                                  controller: nameController,
                                  labelText: 'Nome',
                                  validator: textValidator.call,
                                ),
                                MUTextField(
                                  controller: surnameController,
                                  labelText: 'Cognome',
                                  validator: textValidator.call,
                                ),
                                CFTextField(
                                  controller: adminCfController,
                                ),
                                const SizedBox(height: 32),
                                Center(
                                  child: MUButton(
                                    text: 'Conferma',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final name = nameController.text.trim();
                                        final surname =
                                            surnameController.text.trim();
                                        final cf =
                                            adminCfController.text.trim();

                                        ref
                                            .read(confirmInviteProvider(request)
                                                .notifier,)
                                            .confirmInvite(
                                                name: name,
                                                surname: surname,
                                                cf: cf,);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      error: (err, st) => Text(err.toString()),
                      response: (ConfirmInviteResponseStatus status) {
                        return Column(
                          children: [
                            Text(
                              status.message,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            if (status ==
                                    ConfirmInviteResponseStatus.completed ||
                                status ==
                                    ConfirmInviteResponseStatus
                                        .alreadyConfirmed) ...[
                              const SizedBox(height: 16),
                              MUButton(
                                text: 'Vai alla dashboard',
                                onPressed: () {
                                  context.go(AdminDashboardScreen.path);
                                },
                              ),
                            ],
                          ],
                        );
                      },
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
}
