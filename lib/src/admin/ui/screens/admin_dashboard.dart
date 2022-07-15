import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/application/auth_notifier.dart';
import '../widgets/active_providers.dart';
import '../widgets/pending_providers.dart';

class AdminDashboardScreen extends ConsumerWidget {
  static const String routeName = '/adminDashboard';

  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async{
                await ref.read(signInNotifierProvider.notifier).signOut();
                // context.push();
              },
              child: Text('Logout'))
        ],
      ),
      backgroundColor: Colors.black,
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 4,
        childAspectRatio: 4 / 3,
        children: const [
          ActiveProviders(),
          PendingProviders(),
        ],
      ),
    );
  }
}
