import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/ui/screens/user_register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/ui/screens/user_qr_code.dart';
import 'package:countmein/ui/widgets/loading.dart';

import '../../domain/entities/activity.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/user_card.dart';
import 'home.dart';

final activityStreamProvider =
StreamProvider.family<Activity, String>((ref, activityId) async* {
  final eventStream = Cloud.activitiesCollection.doc(activityId).snapshots();
  await for (final snap in eventStream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      yield Activity.fromJson(data);
    }
  }
});

class UserEventScreen extends ConsumerWidget {
  static const routeName = '/event';

  final String activityId;

  const UserEventScreen({
    Key? key,
    required this.activityId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(activityStreamProvider(activityId));
    return eventState.when(
        data: (data) {
          return ValueListenableBuilder<Box<dynamic>>(
              valueListenable: Hive.box('user').listenable(),
              builder: (context, box, child) {
                final userJson = box.get('myUser');
                if (userJson != null) {
                  final userMap = Map<String, dynamic>.from(userJson);
                  return UserQRCodeScreen(
                    session: data,
                    user: UserCard.fromJson(userMap),
                  );
                }
                return UserFormScreen(
                  activity: data,
                );
              });
        },
        error: (err, st) {
          return Center(
            child: Text(err.toString()),
          );
        },
        loading: () => const LoadingWidget());
  }
}
