import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/confirm_invite_state.dart';
import 'package:countmein/src/admin/ui/screens/event_users.dart';
import 'package:countmein/src/admin/ui/screens/managers.dart';
import 'package:countmein/src/admin/ui/screens/new_event.dart';
import 'package:countmein/src/admin/ui/screens/qrcode_validation.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/auth/application/reset_password_notifier.dart';
import 'package:countmein/src/auth/ui/screens/invite_form_confirm.dart';
import 'package:countmein/src/totem/ui/embedded_screen.dart';
import 'package:countmein/src/user/ui/screens/recover_user_card.dart';
import 'package:countmein/src/user/ui/screens/user_dashboard.dart';
import 'package:countmein/ui/screens/event_details.dart';
import 'package:countmein/ui/screens/user_register_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/src/admin/ui/screens/admin_pending_providers.dart';
import 'package:countmein/src/admin/ui/screens/admin_provider_handler.dart';
import 'package:countmein/src/auth/ui/screens/auht_gate.dart';
import 'package:countmein/src/auth/ui/screens/reset_password.dart';
import 'package:countmein/ui/screens/email_verification.dart';
import 'package:countmein/ui/screens/request_activity.dart';
import 'package:flutter/material.dart';

import 'src/admin/ui/screens/admin_dashboard.dart';
import 'src/admin/ui/screens/admin_providers.dart';
import 'src/auth/domain/entities/user.dart';
import 'src/auth/ui/screens/sign_in.dart';
import 'ui/screens/admin_user_details.dart';
import 'ui/screens/error.dart';
import 'ui/screens/user_event.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    // For demo purposes
    refreshListenable: router,
    // This notifiies `GoRouter` for refresh events
    initialLocation: kIsWeb ? AuthGate.routeName : AdminDashboardScreen.path,
    routes: router._routes,
    // redirect to the login page if the user is not logged in
    redirect: router._redirectLogic,
    errorBuilder: (context, state) => ErrorScreen(
      exception: state.error,
    ),
  );
});

