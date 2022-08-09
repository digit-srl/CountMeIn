
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countmein/cloud.dart';

import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/user_card.dart';
import '../../utils.dart';

final adminProvider =
    StateNotifierProvider<AdminNotifier, AsyncValue<List<CMIProvider>>>((ref) {
  return AdminNotifier();
});

/*final eventsStreamProvider =
    StreamProvider.family<List<CMIEvent>, String>((ref, activityId) async* {
  final stream = Cloud.eventsCollection(activityId)
      .where('status', isEqualTo: enumToString(CMIProviderStatus.live))
      // .orderBy('field')
      .snapshots();

  await for (final snap in stream) {
    final list = snap.docs.map((doc) {
      final s = CMIEvent.fromJson(doc.data());
      return s;
    }).toList();
    yield list;
  }
});*/

final eventProvider =
    Provider.family<AsyncValue<CMIEvent>, List<String>>((ref, ids) {
  final activityId = ids[0];
  final eventId = ids[1];
  return ref
      .watch(eventsStreamProvider(activityId))
      .whenData((list) => list.firstWhere((event) => event.id == eventId));
});

enum FilterOrder {
  byName,
  byDate,
}

final orderFilterProvider = StateProvider<FilterOrder>((ref) => FilterOrder.byDate);

final usersStreamProvider =
    StreamProvider.family<List<UserCard>, EventIds>((ref, ids) async* {
  final stream = Cloud.eventUsersCollection(ids.activityId, ids.eventId).snapshots();

  await for (final snap in stream) {
    print('event: ${ids.eventId} => ${snap.docs.length} users');
    final list = snap.docs.map((doc) {
      final s = UserCard.fromJson(doc.data());
      return s;
    }).toList();
    yield list;
  }
});

class AdminNotifier extends StateNotifier<AsyncValue<List<CMIProvider>>> {
  AdminNotifier() : super(const AsyncLoading());
}

/*class EventsScreen extends ConsumerWidget {
  final String activityId;

  const EventsScreen({
    Key? key,
    required this.activityId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsState = ref.watch(eventsStreamProvider(activityId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventi'),
        actions: [
          if (isMaster)
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (c) {
                        return Dialog(
                          child: AddSessionDialog(activityId: activityId,),
                        );
                      });
                }),
        ],
      ),
      body: eventsState.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(
              child: Text('Non ci sono eventi attivi'),
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (c, index) {
                final event = list[index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.id),
                  leading: Text('${index + 1}'),
                  trailing: isMaster
                      ? IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            _deleteSession(context, event.id, event.name);
                          })
                      : null,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => UserEventScreen(
                          id: event.id,
                        ),
                      ),
                    );
                  },
                );
              });
        },
        error: (err, stack) {
          return Text(err.toString());
        },
        loading: () => const LoadingWidget(),
      ),
    );
  }

  _deleteSession(
      BuildContext context, String eventId, String sessionName) async {
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
                    'Sicuro di voler cancellare l\'evento $sessionName?',
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
      print('yesss');
      Cloud.eventDoc(activityId, eventId)
          .update({'status': enumToString(SessionsStatus.archived)});
    }
  }
}*/



class ItemSelection extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onPressed;

  const ItemSelection(
      {Key? key, required this.icon, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
