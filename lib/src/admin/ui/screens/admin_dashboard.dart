import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await ref.read(signInNotifierProvider.notifier).signOut();
                // context.push();
              },
              child: Text('Logout'))
        ],
      ),
      // backgroundColor: Colors.black,
      body: isEmailNotVerified
          ? const EmailNotVerifiedScreen()
          : ListView(
              children: [
                const AdminInfoWidget(),
                if (platformUserRole != UserRole.unknown)
                  GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    crossAxisCount: 4,
                    childAspectRatio: 4 / 3,
                    children: [
                      const ActiveProviders(),
                      if (platformUserRole == PlatformRole.cmi)
                        const PendingProviders(),
                    ],
                  ),
              ],
            ),
    );
  }
}
