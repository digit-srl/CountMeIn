import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/constants.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/admin/ui/screens/qrcode_validation.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/auth/ui/screens/reset_password.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../utils.dart';
import '../../../auth/application/auth_notifier.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/ui/screens/email_not_verified.dart';
import '../widgets/active_providers.dart';
import '../widgets/admin_info.dart';
import '../widgets/pending_providers.dart';

class AdminDashboardScreen extends HookConsumerWidget {
  static const String routeName = 'admin';
  static const String path = '/admin';

  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final platformUserRole = ref.watch(platformUserRoleProvider);
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Dashboard',
        goToHome: false,
      ),
      // backgroundColor: Colors.black,
      body: authState.when(
        authenticated: (user) {
          if (user.temporaryPassword) {
            return LoadingOverlay(
              isLoading: isLoading.value,
              child: Center(
                child: CMICard(
                  constraints:
                      const BoxConstraints(maxWidth: 500, maxHeight: 350),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Benvenuto, aggiorna la tua password.'),
                      ResetPasswordForm(
                        onSave: (newPassword) async {
                          try {
                            isLoading.value = true;
                            final token = await FirebaseAuth
                                .instance.currentUser
                                ?.getIdToken();
                            final response = await ref
                                .read(dioProvider)
                                .post(changePasswordUrl, data: {
                              'newPassword': newPassword,
                              'token': token
                            });
                            isLoading.value = false;
                            if (response.statusCode == 200) {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: user.email,
                                password: newPassword,
                              );
                            }
                          } catch (ex) {
                            logger.e(ex);
                            isLoading.value = false;
                            CoolAlert.show(
                              context: context,
                              width: 400,
                              type: CoolAlertType.error,
                              title: 'Errore',
                              text: 'Si è verificato un errore',
                            );
                          }
                        },
                        fullName: user.fullName,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const AdminInfoWidget(),
              const SizedBox(height: 16),
              LayoutBuilder(builder: (context, constraints) {
                final cr = calculateCrossAxisCount(constraints.maxWidth);
                logger.i('${constraints.maxWidth} con $cr');
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(16),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount: cr,
                  childAspectRatio: cr == 1 ? 3 : 4 / 3,
                  children: [
                    const ActiveProviders(),
                    if (platformUserRole == PlatformRole.cmi)
                      const PendingProviders(),
                    const QrCodeValidationWidget(),
                  ],
                );
              }),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        unauthenticated: () {
          return const Center(
            child: Text('Non autenticato'),
          );
        },
        // emailNotVerified: (_) => EmailNotVerifiedScreen(),
        error: (e, st) {
          return Text(e.toString());
        },
      ),
    );
  }
}

class QrCodeValidationWidget extends ConsumerWidget {
  const QrCodeValidationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CMICard(
      onTap: () {
        context.go(
            '${AdminDashboardScreen.path}/${QrCodeValidationScreen.routeName}');
      },
      child: Center(
        child: Text(
          'Valida QrCode',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
