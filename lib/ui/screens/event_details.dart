import 'dart:io';

import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/ui/screens/activities.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/ui/screens/scan.dart';

import '../../application/activity_notifier.dart';
import '../../constants.dart';
import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/user_card.dart';
import '../../src/auth/domain/entities/user.dart';
import '../../utils.dart';
import '../widgets/add_session_dialog.dart';
import '../widgets/loading.dart';
import 'admin.dart';
import 'admin_user_details.dart';
import 'user_event.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  static const String routeName = '/eventDetails';

  final Event event;
  final String providerId;

  const EventDetailsScreen({
    Key? key,
    required this.event,
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
    ids = EventIds(activityId: widget.providerId, eventId: widget.event.id);
  }

  _goToScan(CMIProvider activity) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ScanScreen(
          event: widget.event,
          activity: activity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventState =
        ref.watch(eventProvider([widget.providerId, widget.event.id]));
    final activityState = ref.watch(activityStreamProvider(widget.providerId));
    final usersState = ref.watch(usersStreamProvider(ids));
    final role = ref.watch(userRoleProvider(widget.providerId));
    final isOwner = role == UserRole.admin;
    final hasData = usersState is AsyncData;
    return Scaffold(
      appBar: AppBar(
        title: Text(eventState.asData?.value.name ?? ''),
        actions: [
          if (eventState is AsyncData<Event> &&
              activityState is AsyncData<CMIProvider> &&
              widget.event.isOpen) ...[
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _goToScan(activityState.asData!.value);
                }),
          ]
        ],
      ),
      body: usersState.when(
        data: (list) {
          return list.isEmpty
              ? const Center(
                  child: Text(
                    'Non ci sono utenti per questo evento',
                  ),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (c, index) {
                    final user = list[index];
                    return ListTile(
                      onTap: () {
                        context.push(UserDetailsScreen.routeName, extra: user);
                      },
                      title: Text(user.fullName),
                      subtitle: Text(
                        user.cf,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      leading: Text('${index + 1}'),
                      trailing: isOwner
                          ? IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                _deleteUser(user.id, user.fullName);
                              })
                          : null,
                    );
                  });
        },
        error: (err, stack) {
          return Center(child: Text(err.toString()));
        },
        loading: () => Center(child: LoadingWidget()),
      ),
      floatingActionButton: usersState.maybeWhen(
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
                  final list = (usersState as AsyncData).value;
                  showDialog(
                      context: context,
                      builder: (c) => const LoadingWidget(),
                      barrierDismissible: false);
                  final file = await getCsv(
                      list, eventState.asData?.value.name ?? 'event_csv');
                  if (mounted) {
                    Navigator.of(context).pop();
                    if (file != null) {
                      Share.shareFiles([file.path]);
                    } else {
                      showToast('Si è verificato un errore!',
                          position: ToastPosition.bottom);
                    }
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

  Future<File?> getCsv(List<UserCard> users, String eventName) async {
    try {
      final filename = eventName.replaceAll(' ', '_').toLowerCase();
      final statuses = await [
        Permission.storage,
      ].request();
      if (await Permission.storage.request().isGranted) {
        final dir =
            (await getExternalStorageDirectory())!.path + "/$filename.csv";

        final f = File(dir);

        final data = users.map((e) => e.toCsvList()).toList();
        final csv = const ListToCsvConverter().convert(data);
        await f.writeAsString(csv);
        return f;
      }
      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
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
      Cloud.eventUsersCollection(widget.providerId, widget.event.id)
          .doc(userId)
          .delete();
    }
  }
}
