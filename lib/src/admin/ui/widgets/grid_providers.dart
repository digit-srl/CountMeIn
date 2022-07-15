import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/cmi_provider.dart';
import '../../../common/ui/widgets/cmi_container.dart';
import '../screens/admin_provider_handler.dart';
import '../../../common/mu_styles.dart';
class GridProvidersWidget extends StatelessWidget {

  final List<CMIProvider> providers;

  const GridProvidersWidget({Key? key, required this.providers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: providers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        final p = providers[index];
        return CMIContainer(
          onTap: () {
            context.push(AdminProviderHandlerScreen.routeName, extra: p);
          },
          child: Text(
            p.name,
            style: Theme.of(context).textTheme.subtitle1?.white,
          ),
        );
      },
    );
  }
}
