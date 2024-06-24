import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:countmein/src/auth/application/auth_notifier.dart';

class AdminAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final bool goToHome;

  const AdminAppBar({required this.title, super.key, this.goToHome = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      actions: [
        // if (kIsWeb && goToHome)
        IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              context.go(AdminDashboardScreen.path);
            },),
        TextButton(
          onPressed: () async {
            await ref.read(signInNotifierProvider.notifier).signOut();
            // context.push();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
