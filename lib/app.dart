import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/ui/screens/email_verification.dart';
import 'package:countmein/ui/screens/request_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';

import 'constants.dart';
import 'ui/screens/admin_user_details.dart';
import 'ui/screens/error.dart';
import 'ui/screens/home.dart';
import 'ui/screens/user_console.dart';
import 'ui/screens/user_event.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: ActivityRequestScreen.routeName,
        builder: (context, state) => const ActivityRequestScreen(),
      ),
      GoRoute(
        path: '${UserConsoleScreen.routeName}/:userId',
        builder: (context, state) => UserConsoleScreen(
          userId: state.params['userId']!,
        ),
      ),
      GoRoute(
        path: '${UserEventScreen.routeName}/:eventId',
        builder: (context, state) {
          return Container();
        },
      ),
      GoRoute(
        path: '/activity/:activityId',
        builder: (context, state) {
          return UserEventScreen(
            activityId: state.params['activityId']!,
          );
        },
      ),
      GoRoute(
        path: UserDetailsScreen.routeName,
        builder: (context, state) {
          return UserDetailsScreen(user: state.extra! as UserCard);
        },
      ),
      GoRoute(
        path: '${EmailVerificationScreen.routeName}/:userId/:secret',
        builder: (context, state) {
          return EmailVerificationScreen(
            userId: state.params['userId'] as String,
            secret: state.params['secret'] as String,
          );
        },
      ),
      /*GoRoute(
        path: '/page2',
        builder: (context, state) => const Page2Screen(),
      ),*/
    ], // redirect to the login page if the user is not logged in
    redirect: (state) {
      print(state.location);
      print(state.subloc);
      final isEventRoute = state.subloc.startsWith('/event');

      if (isEventRoute) {
        print('is event route');
        return state.subloc.replaceFirst('/event', '/activity');
        return '/activities/${state.params['id']!}';
      }

      // no need to redirect at all
      return null;
    },
    initialLocation: HomeScreen.routeName,
    errorBuilder: (context, state) => ErrorScreen(
      exception: state.error,
    ),
  );
  return router;
});

class MyApp extends ConsumerWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =
        ThemeData(colorSchemeSeed: isMaster ? Colors.blue : Colors.green);
    final router = ref.watch(goRouterProvider);
    return OKToast(
      child: MaterialApp.router(
        theme: theme,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }*/
}
