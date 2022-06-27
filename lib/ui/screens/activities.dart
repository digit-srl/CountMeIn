import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';

import '../../cloud.dart';
import '../../constants.dart';
import '../../domain/entities/activity.dart';
import '../../domain/entities/session.dart';
import '../../utils.dart';
import '../widgets/add_session_dialog.dart';
import '../widgets/loading.dart';
import 'admin.dart';
import 'event_details.dart';

final activitiesStreamProvider = StreamProvider<List<Activity>>((ref) async* {
  final stream = Cloud.activitiesCollection
      .where('status', isEqualTo: enumToString(ActivityStatus.live))
      .snapshots();

  await for (final snap in stream) {
    final list = snap.docs.map((doc) {
      final s = Activity.fromJson(doc.data());
      return s;
    }).toList();
    yield list;
  }
});

final activityProvider =
    Provider.family<AsyncValue<Activity>, String>((ref, activityId) {
  return ref.watch(activitiesStreamProvider).whenData(
      (value) => value.firstWhere((element) => element.id == activityId));
});

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesState = ref.watch(activitiesStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attività'),
        /* actions: [
          if (isMaster)
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (c) {
                        return Dialog(
                          child: AddSessionDialog(),
                        );
                      });
                }),
        ],*/
      ),
      body: activitiesState.when(
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
                final activity = list[index];
                return ListTile(
                  title: Text(
                    activity.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(activity.id),
                  // leading: Text('${index + 1}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => ActivityScreen(
                          activityId: activity.id,
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

  void _deleteActivity(BuildContext context, String id, String name) {}
}

class ActivityScreen extends ConsumerStatefulWidget {
  final String activityId;

  const ActivityScreen({
    Key? key,
    required this.activityId,
  }) : super(key: key);

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    final eventsState = ref.watch(eventsStreamProvider(widget.activityId));
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
                          child: AddSessionDialog(
                            activityId: widget.activityId,
                          ),
                        );
                      });
                }),
          IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text: '$baseUrl/activity/${widget.activityId}'));
                showToast('Url evento copiato negli appunti',
                    position: ToastPosition.bottom);
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
                            // _deleteEvent(context, event.id, event.name);
                          })
                      : null,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => EventDetailsScreen(
                          activityId: widget.activityId,
                          eventId: event.id,
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
}
