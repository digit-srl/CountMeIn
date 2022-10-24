import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/screens/new_event.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../cloud.dart';
import '../../../../ui/screens/event_details.dart';
import '../../../../utils.dart';
import '../widgets/generic_grid_view.dart';
import '../widgets/info_text.dart';
import 'managers.dart';

class AdminProviderHandlerScreen extends ConsumerWidget {
  static const String routeName = '/adminProviderHandler';

  final String providerId;
  final CMIProvider? extraProvider;

  const AdminProviderHandlerScreen({
    Key? key,
    this.extraProvider,
    required this.providerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CMIProvider? provider;
    if (extraProvider != null) {
      provider = extraProvider!;
    } else {
      provider = ref.watch(singleCMIProviderProvider(providerId));
    }
    final platformUserRole = ref.watch(authUserRoleProvider);
    final userRole = ref.watch(userRoleProvider(providerId));
    logger.i('platformUserRole: $platformUserRole');
    logger.i('userRole: $userRole');

    final eventsState = ref.watch(eventsStreamProvider(providerId));
    return Scaffold(
      appBar: AdminAppBar(
        title: provider?.name ?? 'Caricamento...',
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
                  value: provider?.name,
                ),
                InfoText(
                  label: 'Amministratore',
                  value: provider?.adminFullName,
                ),
                InfoText(
                  label: 'Email Amministratore',
                  value: provider?.adminEmail,
                  copyable: true,
                ),
                InfoText(
                  label: 'Restrizione email',
                  value: provider?.domainRequirement,
                ),
                InfoText(
                  label: 'WOM Api Key',
                  value: provider?.apiKey,
                ),
                InfoText(
                  label: 'Aims',
                  value: provider?.aims?.join('-'),
                ),
                InfoText(
                  label: 'Tesserino',
                  value: "https://cmi.digit.srl/provider/$providerId",
                  copyable: true,
                ),
                InfoText2(
                    label: 'Managers',
                    labelWidget: IconButton(
                      icon: Icon((provider?.managers?.isEmpty ?? true)
                          ? Icons.add
                          : Icons.edit),
                      onPressed: provider?.managers != null
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
                        if (provider?.managers != null)
                          ...provider!.managers!.values
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
                if (provider?.status == CMIProviderStatus.pending &&
                    platformUserRole == PlatformRole.cmi)
                  ElevatedButton(
                    onPressed: () async {
                      await Cloud.providerRequests
                          .doc(providerId)
                          .update({'status': 'live'});
                    },
                    child: const Text('Accetta richiesta'),
                  ),
              ],
            ),
          ),
           const SizedBox(height: 16),
          if (provider?.status == CMIProviderStatus.live &&
              eventsState is AsyncData<List<CMIEvent>>)
            GenericGridView(
              itemCount: eventsState.asData!.value.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return CMICard(
                    center: true,
                    onTap: platformUserRole == PlatformRole.cmi ||
                            userRole == UserRole.admin
                        ? () {
                            if (provider == null) return;
                            context.push(
                              '${NewEventFormScreen.routeName}/${provider.id}',
                            );
                          }
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 50,
                        ),
                        Text(
                          'Crea nuovo evento',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  );
                }
                final p = eventsState.asData!.value[index - 1];
                return CMICard(
                  center: true,
                  onTap: () {
                    context.pushNamed(
                      EventDetailsScreen.routeName,
                      params: {'eventId': p.id, 'providerId': providerId},
                    );
                  },
                  child: Text(
                    p.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
