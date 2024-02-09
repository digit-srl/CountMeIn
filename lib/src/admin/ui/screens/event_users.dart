import 'dart:convert';

import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/session_notifier.dart';
import 'package:countmein/src/admin/application/users_stream.dart';
import 'package:countmein/src/admin/csv_mixin.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/admin/ui/widgets/gender_card.dart';
import 'package:countmein/src/admin/ui/widgets/user_list_widget.dart';
import 'package:countmein/ui/screens/admin_user_details.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';
import 'package:intl/intl.dart';

class EventUsersScreen extends StatefulHookConsumerWidget {
  static const String routeName = 'eventUsers';

  final String eventId;
  final String providerId;
  final String? sessionId;

  const EventUsersScreen({
    super.key,
    required this.eventId,
    required this.providerId,
    this.sessionId,
  });

  @override
  ConsumerState<EventUsersScreen> createState() => _EventUsersScreenState();
}

class _EventUsersScreenState extends ConsumerState<EventUsersScreen>
    with CSVMixin {
  late EventIds ids;

  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    dateFormat = DateFormat('HH:mm');
    ids = EventIds(
      providerId: widget.providerId,
      eventId: widget.eventId,
      sessionId: widget.sessionId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final eventState = ref.watch(eventProvider(ids));
    final usersState = ref.watch(eventUsersStreamProvider(ids));
    final subEvent =
        ids.sessionId == null ? null : ref.watch(getSessionProvider(ids)).value;
    // final role = ref.watch(userRoleProvider(widget.providerId));
    // final isOwner = role == UserRole.admin;
    final hasData = usersState is AsyncData;
    final anonymous = eventState.value?.anonymous ?? true;
    final genderCount = ids.sessionId == null
        ? eventState.valueOrNull?.genderCount
        : subEvent?.genderCount;
    // final eventOrSessionClosed = ids.sessionId == null
    //     ? eventState.valueOrNull?.isClosed
    //     : eventState.valueOrNull?.activeSessionId != ids.sessionId;
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Iscritti',
      ),
      body: LoadingOverlay(
        isLoading: isLoading.value,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            UsersListWidget(
              anonymous: anonymous,
              genderCount: genderCount,
              usersState: usersState,
            ),
          ],
        ),
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
                          isLoading.value = false;
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

  _deleteUser(String userId, String name) async {
    final answer = await showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sicuro di voler eliminare l\'utente $name?',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(c).pop();
                          },
                          child: const Text('Annulla')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(c).pop(true);
                          },
                          child: const Text('Sì'))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    if (answer ?? false) {
      Cloud.eventUsersCollection(
              EventIds(providerId: widget.providerId, eventId: widget.eventId))
          .doc(userId)
          .delete();
    }
  }
}
