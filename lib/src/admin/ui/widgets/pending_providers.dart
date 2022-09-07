import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/mu_styles.dart';
import '../../../common/ui/widgets/cmi_container.dart';
import '../../application/providers_stream.dart';
import '../screens/admin_pending_providers.dart';

class PendingProviders extends ConsumerWidget {
  const PendingProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pendingProvidersStreamProvider);
    final data = state.asData?.value;
    return CMICard(
        onTap: data != null && data.isNotEmpty
            ? () {
                context.push(AdminPendingProvidersScreen.routeName,
                    extra: data);
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
                  style: Theme.of(context).textTheme.subtitle1,
                ),
        ));
  }
}
