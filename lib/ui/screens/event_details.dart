import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/screens/event_users.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:countmein/ui/screens/scan.dart';

import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../utils.dart';
import 'admin.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  static const String routeName = '/eventDetails';

  final String eventId;
  final String providerId;

  const EventDetailsScreen({
    Key? key,
    required this.eventId,
    required this.providerId,
  }) : super(key: key);

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late EventIds ids;

  @override
  void initState() {
    super.initState();
    ids = EventIds(providerId: widget.providerId, eventId: widget.eventId);
  }

  _goToScan(CMIProvider activity, CMIEvent event) async {
    final scanMode = await showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   const SizedBox(height: 8),
                  Text('Scegli il tipo di scansione',style:Theme.of(context).textTheme.headline6),
                  CMICard(
                    onTap: () {
                      Navigator.of(c).pop(ScanMode.checkIn);
                    },
                    margin: const EdgeInsets.all(16),
                    child: Text('CheckIn'),
                  ),
                  CMICard(
                    onTap: () {
                      Navigator.of(c).pop(ScanMode.checkOut);
                    },
                    margin: const EdgeInsets.all(16),
                    child: Text('CheckOut'),
                  ),
                ],
              ),
            ),
          );
        });
    if (scanMode == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ScanScreen(
          event: event,
          provider: activity,
          scanMode: scanMode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventProvider(ids));
    final eventData = eventState.asData?.value;
    final provider = ref.watch(singleCMIProviderProvider(widget.providerId));
    // final role = ref.watch(userRoleProvider(widget.providerId));
    // final isOwner = role == UserRole.admin;

    final subEvents =
        ref.watch(subEventsStreamProvider(ids)).asData?.value ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(eventState.asData?.value.name ?? ''),
        actions: [
          if (eventData != null &&
              eventData.status == EventStatus.live &&
              provider != null) ...[
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _goToScan(provider, eventData);
                }),
          ]
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CMICard(
            child: Column(
              children: [
                InfoText(
                  label: 'Nome Evento',
                  value: eventData?.name,
                ),
                InfoText(
                  label: 'ID evento',
                  value: eventData?.id,
                  copyable: true,
                ),
                InfoText(
                  label: 'WOM',
                  value: eventData?.maxWomCount.toString(),
                ),
                InfoText(
                  label: 'Tipo',
                  value: (eventData?.recurring ?? false)
                      ? 'Ricorrente (${eventData!.recurrence})'
                      : 'Singolo',
                ),
                InfoText(
                  label: 'Stato',
                  value: enumToString(eventData?.status),
                ),
                InfoText(
                  label: 'Accetta passpartout',
                  value: eventData?.acceptPassepartout.toString(),
                ),
              ],
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: childAspectRatio(constraints.maxWidth),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2,
              children: [
                CMICard(
                  onTap: () {
                    context.pushNamed(
                      EventUsersScreen.routeName,
                      params: {
                        'eventId': widget.eventId,
                        'providerId': widget.providerId
                      },
                    );
                  },
                  child: Text(
                    'Utenti unici',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                for (int i = 0; i < subEvents.length; i++)
                  CMICard(
                    onTap: () {
                      context.pushNamed(
                        EventUsersScreen.routeName,
                        params: {
                          'eventId': widget.eventId,
                          'providerId': widget.providerId,
                          'subEventId': subEvents[i].id,
                        },
                      );
                    },
                    child: Text(
                      subEvents[i].id,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
