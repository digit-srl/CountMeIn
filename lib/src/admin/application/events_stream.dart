import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cloud.dart';

final eventsStreamProvider =
    StreamProvider.family<List<CMIEvent>, String>((ref, providerId) async* {
  final stream = Cloud.eventsCollection(providerId).snapshots();

/*  await for (final snap in stream) {
    try {
      final list = snap.docs.map((doc) {
        final s = CMIEvent.fromJson(doc.data());
        return s;
      }).toList();
      yield list;
    } catch (ex, st) {
      print(ex);
      print(st);
      yield <CMIEvent>[];
    }
  }*/

  await for (final snap in stream) {
    print('${snap.docs.length} eventi trovati');
    final list = <CMIEvent>[];
    for (int i = 0; i < snap.docs.length; i++) {
      final d = snap.docs[i].data();
      try {
        final s = CMIEvent.fromJson(d);
        list.add(s);
      } catch (ex, st) {
        print(ex);
        print(st);
      }
    }
    yield list;
  }
});