/// My favorite approach: ofc there's room for improvement, but it works fine.
/// What I like about this is that `RouterNotifier` centralizes all the logic.
/// The reason we use `ChangeNotifier` is because it's a `Listenable` object,
/// as required by `GoRouter`'s `refreshListenable` parameter.
/// Unluckily, it is not possible to use a `StateNotifier` here, since it's
/// not a `Listenable`. Recall that `StateNotifier` is to be preferred over
/// `ChangeNotifier`, see https://riverpod.dev/docs/concepts/providers/#different-types-of-providers
/// There are other approaches to solve this, and they can
/// be found in the `/others` folder.
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<AuthState?>(
      authStateProvider,
      (_, currentState) {
        debugPrint('router listing auth state');
        debugPrint(currentState.toString());
        // if (currentState is Authenticated) {
        notifyListeners();
        // }
      },
    );
  }

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? _redirectLogic(BuildContext context, GoRouterState state) {
    // logger.i('Name: ${state.name}');
    // logger.i('Path: ${state.path}');
    // logger.i('FullPath: ${state.fullpath}');
    // logger.i('Location: ${state.location}');
    // logger.i('Subloc: ${state.subloc}');
    // logger.i('Params: ${state.params}');
    // logger.i('Query: ${state.queryParams}');

    final authState = _ref.read(authStateProvider);

    final isGoingToAdmin = state.matchedLocation.startsWith('/admin');
    final isGoingSignIn = state.matchedLocation.startsWith('/signIn');
    // final isGoingToHome = state.subloc == '/';
    // final isGoingToVerificationEmail =
    //     state.subloc.startsWith(EmailVerificationScreen.routeName);
    // final isGoingConfirmInvite =
    //     state.subloc == InviteFormConfirmScreen.routeName;
    // final isGoingToUserCardForm = state.subloc.startsWith('/provider');
    // final isGoingToUserProfile =
    //     state.subloc.startsWith(UserConsoleScreen.routeName);
    // final isGoingToResetPassword =
    //     state.subloc == ResetPasswordScreen.routeName;
    // final isGoingToActivityRequest =
    //     state.subloc == ActivityRequestScreen.routeName;
    // final isGoingToRecoverUserCard = state.subloc

    if (!isGoingToAdmin && !isGoingSignIn) {
      debugPrint('Skip redirect');
      return null;
    }

    // if (isGoingToHome ||
    //     isGoingToVerificationEmail ||
    //     isGoingToActivityRequest ||
    //     isGoingConfirmInvite ||
    //     isGoingToResetPassword ||
    //     isGoingToUserProfile ||
    //     isGoingToUserCardForm) {
    //   return null;
    // }

    // From here we can use the state and implement our custom logic
    // final isGoingToDashboard = state.subloc == AdminDashboardScreen.routeName;
    final isGoingToSignIn = state.matchedLocation == SignInScreen.routeName;

    final fromp = state.matchedLocation == '/' ? '' : '?from=${state.location}';

    if (authState is Unauthenticated) {
      return isGoingToSignIn ? null : '${SignInScreen.routeName}$fromp';
    }
    // We are authenticated

    // if the user is logged in, send them where they were going before (or
    // home if they weren't going anywhere)
    if (isGoingToSignIn) return state.queryParameters['from'] ?? '/';

    if (authState is Authenticated) {
      final isScanner = authState.user.role == UserRole.scanner;
      logger.i('user authenticated is scanner? $isScanner');
    }

    // There's no need for a redirect at this point.
    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: AuthGate.routeName,
          builder: (context, state) => const AuthGate(),
        ),
        GoRoute(
            name: AdminDashboardScreen.routeName,
            path: AdminDashboardScreen.path,
            builder: (context, state) => const AdminDashboardScreen(),
            routes: [
              GoRoute(
                path: AdminProvidersScreen.routeName,
                builder: (context, state) => const AdminProvidersScreen(),
                routes: [
                  GoRoute(
                    // name: AdminProviderHandlerScreen.routeName,
                    path: '${AdminProviderHandlerScreen.routeName}/:providerId',
                    builder: (context, state) {
                      return AdminProviderHandlerScreen(
                        providerId:
                            state.pathParameters['providerId'] as String,
                        extraProvider: state.extra as CMIProvider?,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: NewEventFormScreen.routeName,
                        builder: (context, state) {
                          return NewEventFormScreen(
                            providerId: state.pathParameters['providerId']!,
                          );
                        },
                      ),
                      GoRoute(
                        path: ManagersHandlerScreen.routeName,
                        builder: (context, state) => ManagersHandlerScreen(
                          providerId:
                              state.pathParameters['providerId'] as String,
                        ),
                      ),
                      GoRoute(
                          name: EventDetailsScreen.routeName,
                          path: '${EventDetailsScreen.routeName}/:eventId',
                          builder: (context, state) {
                            final eventId =
                                state.pathParameters['eventId'] as String;
                            final providerId =
                                state.pathParameters['providerId'] as String;
                            return EventDetailsScreen(
                              eventId: eventId,
                              providerId: providerId,
                            );
                          },
                          routes: [
                            GoRoute(
                              name: EventUsersScreen.routeName,
                              path: EventUsersScreen.routeName,
                              builder: (context, state) {
                                final eventId =
                                    state.pathParameters['eventId'] as String;
                                final providerId = state
                                    .pathParameters['providerId'] as String;
                                final subEventId = state.queryParameters['s'];
                                return EventUsersScreen(
                                  eventId: eventId,
                                  providerId: providerId,
                                  subEventId: subEventId,
                                );
                              },
                            ),
                          ]),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: AdminPendingProvidersScreen.routeName,
                builder: (context, state) =>
                    const AdminPendingProvidersScreen(),
              ),
              GoRoute(
                path: QrCodeValidationScreen.routeName,
                builder: (context, state) => const QrCodeValidationScreen(),
              ),
            ]),
        GoRoute(
          path: SignInScreen.routeName,
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: InviteFormConfirmScreen.routeName,
          builder: (context, state) {
            final providerId = state.queryParameters['p'] as String;
            final inviteId = state.queryParameters['i'] as String;
            final secret = state.queryParameters['s'] as String;
            final providerName = state.queryParameters['n'] as String?;
            final userId = state.queryParameters['u'] as String?;
            return InviteFormConfirmScreen(
              request: InviteRequest(
                providerId: providerId,
                inviteId: inviteId,
                secret: secret,
                userId: userId,
                providerName: providerName ?? 'Provider',
              ),
            );
          },
        ),
        GoRoute(
          path: ActivityRequestScreen.routeName,
          builder: (context, state) => const ActivityRequestScreen(),
        ),
        GoRoute(
          path: '${UserConsoleScreen.routeName}/:providerId/:userId',
          builder: (context, state) => UserConsoleScreen(
            userIds: UserIds(
              userId: state.pathParameters['userId']!,
              providerId: state.pathParameters['providerId']!,
            ),
          ),
        ),
        GoRoute(
          path: '${UserProviderScreen.routeName}/:providerId',
          builder: (context, state) {
            return UserProviderScreen(
              providerId: state.pathParameters['providerId']!,
            );
          },
          routes: [
            GoRoute(
              path: UserFormScreen.routeName,
              builder: (context, state) {
                return UserFormScreen(
                  providerId: state.pathParameters['providerId']!,
                );
              },
            ),
            GoRoute(
              path: RecoverUserCard.routeName,
              builder: (context, state) {
                return RecoverUserCard(
                  providerId: state.pathParameters['providerId']!,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: UserDetailsScreen.routeName,
          builder: (context, state) {
            return UserDetailsScreen(user: state.extra! as EventUser);
          },
        ),
        GoRoute(
          path: ResetPasswordScreen.routeName,
          builder: (context, state) {
            //final url = state.queryParameters['u'];
            final userId = state.queryParameters['uid'];
            final oobCode = state.queryParameters['oobCode'];
            final name = state.queryParameters['n'];
            if (oobCode == null || userId == null) {
              return const ErrorScreen();
            }
            return ResetPasswordScreen(
              resetPasswordRequest: ResetPasswordRequest(
                oobCode: oobCode,
                fullName: name ?? 'Nome',
                userId: userId,
              ),
            );
          },
        ),
        GoRoute(
          name: EmailVerificationScreen.routeName,
          path:
              '${EmailVerificationScreen.routeName}/:userId/:secret/:providerId',
          builder: (context, state) {
            return EmailVerificationScreen(
              userId: state.pathParameters['userId'] as String,
              secret: state.pathParameters['secret'] as String,
              providerId: state.pathParameters['providerId'] as String,
              // privateId: state.params['privateId'] as String,
            );
          },
        ),
        GoRoute(
          path: '/embedded/:providerId/:eventId/:sessionId/:totemId',
          builder: (context, state) {
            return EmbeddedScreen(
              totemId: state.pathParameters['totemId'] as String,
              eventId: state.pathParameters['eventId'] as String,
              sessionId: state.pathParameters['sessionId'] as String,
              providerId: state.pathParameters['providerId'] as String,
              // privateId: state.params['privateId'] as String,
            );
          },
        ),
        /*GoRoute(
        path: '/page2',
        builder: (context, state) => const Page2Screen(),
      ),*/
      ];
}
