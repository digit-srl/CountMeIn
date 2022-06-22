import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/screens/error.dart';
import '../../../../ui/screens/home.dart';
import '../../../../ui/widgets/loading.dart';
import '../../application/auth_notifier.dart';
import 'email_not_verified.dart';

class AuthGate extends ConsumerWidget {
  static const routeName = '/';

  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      authenticated: (firebaseUser) {
        return HomeScreen();
      },
      loading: () => LoadingWidget(),
      unauthenticated: () => SignInScreen(),
      emailNotVerified: (firebaseUser) =>
          Scaffold(body: EmailNotVerifiedScreen(firebaseUser: firebaseUser)),
      error: (err, stack) => ErrorScreen(),
    );
  }
}
