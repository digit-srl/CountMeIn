import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/ui/screens/admin_pending_providers.dart';

class PendingProviders extends ConsumerWidget {
  const PendingProviders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pendingProvidersStreamProvider);
    final data = state.asData?.value;
    return CMICard(
        onTap: data != null && data.isNotEmpty
            ? () {
                context.push(AdminPendingProvidersScreen.routeName,
                    extra: data,);
                context.go('${AdminDashboardScreen.path}/${AdminPendingProvidersScreen.routeName}', extra: data);

        }
            : null,
        iconBadge: data != null && data.isNotEmpty
            ? Icons.account_balance_wallet
            : null,
        child: Center(
          child: data == null
              ? const CircularProgressIndicator()
              : Text(
                  '${data.length} Provider da validare',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
        ),);
  }
}
