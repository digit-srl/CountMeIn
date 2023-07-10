import 'dart:convert';

import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/users_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/admin/ui/widgets/gender_card.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/screens/admin_user_details.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fl_chart/fl_chart.dart';
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
  final String? subEventId;

  const EventUsersScreen({
    Key? key,
    required this.eventId,
    required this.providerId,
    this.subEventId,
  }) : super(key: key);

  @override
  ConsumerState<EventUsersScreen> createState() => _EventUsersScreenState();
}

class _EventUsersScreenState extends ConsumerState<EventUsersScreen> {
  late EventIds ids;

  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    dateFormat = DateFormat('HH:mm');
    ids = EventIds(
      providerId: widget.providerId,
      eventId: widget.eventId,
      sessionId: widget.subEventId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final eventState = ref.watch(eventProvider(ids));
    final usersState = ref.watch(eventUsersStreamProvider(ids));
    final subEvent =
        ids.sessionId == null ? null : ref.watch(subEventProvider(ids)).value;
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
            // if ((eventOrSessionClosed ?? false) &&
            //     genderCount != null &&
            //     genderCount.total > 3)
            if (genderCount != null) GenderCard(genderCount: genderCount),
            const SizedBox(height: 8),
            Text(
              'Utenti',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 16),
            usersState.when(
              data: (list) {
                return list.isEmpty
                    ? const Center(
                        child: Text(
                          'Non ci sono utenti per questo evento',
                        ),
                      )
                    : anonymous
                        ? Text(list.length == 1
                            ? 'C\'è un iscritto'
                            : 'Ci sono ${list.length} iscritti')
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 48),
                            itemBuilder: (c, index) {
                              final user = list[index];
                              return ListTile(
                                onTap: () {
                                  context.push(UserDetailsScreen.routeName,
                                      extra: user);
                                },
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      user.isGroup
                                          ? user.groupName ?? 'Gruppo'
                                          : anonymous
                                              ? user.id
                                              : user.fullName,
                                    ),
                                    if (user.isGroup)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Chip(
                                          label: Text(
                                            'GROUP',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 0,
                                            vertical: 0,
                                          ),
                                          labelPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 0,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: user.isGroup
                                    ? Text(
                                        '${user.groupCount} persone',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      )
                                    : anonymous
                                        ? null
                                        : Text(
                                            user.cf ?? '-',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                leading: Text('${index + 1}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (user.checkInAt != null)
                                      Tooltip(
                                        message:
                                            dateFormat.format(user.checkInAt!),
                                        child: const Icon(
                                          Icons.arrow_circle_down,
                                          color: Colors.green,
                                        ),
                                      ),
                                    const SizedBox(width: 16),
                                    if (user.checkOutAt != null)
                                      Tooltip(
                                        message:
                                            dateFormat.format(user.checkOutAt!),
                                        child: const Icon(
                                          Icons.arrow_circle_up,
                                          color: Colors.red,
                                        ),
                                      ),
                                    if (user.participationCount != null)
                                      Text(
                                          'Presenze ${user.participationCount}'),
                                  ],
                                ),
                                // trailing: isOwner
                                //     ? IconButton(
                                //         icon: const Icon(Icons.delete),
                                //         color: Colors.red,
                                //         onPressed: () {
                                //           _deleteUser(user.id, user.fullName);
                                //         })
                                //     : null,
                              );
                            },
                          );
              },
              error: (err, stack) {
                return Center(child: Text(err.toString()));
              },
              loading: () => const Center(child: LoadingWidget()),
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
                      // final activity = eventState.asData!.value;
                      // final event = activity.copyWith(id: Uuid().v4());
                      // await Cloud.activitiesCollection.doc(activity.id)
                      // .collection('events')
                      //     .doc(event.id)
                      //     .set(event.toJson());
                      // final batch = FirebaseFirestore.instance.batch();
                      // for (final user in list) {
                      //   batch.set(
                      //       Cloud.activitiesCollection
                      //           .doc(activity.id)
                      //           .collection('events')
                      //           .doc('47969dfe-038c-406a-8bf6-a9cec914391d')
                      //           .collection('users')
                      //           .doc(user.id),
                      //       user.toJson());
                      // }
                      // batch.commit();
                      // return;
                      if (hasData) {
                        isLoading.value = true;
                        try {
                          final list = (usersState as AsyncData).value;
                          final fileName =
                              eventState.asData?.value.name ?? 'event_csv';
                          if (kIsWeb) {
                            final bytes = getCsvBytes(list,
                                eventState.asData?.value.name ?? 'event_csv');
                            final path = await FileSaver.instance.saveFile(
                                name: fileName,
                                // file: file,
                                bytes: bytes,
                                mimeType: MimeType.pdf,
                                ext: 'csv');
                            logger.i(path);
                          } else {
                            final file = await getCsv(list,
                                eventState.asData?.value.name ?? 'event_csv');
                            if (file != null) {
                              if (Platform.isMacOS) {
                                final path = await FileSaver.instance.saveFile(
                                    name: fileName,
                                    file: file,
                                    // bytes: bytes,
                                    mimeType: MimeType.pdf,
                                    ext: 'csv');
                              } else {
                                Share.shareFiles([file.path]);
                              }
                            }
                          }

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

  String _buildCsv(List<EventUser> users) {
    final data = users.map((e) => e.toCsvList()).toList();
    final csv = const ListToCsvConverter().convert(data);
    return csv;
  }

  Uint8List getCsvBytes(List<EventUser> users, String eventName) {
    final csv = _buildCsv(users);
    final bytes = Uint8List.fromList(utf8.encode(csv));
    return bytes;
  }

  Future<File?> getCsv(List<EventUser> users, String eventName) async {
    try {
      final filename = eventName.replaceAll(' ', '_').toLowerCase();
      final csv = _buildCsv(users);

      if (kIsWeb) {
        return null;
      } else {
        final statuses = await [
          Permission.storage,
        ].request();
        if (await Permission.storage.request().isGranted) {
          final dir =
              "${(await getExternalStorageDirectory())!.path}/$filename.csv";

          final f = File(dir);

          await f.writeAsString(csv);
          return f;
        }
        return null;
      }
    } catch (ex) {
      logger.e(ex);
      return null;
    }
  }
}
