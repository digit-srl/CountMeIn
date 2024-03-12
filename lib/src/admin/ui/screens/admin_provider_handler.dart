import 'package:auto_size_text/auto_size_text.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/screens/admin_archived_events.dart';
import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/admin/ui/screens/admin_providers.dart';
import 'package:countmein/src/admin/ui/screens/new_event.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/admin/ui/widgets/provider_totems.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/cmi_chip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../cloud.dart';
import 'event_details.dart';
import '../widgets/generic_grid_view.dart';
import '../widgets/info_text.dart';
import 'managers.dart';

class AdminProviderHandlerScreen extends ConsumerWidget {
  static const String routeName = 'dashboard';

  final String providerId;
  final CMIProvider? extraProvider;

  const AdminProviderHandlerScreen({
    super.key,
    this.extraProvider,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CMIProvider? provider;
    if (extraProvider != null) {
      provider = extraProvider!;
    } else {
      provider = ref.watch(singleCMIProviderProvider(providerId)).valueOrNull;
    }
    final platformUserRole = ref.watch(platformUserRoleProvider);
    final userRole = ref.watch(userRoleProvider(providerId));
    logger.i('provider status: ${provider?.status}');
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
            collapsedWidget: InfoText(
              label: 'Nome Provider',
              value: provider?.name,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Row(
                  children: [
                    Flexible(
                      child: InfoText(
                        label: 'Aims',
                        value: provider?.aims?.join('-'),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Flexible(
                      child: InfoText(
                        label: 'AIM',
                        value: provider?.aim,
                      ),
                    ),
                  ],
                ),
                InfoText(
                  label: 'Tesserino',
                  value: "https://cmi.digit.srl/provider/$providerId",
                  copyable: true,
                ),
                InfoText(
                  label: 'IL tuo ruolo',
                  value: userRole.text,
                ),
                InfoText2(
                    label: 'Managers',
                    labelWidget: IconButton(
                      icon: Icon((provider?.managers.isEmpty ?? true)
                          ? Icons.add
                          : Icons.edit),
                      onPressed: provider?.managers != null &&
                              userRole == UserRole.admin
                          ? () {
                              final path =
                                  '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/${provider!.id}/${ManagersHandlerScreen.routeName}';
                              context.go(path, extra: provider);
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
                      runSpacing: 4,
                      children: [
                        if (provider?.managers != null)
                          ...provider!.managers.values.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Tooltip(
                                message: e.email,
                                child: Chip(
                                  label: Text(
                                    e.name,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
          const Text('Totems'),
          ProviderTotemsWidget(
            providerId: providerId,
          ),
          const SizedBox(height: 16),
          const Text('Eventi'),
          CMICard(
            child: Consumer(builder: (context, ref, child) {
              final eventFilter = ref.watch(eventFilterNotifierProvider);
              return Row(
                children: [
                  const Text('Sort by'),
                  ...EventFilter.values.map(
                    (e) => RadioMenuButton<EventFilter>(
                      value: e,
                      groupValue: eventFilter,
                      onChanged: ref
                          .read(eventFilterNotifierProvider.notifier)
                          .onChanged,
                      child: Text(e.name),
                    ),
                  ),
                  const Spacer(),
                  Tooltip(
                    message: 'Archiviati',
                    child: IconButton(
                        icon: const Icon(Icons.archive),
                        color: Colors.white,
                        onPressed: () {
                          final path =
                              '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/${provider!.id}/${ArchivedEventsScreen.routeName}';
                          context.go(path, extra: provider);
                        }),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),
          if (provider?.status == CMIProviderStatus.live &&
              eventsState is AsyncData<List<CMIEvent>>)
            GenericGridViewBuilder(
              itemCount: eventsState.asData!.value.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return CMICard(
                    center: true,
                    onTap: platformUserRole == PlatformRole.cmi ||
                            userRole == UserRole.admin
                        ? () {
                            if (provider == null) return;
                            final path =
                                '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/$providerId/${NewEventFormScreen.routeName}';
                            context.go(path, extra: provider);
                          }
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 50,
                        ),
                        Text(
                          'Crea nuovo evento',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        if (userRole == UserRole.scanner ||
                            userRole == UserRole.eventManager)
                          Text(
                            'Sei ${userRole.text.toUpperCase()} quindi non puoi creare un nuovo evento',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          )
                      ],
                    ),
                  );
                }
                final event = eventsState.asData!.value[index - 1];
                return CMICard(
                  center: true,
                  leading: event.isActive
                      ? const CMIChip(text: 'ATTIVO')
                      : event.isClosed
                          ? const CMIChip(
                              text: 'Terminato',
                              color: Colors.red,
                            )
                          : null,
                  onTap: () {
                    final path =
                        '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/$providerId/${EventDetailsScreen.routeName}/${event.id}';

                    context.go(path);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      if (kDebugMode)
                        FittedBox(
                          child: Text(
                            event.id,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
