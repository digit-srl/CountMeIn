import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/mu_styles.dart';
import '../../../common/ui/widgets/cmi_container.dart';
import '../../application/providers_stream.dart';
import '../screens/admin_providers.dart';

class ActiveProviders extends ConsumerWidget {
  const ActiveProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(activeProvidersStreamProvider);
    final data = state.asData?.value;
    return CMICard(
      onTap: data != null && data.isNotEmpty
          ? () {
              context.push(AdminProvidersScreen.routeName, extra: data);
            }
          : null,
      child: data == null
          ? const CircularProgressIndicator()
          : Text(
              '${data.length} Providers',
              style: Theme.of(context).textTheme.subtitle1,
            ),
    );
  }
}
