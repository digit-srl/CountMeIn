import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/my_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventUsersStreamProvider =
    StreamProvider.family<List<EventUser>, EventIds>((ref, ids) async* {
  final stream = Cloud.eventUsersCollection(ids).snapshots();

  await for (final snap in stream) {
    logger.i('event: ${ids.eventId} => ${snap.docs.length} users');
    final list = <EventUser>[];
    for (int i = 0; i < snap.docs.length; i++) {
      try {
        final data = snap.docs[i].data();
        final s = EventUser.fromJson(data);
        list.add(s);
      } catch (ex, st) {
        logger.i(ex);
        logger.i(st);
      }
    }
    yield list;
  }
});
