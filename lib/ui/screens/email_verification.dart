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
          verified: () => Text('verified'),
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
