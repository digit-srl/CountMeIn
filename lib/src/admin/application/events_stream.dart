import 'package:countmein/domain/entities/event_ids.dart';
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

final eventProvider =
    Provider.family<AsyncValue<CMIEvent>, EventIds>((ref, ids) {
  final providerId = ids.providerId;
  final eventId = ids.eventId;
  return ref
      .watch(eventsStreamProvider(providerId))
      .whenData((list) => list.firstWhere((event) => event.id == eventId));
});


final subEventsStreamProvider =
StreamProvider.family<List<CMISubEvent>, EventIds>((ref, ids) async* {
  final providerId = ids.providerId;
  final eventId = ids.eventId;
  final stream = Cloud.eventsCollection(providerId).doc(eventId).collection('subEvents').snapshots();

  await for (final snap in stream) {
    print('${snap.docs.length} eventi trovati');
    final list = <CMISubEvent>[];
    for (int i = 0; i < snap.docs.length; i++) {
      final d = snap.docs[i].data();
      try {
        final s = CMISubEvent.fromJson(d);
        list.add(s);
      } catch (ex, st) {
        print(ex);
        print(st);
      }
    }
    yield list;
  }
});

final subEventProvider =
Provider.family<AsyncValue<CMISubEvent>, EventIds>((ref, ids) {
  final subEventId = ids.subEventId;
  return ref
      .watch(subEventsStreamProvider(ids))
      .whenData((list) => list.firstWhere((event) => event.id == subEventId));
});