import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/constants.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/session_notifier.dart';
import 'package:countmein/src/admin/application/users_stream.dart';
import 'package:countmein/src/admin/csv_mixin.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/widgets/assign_totem_dialog.dart';
import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/admin/ui/widgets/start_end_date_form.dart';
import 'package:countmein/src/admin/ui/widgets/user_list_widget.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/totem/application/totems_notifier.dart';
import 'package:countmein/src/totem/ui/embedded_screen.dart';
import 'package:countmein/src/totem/ui/totems.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';

class SessionDetailsScreen extends HookConsumerWidget with CSVMixin {
  static const String routeName = 'session-details';
  final String providerId;
  final String eventId;
  final String sessionId;

  const SessionDetailsScreen({
    super.key,
    required this.providerId,
    required this.eventId,
    required this.sessionId,
  });

  setDateTime(BuildContext context, CMISubEvent? session) async {
    final (DateTime s, DateTime? e)? a = await showDialog(
      context: context,
      builder: (_) => SetDateTimeDialog(
        startAt: session?.startAt,
        endAt: session?.endAt,
      ),
    );

    if (a != null) {
      Cloud.sessionDoc(EventIds(
              providerId: providerId, eventId: eventId, sessionId: sessionId))
          .update({
        'startAt': Timestamp.fromDate(a.$1),
        'endAt': a.$2 != null ? Timestamp.fromDate(a.$2!) : null,
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = EventIds(
      providerId: providerId,
      eventId: eventId,
      sessionId: sessionId,
    );
    final eventState = ref.watch(eventProvider(ids));
    final session = ref.watch(getSessionProvider(ids)).valueOrNull;
    final usersState = ref.watch(eventUsersStreamProvider(ids));
    final anonymous = eventState.value?.anonymous ?? true;
    final hasData = usersState is AsyncData;
    final isLoading = useState(false);
    final genderCount = ids.sessionId == null
        ? eventState.valueOrNull?.genderCount
        : session?.genderCount;

    final editDateButton = IconButton(
      icon: const Icon(Icons.edit),
      color: Colors.white,
      onPressed: () => setDateTime(context, session),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Sessione $sessionId')),
      body: session == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CMICard(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InfoText(
                      label: 'Inizio',
                      value: dateFormat.format(session.startAt),
                      iconButton: editDateButton,
                    ),
                    InfoText(
                      label: 'Fine',
                      value: session.endAt != null
                          ? dateFormat.format(session.endAt!)
                          : 'Non impostato',
                      iconButton: editDateButton,
                    ),
                  ],
                )),
                SessionTotemsCardWidget(
                  providerId: providerId,
                  eventId: eventId,
                  sessionId: sessionId,
                ),
                UsersListWidget(
                  anonymous: anonymous,
                  genderCount: genderCount,
                  usersState: usersState,
                ),
              ],
            ),
      floatingActionButton: anonymous
          ? null
          : usersState.maybeWhen(
              data: (list) {
                if (list.isNotEmpty) {
                  return FloatingActionButton(
                    child: const Icon(Icons.import_export),
                    onPressed: () async {
                      if (hasData) {
                        isLoading.value = true;
                        try {
                          await downloadCSV(eventState.valueOrNull, list);
                        } catch (ex) {
                          isLoading.value = false;
                          showToast('Si è verificato un errore!',
                              position: ToastPosition.bottom);
                        }
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
              orElse: () => const SizedBox.shrink(),
            ),
    );
  }
}

class SessionTotemsCardWidget extends ConsumerWidget {
  final String providerId;
  final String eventId;
  final String sessionId;

  const SessionTotemsCardWidget({
    super.key,
    required this.providerId,
    required this.eventId,
    required this.sessionId,
  });

  void assignTotem(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AssignTotemDialog(
            providerId: providerId,
            eventId: eventId,
            sessionId: sessionId,
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totems = ref
            .watch(getSessionTotemsProvider(providerId, eventId, sessionId))
            .valueOrNull ??
        [];
    if (totems.isEmpty) return const SizedBox.shrink();
    return CMICard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Totem assegnati',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 16),
          GenericGridViewBuilder(
            itemCount: totems.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return CMICard(
                  onTap: () {
                    assignTotem(context);
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.add,
                        size: 50,
                      ),
                      Text('Assegna nuovo Totem'),
                    ],
                  ),
                );
              }

              final totem = totems[index - 1];
              return Card(
                color: Colors.red[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton<QrCodeAction>(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<QrCodeAction>>[
                            PopupMenuItem<QrCodeAction>(
                              enabled: false,
                              value: QrCodeAction.goToQrCode,
                              child: const Text('Vai alla pagina'),
                              onTap: () {
                                // context.go(
                                //     '/embedded/$providerId/$eventId/$sessionId/${totem.id}');
                              },
                            ),
                            PopupMenuItem<QrCodeAction>(
                              value: QrCodeAction.copyQrCodeLink,
                              enabled: false,
                              child: const Text('Copia link pagina'),
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text:
                                        'https://cmi.digit.srl//embedded/$providerId/${totem.id}'));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Link ${totem.name} copiato negli appunti')));
                              },
                            ),
                            PopupMenuItem<QrCodeAction>(
                              value: QrCodeAction.copyQrCode,
                              child: const Text('Copia QR-Code'),
                              onTap: () {
                                final qr =
                                    '$totemBaseUrl/$providerId/$eventId/${totem.id}${totem.requestId != null ? '/${totem.requestId}' : ''}';
                                Clipboard.setData(ClipboardData(
                                  text: qr,
                                ));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'QR-Code ${totem.name} copiato negli appunti')));
                              },
                            ),
                            PopupMenuItem<QrCodeAction>(
                              value: QrCodeAction.resetCounters,
                              child: const Text('Reset contatori'),
                              onTap: () {
                                Cloud.providerTotemDoc(providerId, totem.id)
                                    .update({
                                  'count': 0,
                                  'totalCount': 0,
                                });
                              },
                            ),
                            PopupMenuItem<QrCodeAction>(
                              value: QrCodeAction.removeTotem,
                              child: const Text('Libera totem'),
                              onTap: () {
                                Cloud.providerTotemDoc(providerId, totem.id)
                                    .update({
                                  'eventId': null,
                                  'sessionId': null,
                                  'count': 0,
                                  'totalCount': 0,
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(totem.name),
                    Text('${totem.count}/${totem.totalCount}'),
                    const Spacer(),
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

class SetDateTimeDialog extends HookConsumerWidget {
  final DateTime? startAt;
  final DateTime? endAt;

  const SetDateTimeDialog({super.key, this.startAt, this.endAt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final start = useState(startAt);
    final end = useState(endAt);

    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StartEndDateForm(
              startAt: startAt,
              endAt: endAt,
              onChanged: (s, e) {
                start.value = s;
                end.value = e;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop((start.value, end.value));
              },
              child: const Text('Salva'),
            ),
          ],
        ),
      ),
    );
  }
}
