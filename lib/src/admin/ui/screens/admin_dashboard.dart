import 'package:countmein/src/admin/ui/screens/qrcode_validation.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils.dart';
import '../../../auth/application/auth_notifier.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/ui/screens/email_not_verified.dart';
import '../widgets/active_providers.dart';
import '../widgets/admin_info.dart';
import '../widgets/pending_providers.dart';

class AdminDashboardScreen extends ConsumerWidget {
  static const String routeName = '/adminDashboard';

  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platformUserRole = ref.watch(authUserRoleProvider);
    final authState = ref.watch(authStateProvider);
    final isEmailNotVerified = authState is EmailNotVerified;
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Dashboard',
        goToHome: false,
      ),
      // backgroundColor: Colors.black,
      body: isEmailNotVerified
          ? const EmailNotVerifiedScreen()
          : ListView(
              children: [
                const AdminInfoWidget(),
                if (platformUserRole != UserRole.unknown)
                  LayoutBuilder(builder: (context, constraints) {
                    return GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      crossAxisCount: childAspectRatio(constraints.maxWidth),
                      childAspectRatio: 4 / 3,
                      children: [
                        const ActiveProviders(),
                        if (platformUserRole == PlatformRole.cmi)
                          const PendingProviders(),
                        QrCodeValidationWidget(),
                      ],
                    );
                  }),
              ],
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
        context.push(QrCodeValidationString.routeName);
      }
          ,
      child: Center(
        child: Text(
          'Valida QrCode',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}