import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/ui/screens/user_register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:countmein/ui/screens/user_qr_code.dart';
import 'package:countmein/ui/widgets/loading.dart';
import '../../domain/entities/user_card.dart';

final singleEventProvider = StreamProvider.autoDispose
    .family<CMIProvider, String>((ref, providerId) async* {
  var query = Cloud.providerCollection.doc(providerId);
  final stream = query.snapshots();

  await for (final s in stream) {
    if (s.exists) {
      final data = s.data();
      if (data != null) {
        yield CMIProvider.fromJson(data);
      }
    }
  }
});

class UserEventScreen extends ConsumerWidget {
  static const routeName = '/event';

  final String providerId;

  const UserEventScreen({
    Key? key,
    required this.providerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(singleEventProvider(providerId)).asData?.value;
    if (eventState == null) {
      return const LoadingWidget();
    }

    if (eventState.releaseWom) {
      return UserFormScreen(
        activity: eventState,
      );
    }
    return ValueListenableBuilder<Box<dynamic>>(
        valueListenable: Hive.box('user').listenable(),
        builder: (context, box, child) {
          final userJson = box.get('myUser');
          if (userJson != null) {
            final userMap = Map<String, dynamic>.from(userJson);
            return UserQRCodeScreen(
              session: eventState,
              user: UserCard.fromJson(userMap),
            );
          }
          return UserFormScreen(
            activity: eventState,
          );
        });
  }
}
