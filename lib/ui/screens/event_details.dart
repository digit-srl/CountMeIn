import 'package:countmein/cloud.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/application/scan_notifier.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/admin/ui/screens/admin_provider_handler.dart';
import 'package:countmein/src/admin/ui/screens/admin_providers.dart';
import 'package:countmein/src/admin/ui/screens/event_users.dart';
import 'package:countmein/src/admin/ui/widgets/add_scanner.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/cmi_chip.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:countmein/ui/screens/scan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../src/admin/ui/widgets/generic_grid_view.dart';
import 'package:intl/intl.dart';

enum SessionAction { close, open, delete }

extension DateTimeX on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }
}

class EventDetailsScreen extends ConsumerStatefulWidget {
  static const String routeName = 'event';

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
                    child: const Text('CheckIn'),
                  ),
                  CMICard(
                    onTap: () {
                      Navigator.of(c).pop(ScanMode.checkOut);
                    },
                    margin: const EdgeInsets.all(16),
                    child: const Text('CheckOut'),
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
    final eventData = eventState.asData?.valueOrNull;
    final provider =
        ref.watch(singleCMIProviderProvider(widget.providerId)).valueOrNull;
    final role = ref.watch(userRoleProvider(widget.providerId));
    // final isOwner = role == UserRole.admin;

    final subEvents =
        ref.watch(sessionsStreamProvider(ids)).asData?.value ?? [];
    final isUserScanner = role == UserRole.scanner;
    final isAdmin = role == UserRole.admin;
    return WillPopScope(
      onWillPop: () {
        if (isUserScanner) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(eventState.asData?.value.name ?? ''),
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                color: Colors.white,
                onPressed: () {
                  final linkEvent =
                      'http://cmi.digit.srl/admin/providers/dashboard/${widget.providerId}/event/${widget.eventId}';
                  Share.share(linkEvent);
                  // Clipboard.setData(ClipboardData(text: linkEvent));
                  // showCustomToast(
                  //   'Link evento copiato negli appunti',
                  // );
                }),
            if (kDebugMode &&
                provider != null &&
                eventData != null &&
                eventData.activeSessionId != null)
              IconButton(
                icon: const Icon(Icons.developer_mode),
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
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: eventData != null &&
                      eventData.status == EventStatus.live &&
                      provider != null &&
                      eventData.activeSessionId != null
                  ? () {
                      _goToScan(provider, eventData);
                    }
                  : null,
            ),
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
                        if (isAdmin &&
                            eventData != null &&
                            provider != null) ...[
                          ElevatedButton(
                            onPressed: () async {
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
                            child: const Text('Aggiungi scanner'),
                          ),
                          const SizedBox(width: 16),
                          //TODO solo per debug
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
                            child: const Text('Elimina'),
                          ),
                          const SizedBox(width: 16),
                          if (eventData.status == EventStatus.live)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () async {
                                final n = Navigator.of(context);
                                await Cloud.eventDoc(
                                        widget.providerId, widget.eventId)
                                    .update({'status': 'closed'});
                                n.pop();
                              },
                              child: const Text('Termina'),
                            ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            /* if (eventData != null)
              GenericGridViewBuilder(
                itemCount: eventData.isPeriodic
                    ? subEvents.length + 1
                    : eventData.isManual
                        ? subEvents.length + 2
                        : 1,
                itemBuilder: (c, index) {
                  if (eventData.isManual && index == 0) {
                    return CMICard(
                      center: true,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return Dialog(
                                child: NewSession(
                                    onSave: (name, createAndEnable) async {
                                  final subEv = CMISubEvent(
                                    id: const Uuid().v4(),
                                    name: name,
                                    startAt: DateTime.now(),
                                  );
                                  await Cloud.sessionCollection(ids)
                                      .doc(subEv.id)
                                      .set(subEv.toJson());
                                  if (createAndEnable) {
                                    Cloud.eventDoc(
                                            widget.providerId, widget.eventId)
                                        .update({
                                      'activeSessionId': subEv.id,
                                    });
                                  }
                                }),
                              );
                            });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add),
                          Text(
                            'Nuova Sessione',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    );
                  }
                  if ((eventData.isPeriodic && index == 0) ||
                      (eventData.isManual && index == 1)) {
                    return CMICard(
                      center: true,
                      onTap: () {
                        final path =
                            '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/${widget.providerId}/${EventDetailsScreen.routeName}/${widget.eventId}/${EventUsersScreen.routeName}';
                        context.go(path);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Utenti unici',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          if (eventData.totalUsers != null &&
                              eventData.totalUsers! > 0)
                            Text(
                              // subEvent.id,
                              '${eventData.totalUsers} utenti',
                              style: Theme.of(context).textTheme.caption,
                            ),
                        ],
                      ),
                    );
                  }
                  final realIndex = index -
                      (eventData.isPeriodic
                          ? 1
                          : eventData.isManual
                              ? 2
                              : 0);
                  final subEvent = subEvents[realIndex];
                  return CMICard(
                    center: true,
                    trailing: eventData.isManual
                        ? PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (SessionAction item) async {
                              switch (item) {
                                case SessionAction.close:
                                  Cloud.eventDoc(
                                          widget.providerId, widget.eventId)
                                      .update({
                                    'activeSessionId': null,
                                  });
                                  return;
                                case SessionAction.open:
                                  Cloud.eventDoc(
                                          widget.providerId, widget.eventId)
                                      .update({
                                    'activeSessionId': subEvent.id,
                                  });
                                  return;
                                case SessionAction.delete:
                                  final res = await ask(context,
                                      'Sicuro di voler eliminare la sessione ${subEvent.name}?');
                                  if (res ?? false) {
                                    await Cloud.sessionDoc(ids.copyWith(
                                            sessionId: subEvent.id))
                                        .delete();
                                    if (eventData.activeSessionId ==
                                        subEvent.id) {
                                      await Cloud.eventDoc(
                                              widget.providerId, widget.eventId)
                                          .update({'activeSessionId': null});
                                    }
                                  }
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SessionAction>>[
                              if (eventData.activeSessionId == subEvent.id)
                                const PopupMenuItem<SessionAction>(
                                  value: SessionAction.close,
                                  child: Text('Chiudi sessione'),
                                )
                              else
                                PopupMenuItem<SessionAction>(
                                  value: SessionAction.open,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: Colors.green),
                                  child: Text('Attiva sessione'),
                                ),
                              PopupMenuItem<SessionAction>(
                                value: SessionAction.delete,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: Colors.red),
                                child: Text(
                                  'Elimina sessione',
                                ),
                              ),
                            ],
                          )
                        : null,
                    leading: subEvent.id == eventData.activeSessionId
                        ? const CMIChip(
                            text: 'ATTIVO',
                          )
                        : null,
                    onTap: () {
                      final path =
                          '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/${widget.providerId}/${EventDetailsScreen.routeName}/${widget.eventId}/${EventUsersScreen.routeName}?s=${subEvent.id}';
                      context.go(path);
                      // context.pushNamed(
                      //   EventUsersScreen.routeName,
                      //   queryParams: {
                      //     'subEventId': subEvent.id,
                      //   },
                      //   params: {
                      //     'eventId': widget.eventId,
                      //     'providerId': widget.providerId,
                      //   },
                      // );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          // subEvent.id,
                          subEvent.name ?? formatter.format(subEvent.startAt),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          // subEvent.id,
                          '${subEvent.totalUsers} utenti',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        if (kDebugMode)
                          FittedBox(
                            child: Text(
                              subEvent.id,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),*/
            if (eventData != null)
              GenericGridView(
                children: [
                  if (isAdmin && eventData.isManual)
                    CMICard(
                      center: true,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return Dialog(
                                child: NewSession(
                                    onSave: (name, createAndEnable) async {
                                  final subEv = CMISubEvent(
                                    id: const Uuid().v4(),
                                    name: name,
                                    startAt: DateTime.now(),
                                  );
                                  await Cloud.sessionCollection(ids)
                                      .doc(subEv.id)
                                      .set(subEv.toJson());
                                  if (createAndEnable) {
                                    Cloud.eventDoc(
                                            widget.providerId, widget.eventId)
                                        .update({
                                      'activeSessionId': subEv.id,
                                    });
                                  }
                                }),
                              );
                            });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add),
                          Text(
                            'Nuova Sessione',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  CMICard(
                    center: true,
                    onTap: () {
                      final path =
                          '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/${widget.providerId}/${EventDetailsScreen.routeName}/${widget.eventId}/${EventUsersScreen.routeName}';
                      context.go(path);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Utenti unici',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        if (eventData.totalUsers != null &&
                            eventData.totalUsers! > 0)
                          Text(
                            '${eventData.totalUsers} utent${eventData.totalUsers! > 1 ? 'i' : 'e'}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < subEvents.length; i++)
                    SessionItem(
                      isAdmin: isAdmin,
                      session: subEvents[i],
                      ids: ids,
                      manualEvent: eventData.isManual,
                      isActive: eventData.activeSessionId == subEvents[i].id,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class SessionItem extends StatelessWidget {
  final CMISubEvent session;
  final EventIds ids;
  final bool manualEvent;
  final bool isActive;
  final bool isAdmin;

  const SessionItem(
      {Key? key,
      required this.session,
      required this.manualEvent,
      required this.isActive,
      required this.ids,
      required this.isAdmin})
      : super(key: key);
  static final formatter = DateFormat('EEEE,d MMMM, yyyy', 'it_IT');

  String get providerId => ids.providerId;

  String get eventId => ids.eventId;

  @override
  Widget build(BuildContext context) {
    return CMICard(
      center: true,
      trailing: isAdmin && manualEvent
          ? PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (SessionAction item) async {
                switch (item) {
                  case SessionAction.close:
                    Cloud.eventDoc(providerId, eventId).update({
                      'activeSessionId': null,
                    });
                    return;
                  case SessionAction.open:
                    Cloud.eventDoc(providerId, eventId).update({
                      'activeSessionId': session.id,
                    });
                    return;
                  case SessionAction.delete:
                    final res = await ask(context,
                        'Sicuro di voler eliminare la sessione ${session.name}?');
                    if (res ?? false) {
                      await Cloud.sessionDoc(
                              ids.copyWith(sessionId: session.id))
                          .delete();
                      if (isActive) {
                        await Cloud.eventDoc(providerId, eventId)
                            .update({'activeSessionId': null});
                      }
                    }
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SessionAction>>[
                if (isActive)
                  const PopupMenuItem<SessionAction>(
                    value: SessionAction.close,
                    child: Text('Chiudi sessione'),
                  )
                else
                  PopupMenuItem<SessionAction>(
                    value: SessionAction.open,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.green),
                    child: const Text('Attiva sessione'),
                  ),
                PopupMenuItem<SessionAction>(
                  value: SessionAction.delete,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.red),
                  child: const Text(
                    'Elimina sessione',
                  ),
                ),
              ],
            )
          : null,
      leading: isActive
          ? const CMIChip(
              text: 'ATTIVO',
            )
          : null,
      onTap: () {
        final path =
            '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/${providerId}/${EventDetailsScreen.routeName}/${eventId}/${EventUsersScreen.routeName}?s=${session.id}';
        context.go(path);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            // subEvent.id,
            session.name ?? formatter.format(session.startAt),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            // subEvent.id,
            '${session.totalUsers} utenti',
            style: Theme.of(context).textTheme.caption,
          ),
          if (kDebugMode)
            FittedBox(
              child: Text(
                session.id,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
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
    ref.listen(scanControllerProvider(event.id), (_, __) {});
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
            isSelected:
                ScanMode.values.map((e) => e == scanMode.value).toList(),
            onPressed: event.accessType == EventAccessType.inOut
                ? (index) {
                    scanMode.value = ScanMode.values[index];
                  }
                : null,
            children: const [
              Icon(
                Icons.arrow_downward,
                color: Colors.green,
              ),
              Icon(
                Icons.arrow_upward,
                color: Colors.red,
              )
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
// https://cmi.digit.srl/profile/27KEQsVlgbHsNONPSP5V?name=Gian Marco&surname=Di Francesco&cf=DFRGMR89M02I348U&pId=countmein
// https://cmi.digit.srl/profile/27KEQsVlgbHsNONPSP5V?name=Gian Marco&surname=Di Francesco&cf=DFRGMR89M02I348U&pId=countmein&gId=g2f90soy5Xf1tvX3xrsW&gN=GRUPPO JANMARC&gC=6&aA=12

                // https://cmi.digit.srl/profile/9km0qgaLHKpJ3HnDmw8E?upid=wPchczGr0qfv7DJ43S8w&name=Gian Marco&surname=Di Francesco&cf=DFRGMR89M02I348U&pId=Yy31B32YBDJDUt7TbZEl
                ref.read(scanControllerProvider(event.id)).processScan2(
                      dataController.text.trim(),
                      provider,
                      event,
                      scanMode.value,
                      null,
                    );
              },
              child: const Text('Try'))
        ],
      ),
    );
  }
}

class NewSession extends HookConsumerWidget {
  final Function(String, bool) onSave;

  const NewSession({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final createAndEnabled = useState<bool>(false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Nuova sessione'),
          const SizedBox(height: 16),
          CMITextField(
            controller: controller,
            labelText: 'Nome sessione',
            hintText: 'Digita il nome della sessione',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                  value: createAndEnabled.value,
                  onChanged: (value) {
                    if (value == null) return;
                    createAndEnabled.value = value;
                  }),
              const SizedBox(width: 16),
              const Text('Attiva sessione alla creazione'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                onSave(name, createAndEnabled.value);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Crea'),
          ),
        ],
      ),
    );
  }
}
