import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/src/auth/application/email_verification_notifier.dart';
import 'package:countmein/src/auth/application/email_verification_state.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/user/ui/widgets/user_profile.dart';
import 'package:countmein/ui/screens/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// /verification/FeLKxhlYU1b6eAuSbklC/hJ0FJRsf/Yy31B32YBDJDUt7TbZEl/5BmjKLbmuTqqjl4PfdUH
class EmailVerificationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/verification';
  final String secret;
  final String providerId;
  final String userId;

  // final String privateId;

  const EmailVerificationScreen({
    Key? key,
    required this.userId,
    required this.secret,
    required this.providerId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final verificationState = ref.watch(
      emailVerificationProvider(
        EmailVerificationData(
          secret: widget.secret,
          userId: widget.userId,
          providerId: widget.providerId,
          // privateId: widget.privateId,
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: CMICard(
          child: verificationState.when(
            initial: () {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'Clicca il pulsante per verificare il tuo indirizzo email'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(emailVerificationProvider(
                            EmailVerificationData(
                              secret: widget.secret,
                              userId: widget.userId,
                              providerId: widget.providerId,
                              // privateId: widget.privateId,
                            ),
                          ).notifier)
                          .verify();
                    },
                    child: const Text('Verifica'),
                  ),
                ],
              );
            },
            // verified: () => const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //       'Il tuo indirizzo email è stato verificato. Riceverai a breve il tuo tesserino.\n'
            //       'Your email address has been properly verified. You\'ll receive your badge shortly.'),
            // ),
            verifiedWithAnotherEmail: () {
              return const Text(
                'Profilo già verificato con un altro link di verifica',
              );
            },
            verified: () {
              return UserProfileDataWidget(
                userIds: UserIds(
                  userId: widget.userId,
                  providerId: widget.providerId,
                ),
              );
            },
            userNotExist: () => const Text('userNotExist'),
            invalidData: () => const Text('invalidData'),
            loading: () => const CircularProgressIndicator(),
            error: (ex, st) => ErrorScreen(
              exception: ex as Exception,
            ),
          ),
        ),
      ),
    );
  }
}
