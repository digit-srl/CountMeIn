import 'package:countmein/cloud.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/application/scan_notifier.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/screens/event_users.dart';
import 'package:countmein/src/admin/ui/widgets/add_scanner.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:countmein/ui/screens/scan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../src/admin/ui/widgets/generic_grid_view.dart';
import '../../utils.dart';
import 'admin.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }
}

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

  static final formatter = DateFormat('EEEE,d MMMM, yyyy', 'it_IT');

  @override
  void initState() {
    super.initState();
    ids = EventIds(providerId: widget.providerId, eventId: widget.eventId);
  }

  _goToScan(CMIProvider activity, CMIEvent event) async {
    // TODO se single non chiedere
    var scanMode = ScanMode.checkOut;
    if (event.accessType == EventAccessType.inOut) {
      final sMode = await showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text('Scegli il tipo di scansione',
                      style: Theme.of(context).textTheme.headline6),
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
        },
      );
      if (sMode == null) return;
      scanMode = sMode;
    }

    if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventProvider(ids));
    final eventData = eventState.asData?.value;
    final provider = ref.watch(singleCMIProviderProvider(widget.providerId)).valueOrNull;
    // final role = ref.watch(userRoleProvider(widget.providerId));
    // final isOwner = role == UserRole.admin;

    final subEvents =
        ref.watch(subEventsStreamProvider(ids)).asData?.value ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(eventState.asData?.value.name ?? ''),
        actions: [
          if (kDebugMode && provider != null && eventData != null)
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (c) {
                    return Dialog(
                      child: ScanSimulationWidget(
                        event: eventData,
                        provider: provider,
                      ),
                    );
                  },
                );
              },
            ),
          if (eventData != null &&
              eventData.status == EventStatus.live &&
              provider != null) ...[
            IconButton(
                icon: const Icon(Icons.qr_code_scanner),
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
            collapsedWidget: InfoText(
              label: 'Nome Evento',
              value: eventData?.name,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Row(
                  children: [
                    Flexible(
                      child: InfoText(
                          label: 'Anonimo',
                          value: eventData?.anonymous.toString()),
                    ),
                    Flexible(
                      child: InfoText(
                        label: 'Accetta passpartout',
                        value: eventData?.acceptPassepartout.toString(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: InfoText(
                        label: 'Ricorrenza',
                        value: (eventData?.recurring ?? false)
                            ? 'Giornaliera x${eventData!.recurrence})'
                            : 'Singola',
                      ),
                    ),
                    Flexible(
                      child: InfoText(
                        label: 'Accesso',
                        value: eventData?.accessType.text,
                      ),
                    ),
                  ],
                ),
                InfoText(
                  label: 'Stato',
                  value: eventData?.status?.text,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        // style:
                        // ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () async {
                          if (provider == null || eventData == null) return;
                          showDialog(
                            context: context,
                            builder: (c) => Dialog(
                              child: AddScannerWidget(
                                provider: provider,
                                event: eventData,
                              ),
                            ),
                          );
                        },
                        child: Text('Aggiungi scanner'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          final n = Navigator.of(context);
                          await Cloud.eventDoc(
                                  widget.providerId, widget.eventId)
                              .delete();
                          n.pop();
                        },
                        child: Text('Elimina'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GenericGridView(
            itemCount: subEvents.length + 1,
            itemBuilder: (c, index) {
              if (index == 0) {
                return CMICard(
                  center: true,
                  onTap: () {
                    context.pushNamed(
                      EventUsersScreen.routeName,
                      params: {
                        'eventId': widget.eventId,
                        'providerId': widget.providerId,
                      },
                    );
                  },
                  child: Text(
                    'Utenti unici',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              }
              final subEvent = subEvents[index - 1];
              return CMICard(
                center: true,
                flag: subEvent.startAt.isToday
                    ? Chip(
                        backgroundColor: Colors.green,
                        label: Text('ATTIVO'),
                      )
                    : null,
                onTap: () {
                  context.pushNamed(
                    EventUsersScreen.routeName,
                    queryParams: {
                      'subEventId': subEvent.id,
                    },
                    params: {
                      'eventId': widget.eventId,
                      'providerId': widget.providerId,
                    },
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      // subEvent.id,
                      formatter.format(subEvent.startAt),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      // subEvent.id,
                      '${subEvent.totalUsers} utenti',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              );
            },
          ),
          /*LayoutBuilder(builder: (context, constraints) {
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: calculateCrossAxisCount(constraints.maxWidth),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2,
              children: [

                for (int i = 0; i < subEvents.length; i++)

              ],
            );
          }),*/
        ],
      ),
    );
  }
}

class ScanSimulationWidget extends HookConsumerWidget {
  final CMIEvent event;
  final CMIProvider provider;

  const ScanSimulationWidget({
    Key? key,
    required this.event,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataController = useTextEditingController();
    final scanMode = useState(ScanMode.checkOut);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Prova la scansione',
              style: Theme.of(context).textTheme.headline6),
          CMITextField(
            controller: dataController,
            hintText: 'Qr Code data',
          ),
          const SizedBox(height: 8),
          Text('Scegli il tipo di scansione',
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16),
          ToggleButtons(
            children: [
              Icon(
                Icons.arrow_downward,
                color: Colors.green,
              ),
              Icon(
                Icons.arrow_upward,
                color: Colors.red,
              )
            ],
            isSelected:
                ScanMode.values.map((e) => e == scanMode.value).toList(),
            onPressed: event.accessType == EventAccessType.inOut
                ? (index) {
                    scanMode.value = ScanMode.values[index];
                  }
                : null,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
// https://cmi.digit.srl/profile/27KEQsVlgbHsNONPSP5V?name=Gian Marco&surname=Di Francesco&cf=DFRGMR89M02I348U&pId=countmein&gId=g2f90soy5Xf1tvX3xrsW&gN=GRUPPO JANMARC&gC=6&aA=12
                ref.read(scanControllerProvider(event.id)).processScan(
                      dataController.text.trim(),
                      provider,
                      event,
                      scanMode.value,
                      null,
                    );
              },
              child: Text('Try'))
        ],
      ),
    );
  }
}
