import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/ui/screens/admin_user_details.dart';
import 'package:countmein/ui/screens/request_activity.dart';
import 'package:countmein/ui/screens/user_console.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:countmein/ui/screens/error.dart';
import 'package:countmein/ui/screens/home.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'domain/entities/user_card.dart';
import 'firebase_options.dart';

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'ui/screens/user_event.dart';

enum AppFlavor { master, collab }

// fvm flutter build web --web-renderer canvaskit
// fvm flutter build apk --dart-define=DEFINE_APP_NAME=+CountMeInMaster --dart-define=DEFINE_APP_SUFFIX=.master --dart-define=DEFINE_FLAVOR=master
// fvm flutter build apk --dart-define=DEFINE_APP_NAME=CountMeIn --dart-define=DEFINE_APP_SUFFIX=.collab --dart-define=DEFINE_FLAVOR=collab
// firebase emulators:start --import=./emulator_backup --export-on-exit

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(flavor),
  );
  //
  // if (kDebugMode) {
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // }

  if (kIsWeb) {
    await FirebaseFirestore.instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } else {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }
  await Hive.openBox('user');
  setPathUrlStrategy();
  runApp(ProviderScope(child: MyApp()));
}

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
