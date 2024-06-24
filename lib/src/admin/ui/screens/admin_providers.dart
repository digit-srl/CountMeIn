import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countmein/ui/screens/error.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/ui/widgets/grid_providers.dart';

class AdminProvidersScreen extends ConsumerWidget {
  static const String routeName = 'providers';

  const AdminProvidersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(activeProvidersStreamProvider);
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Providers',
      ),
      body: state.when(
        data: (providers) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridProvidersWidget(providers: providers),
        ),
        error: (err, st) => ErrorScreen(
          exception: err,
        ),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}
