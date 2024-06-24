import 'package:countmein/src/admin/ui/screens/new_totem.dart';
import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/ui/totem_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderTotemsWidget extends ConsumerWidget {
  final String providerId;

  const ProviderTotemsWidget({required this.providerId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems = ref
            .watch(getFreeTotemsProvider(providerId,))
            .valueOrNull ??
        [];

    return GenericGridViewBuilder(
      itemCount: totems.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return CMICard(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => NewTotemDialog(providerId: providerId),);
              // final path =
              //     '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/$providerId/${NewTotemScreen.routeName}';
              // context.go(path);
            },
            child: const Column(
              children: [
                Icon(
                  Icons.add,
                  size: 50,
                ),
                Text('Nuovo Totem'),
              ],
            ),
          );
        }
        final totem = totems[index - 1];
        return TotemCardWidget(providerId: providerId, totem: totem,deleteEnabled: true,);
       /* return CMICard(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => NewTotemScreen(
                      providerId: providerId,
                      totemId: totem.id,
                    ));
            // final path =
            //     '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/$providerId/${NewTotemScreen.routeName}?totemId=${totem.id}';
            // context.go(path);
          },
          leading: totem.eventId != null ? const CMIChip(text: 'Attivo') : null,
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                ],
              ),
              Text(totem.name),
              Text('${totem.count}/${totem.totalCount}'),
              if (totem.isStatic)
                const CMIChip(
                  text: 'STATICO',
                  color: Colors.purple,
                ),
            ],
          ),
        );*/
      },
    );
  }
}
