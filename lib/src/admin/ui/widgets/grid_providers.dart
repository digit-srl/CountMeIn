import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/admin/ui/screens/admin_providers.dart';
import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/cmi_provider.dart';
import '../../../common/ui/widgets/cmi_container.dart';
import '../screens/admin_provider_handler.dart';
import '../../../common/mu_styles.dart';

class GridProvidersWidget extends StatelessWidget {
  final List<CMIProvider> providers;

  const GridProvidersWidget({Key? key, required this.providers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericGridView(
      itemCount: providers.length,
      scroolEnabled: true,
      itemBuilder: (BuildContext context, int index) {
        final p = providers[index];
        return CMICard(
          center: true,
          onTap: () {
            context.go('${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/${p.id}',
                extra: p.status == CMIProviderStatus.pending ? p : null);
            // params: {'providerId': p.id});
          },
          child: Text(
            p.name,
            // style: Theme.of(context).textTheme.subtitle1,
          ),
        );
      },
    );
    // return LayoutBuilder(builder: (context, constraints) {
    //   return GridView.builder(
    //     padding: const EdgeInsets.all(16),
    //     itemCount: providers.length,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: calculateCrossAxisCount(constraints.maxWidth),
    //       mainAxisSpacing: 8,
    //       crossAxisSpacing: 8,
    //       childAspectRatio: 4 / 3,
    //     ),
    //     itemBuilder: (BuildContext context, int index) {
    //       final p = providers[index];
    //       return CMICard(
    //         center: true,
    //         onTap: () {
    //           context.push('${AdminProviderHandlerScreen.routeName}/${p.id}',
    //               extra: p.status == CMIProviderStatus.pending ? p : null);
    //           // params: {'providerId': p.id});
    //         },
    //         child: Text(
    //           p.name,
    //           // style: Theme.of(context).textTheme.subtitle1,
    //         ),
    //       );
    //     },
    //   );
    // });
  }
}
