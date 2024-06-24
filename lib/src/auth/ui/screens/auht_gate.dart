

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:countmein/ui/screens/home.dart';

class AuthGate extends ConsumerWidget {
  static const routeName = '/';

  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return const HomeWebScreen();

    // if(kIsWeb || Platform.isMacOS){
    //   return HomeWebScreen();
    // }
    //
    // // return ActivitiesScreen();
    // final authState = ref.watch(authStateProvider);
    // return authState.when(
    //   authenticated: (firebaseUser) {
    //     return ActivitiesScreen(userId: firebaseUser.uid,);
    //   },
    //   loading: () => const LoadingWidget(),
    //   unauthenticated: () => SignInScreen(),
    //   emailNotVerified: (firebaseUser) =>
    //       Scaffold(body: EmailNotVerifiedScreen()),
    //   error: (err, stack) => ErrorScreen(exception: err,),
    // );
  }
}
