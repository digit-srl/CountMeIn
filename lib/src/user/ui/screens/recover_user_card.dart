import 'package:countmein/src/common/ui/widgets/cf_text_field.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/user/application/user_card_recovering_notifier.dart';
import 'package:countmein/src/user/ui/widgets/user_profile.dart';
import 'package:countmein/src/user/ui/widgets/waiting_otp_code.dart';
import 'package:countmein/ui/widgets/cmi_error_widget.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecoverUserCard extends StatefulHookConsumerWidget {
  static const routeName = 'recover';

  final String providerId;

  const RecoverUserCard({
    required this.providerId, super.key,
  });

  @override
  ConsumerState createState() => _RestoreUserCardState();
}

class _RestoreUserCardState extends ConsumerState<RecoverUserCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cfController = useTextEditingController();
    final state = ref.watch(userCardRecoveringProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CMICard(
          animated: true,
          constraints: const BoxConstraints(maxWidth: 500),
          child: state.when(
            initial: () {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        'Recupera il tuo tesserino inserendo il tuo codice fiscale!',),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          child: CFTextField(
                            controller: cfController,
                          ),
                        ),
                        /*TextButton(
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
                    ),*/
                        const SizedBox(width: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final cf = cfController.text.trim();
                              ref
                                  .read(userCardRecoveringProvider.notifier)
                                  .check(cf, widget.providerId);
                            }
                          },
                          child: const Text('Controlla'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            loading: () => const LoadingWidget(),
            profile: (ids) {
              return UserProfileDataWidget(
                userIds: ids,
              );
            },
            error: (ex, st) {
              return CMIErrorWidget(
                stacktrace: st,
                tryAgain: () {
                  ref.read(userCardRecoveringProvider.notifier).reset();
                },
              );
            },
            waitingOtpCode: (ids) {
              return WaitingOtpCode(
                  userIds: ids,
                  verify: (otpCode) {
                    ref
                        .read(userCardRecoveringProvider.notifier)
                        .verifyOtpCode(ids, otpCode);
                  },);
            },
            userNotExists: () => CMIWarningWidget(
              message: 'Non esiste nessun utente verificato con questo codice fiscale!',
              tryAgain: () {
                ref.read(userCardRecoveringProvider.notifier).reset();
              },
            ),
            invalidFiscalCode: () => CMIWarningWidget(
              message: 'Il codice fiscale inserito non è valido',
              tryAgain: () {
                ref.read(userCardRecoveringProvider.notifier).reset();
              },
            ),
          ),
        ),
      ),
    );
  }
}
