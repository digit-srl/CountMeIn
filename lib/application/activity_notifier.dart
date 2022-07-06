import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cloud.dart';
import '../domain/entities/cmi_provider.dart';

final activityStreamProvider =
StreamProvider.family<CMIProvider, String>((ref, activityId) async* {
  final eventStream = Cloud.providerCollection.doc(activityId).snapshots();
  await for (final snap in eventStream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      print(data);
      yield CMIProvider.fromJson(data);
    } else {
      print('error');
    }
  }
});