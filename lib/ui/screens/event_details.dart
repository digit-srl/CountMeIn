import 'dart:io';

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

import '../../constants.dart';
import '../../domain/entities/activity.dart';
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/user_card.dart';
import '../../utils.dart';
import '../widgets/add_session_dialog.dart';
import '../widgets/loading.dart';
import 'admin.dart';
import 'admin_user_details.dart';
import 'user_event.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final String eventId;
  final String activityId;

  const EventDetailsScreen({
    Key? key,
    required this.eventId,
    required this.activityId,
  }) : super(key: key);

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late EventIds ids;

  @override
  void initState() {
    super.initState();
    ids = EventIds(activityId: widget.activityId, eventId: widget.eventId);
  }

  _goToScan() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ScanScreen(
          eventId: widget.eventId,
          activityId: widget.activityId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventState =
        ref.watch(eventProvider([widget.activityId, widget.eventId]));
    final usersState = ref.watch(usersStreamProvider(ids));

    final hasData = usersState is AsyncData;
    return Scaffold(
      appBar: AppBar(
        title: Text(eventState.asData?.value.name ?? ''),
        actions: [
          if (eventState is AsyncData<Event>) ...[
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _goToScan();
                  /*showModalBottomSheet(
                      context: context,
                      builder: (context) {
                      return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      ItemSelection(
                      icon: Icons.camera,
                      onPressed: () {
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                      builder: (c) => ScanScreen(
                      sessionId: widget.eventId,
                      ),
                      ),
                      );
                      },
                      text: 'Scansiona Qr Code',
                      ),
                      ItemSelection(
                      icon: Icons.add,
                      onPressed: () {
                      // final users = Hive.box<User>('user_${widget.session.id}');
                      // users.add(User('ciao', 'proa', 'sdfgh', Uuid().v1()));
                      // widget.session.users.add(
                      //     User('ciao', 'proa', 'sdfgh', Uuid().v1()));
                      // widget.session.save();
                      },
                      text: 'Aggiungi manualmente',
                      )
                      ],
                      ),
                      );
                      });
                   */
                }),
          ]
        ],
      ),
      body: usersState.when(
        data: (list) {
          return list.isEmpty
              ? const Center(
                  child: const Text(
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
                      subtitle: Text(user.cf),
                      leading: Text('${index + 1}'),
                      trailing: isMaster
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
      Cloud.eventUsersCollection(widget.activityId, widget.eventId)
          .doc(userId)
          .delete();
    }
  }
}
