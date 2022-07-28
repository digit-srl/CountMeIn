import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../ui/screens/event_details.dart';
import '../../../common/mu_styles.dart';
import '../../../../domain/entities/session.dart';
import '../../../common/ui/widgets/my_button.dart';
import '../widgets/info_text.dart';
import 'managers.dart';

class AdminProviderHandlerScreen extends ConsumerWidget {
  static const String routeName = '/adminProviderHandler';

  final CMIProvider provider;

  const AdminProviderHandlerScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platformUserRole = ref.watch(authUserRoleProvider);
    final eventsState = ref.watch(eventsStreamProvider(provider.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CMICard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoText(
                  label: 'Nome Provider',
                  value: provider.name,
                ),
                InfoText(
                  label: 'Amministratore',
                  value: provider.adminFullName,
                ),
                InfoText(
                  label: 'Email Amministratore',
                  value: provider.adminEmail,
                  copyable: true,
                ),
                InfoText(
                  label: 'Restrizione email',
                  value: provider.domainRequirement,
                ),
                InfoText(
                  label: 'WOM Api Key',
                  value: provider.apiKey,
                ),
                InfoText(
                  label: 'Aims',
                  value: provider.aims?.join('-'),
                ),
                InfoText2(
                    label: 'Managers',
                    labelWidget: IconButton(
                      icon: Icon((provider.managers?.isEmpty ?? true)
                          ? Icons.add
                          : Icons.edit),
                      onPressed: provider.managers != null
                          ? () {
                              context.push(ManagersHandlerScreen.routeName,
                                  extra: provider);
                              /* showDialog(
                                    context: context,
                                    builder: (c) {
                                      return Dialog(
                                        child: ManagersHandlerDialog(
                                            provider: provider),
                                      );
                                    },
                                  );*/
                            }
                          : null,
                    ),
                    value: Wrap(
                      children: [
                        if (provider.managers != null)
                          ...provider.managers!.values
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Tooltip(
                                    message: e.email,
                                    child: Chip(
                                      label: Text(
                                        e.name,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      ],
                    )),
                if (provider.status == CMIProviderStatus.pending &&
                    platformUserRole == PlatformRole.cmi)
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Accetta richiesta'),
                  ),
              ],
            ),
          ),
          if (eventsState is AsyncData<List<Event>>)
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: eventsState.asData!.value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                final p = eventsState.asData!.value[index];
                return CMICard(
                  onTap: () {
                    context.push(
                      EventDetailsScreen.routeName,
                      extra: [p, provider.id],
                    );
                  },
                  child: Text(
                    p.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
