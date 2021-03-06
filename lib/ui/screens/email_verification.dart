import 'package:countmein/src/auth/application/email_verification_notifier.dart';
import 'package:countmein/src/auth/application/email_verification_state.dart';
import 'package:countmein/ui/screens/error.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/verification';
  final String secret;
  final String userId;

  const EmailVerificationScreen({
    Key? key,
    required this.secret,
    required this.userId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final verificationState = ref.watch(emailVerificationProvider(
        EmailVerificationData(secret: widget.secret, userId: widget.userId)));
    return Scaffold(
      body: Center(
        child: verificationState.when(
          verified: () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Il tuo indirizzo email è stato verificato. Riceverai a breve il tuo tesserino.\n'
                    'Your email address has been properly verified. You\'ll receive your badge shortly.'),
          ),
          userNotExist: () => Text('userNotExist'),
          invalidData: () => Text('invalidData'),
          loading: () => LoadingWidget(),
          error: (ex, st) => ErrorScreen(
            exception: ex as Exception,
          ),
        ),
      ),
    );
  }
}
