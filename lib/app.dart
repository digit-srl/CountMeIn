import 'package:countmein/router.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';

/*
final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AuthGate.routeName,
    routes: [
      GoRoute(
        path: AuthGate.routeName,
        builder: (context, state) => const AuthGate(),
      ),
      GoRoute(
        path: AdminDashboardScreen.routeName,
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: AdminPendingProvidersScreen.routeName,
        builder: (context, state) => AdminPendingProvidersScreen(

        ),
      ),
      GoRoute(
        path: AdminProvidersScreen.routeName,
        builder: (context, state) => AdminProvidersScreen(

        ),
      ),
      GoRoute(
        path: AdminProviderHandlerScreen.routeName,
        builder: (context, state) => AdminProviderHandlerScreen(
          provider: state.extra as CMIProvider,
        ),
      ),
      GoRoute(
        path: '${NewEventFormScreen.routeName}/:providerId',
        builder: (context, state) => NewEventFormScreen(
          providerId: state.params['providerId']!,
        ),
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
        path: '/provider/:activityId',
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
        path: ResetPasswordScreen.routeName,
        builder: (context, state) {
          final url = state.queryParams['u'];
          final oobCode = state.queryParams['oobCode'];
          final name = state.queryParams['n'];
          if (oobCode == null) {
            return ErrorScreen();
          }
          return ResetPasswordScreen(
            oobCode: oobCode,
            fullName: name ?? 'name',
          );
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
      */ /*GoRoute(
        path: '/page2',
        builder: (context, state) => const Page2Screen(),
      ),*/ /*
    ], // redirect to the login page if the user is not logged in
    redirect: (state) {
      print(state.location);
      print(state.subloc);
      final isEventRoute = state.subloc.startsWith('/event');

      if (isEventRoute) {
        print('is event route');
        return state.subloc.replaceFirst('/event', '/provider');
        return '/activities/${state.params['id']!}';
      }

      // no need to redirect at all
      return null;
    },
    errorBuilder: (context, state) => ErrorScreen(
      exception: state.error,
    ),
  );
  return router;
});*/

class MyApp extends ConsumerWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return OKToast(
      child: MaterialApp.router(
        theme: FlexThemeData.light(
          scheme: FlexScheme.deepBlue,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 20,
          appBarOpacity: 0.95,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            blendOnColors: false,
          ),
          useMaterial3ErrorColors: true,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          // To use the playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          colors: FlexColor.schemes[FlexScheme.deepBlue]!.light.defaultError
              .toDark(10, true),
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 15,
          appBarStyle: FlexAppBarStyle.background,
          appBarOpacity: 0.90,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 30,
          ),
          useMaterial3ErrorColors: true,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          // To use the playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(alwaysUse24HourFormat: true, textScaleFactor: 1),
            child: child!),
        themeMode: ThemeMode.system,
        routeInformationProvider: router.routeInformationProvider,
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
