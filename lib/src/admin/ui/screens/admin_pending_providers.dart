import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/ui/screens/error.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/ui/widgets/grid_providers.dart';

class AdminPendingProvidersScreen extends ConsumerWidget {
  static const String routeName = 'pending-providers';

  const AdminPendingProvidersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pendingProvidersStreamProvider);
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Pending providers',
      ),
      body: state.when(
        data: (providers) => GridProvidersWidget(providers: providers),
        error: (err, st) => ErrorScreen(
          exception: err,
        ),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}
