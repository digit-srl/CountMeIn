import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/ui/widgets/cmi_container.dart';
import '../../application/providers_stream.dart';
import '../screens/admin_providers.dart';

class ActiveProviders extends ConsumerWidget {
  const ActiveProviders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(activeProvidersStreamProvider);
    final data = state.asData?.value;
    return CMICard(
      onTap: data != null && data.isNotEmpty
          ? () {
              context.go("${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}", extra: data);
            }
          : null,
      child: Center(
        child: data == null
            ? const CircularProgressIndicator()
            : Text(
                '${data.length} Providers',
                style: Theme.of(context).textTheme.subtitle1,
              ),
      ),
    );
  }
}
