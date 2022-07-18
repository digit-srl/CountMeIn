import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cloud.dart';
import '../../../domain/entities/session.dart';

final eventsStreamProvider =
    StreamProvider.family<List<Event>, String>((ref, providerId) async* {
  final stream = Cloud.eventsCollection(providerId).snapshots();

  await for (final snap in stream) {
    try {
      final list = snap.docs.map((doc) {
        final s = Event.fromJson(doc.data());
        return s;
      }).toList();
      yield list;
    } catch (ex, st) {
      print(ex);
      print(st);
      yield <Event>[];
    }
  }
});


