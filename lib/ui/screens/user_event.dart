import 'package:countmein/ui/screens/user_register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:countmein/ui/screens/user_qr_code.dart';
import 'package:countmein/ui/widgets/loading.dart';

import '../../application/activity_notifier.dart';
import '../../domain/entities/user_card.dart';



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
          if(data.releaseWom){
            return UserFormScreen(
              activity: data,
            );
          }
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
