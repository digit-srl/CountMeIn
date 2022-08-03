import 'package:countmein/domain/entities/cmi_provider_request.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../ui/screens/error.dart';
import '../../../../ui/widgets/loading.dart';
import '../../../common/mu_styles.dart';
import '../../../../domain/entities/cmi_provider.dart';
import '../../application/providers_stream.dart';
import '../widgets/grid_providers.dart';
import 'admin_dashboard.dart';

class AdminProvidersScreen extends ConsumerWidget {
  static const String routeName = '/adminProviders';

  const AdminProvidersScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(activeProvidersStreamProvider);
    return Scaffold(
      appBar: const AdminAppBar(title: 'Providers',),
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
