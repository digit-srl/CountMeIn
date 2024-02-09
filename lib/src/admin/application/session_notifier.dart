import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../cloud.dart';
import 'package:collection/collection.dart' show IterableExtension;

part 'session_notifier.g.dart';

@riverpod
Stream<List<CMISubEvent>> sessionsStream(
    SessionsStreamRef ref, EventIds ids) async* {
  // final providerId = ids.providerId;
  // final eventId = ids.eventId;
  final stream = Cloud.sessionCollection(ids).snapshots();

  await for (final snap in stream) {
    logger.i('sessionsStreamProvider: ${snap.docs.length} sessioni trovate');
    final list = <CMISubEvent>[];
    for (int i = 0; i < snap.docs.length; i++) {
      final d = snap.docs[i].data();
      try {
        final s = CMISubEvent.fromJson(d);
        list.add(s);
      } catch (ex, st) {
        logger.i(ex);
        logger.i(st);
      }
    }
    logger.i(
        'sessionsStreamProvider: mostrate ${list.length}/${snap.docs.length}');
    yield list;
  }
}

@riverpod
Stream<CMISubEvent> getSession(GetSessionRef ref, EventIds ids) async* {
  final subEventId = ids.sessionId;

  if (ref.exists(sessionsStreamProvider(ids))) {
    logger.i("subEventProvider: subEventsStreamProvider exists");
    final itemFromItemList = await ref.watch(sessionsStreamProvider(ids)
        .selectAsync((list) =>
        list.firstWhereOrNull((event) => event.id == subEventId)));
    if (itemFromItemList != null) {
      logger.i("subEventProvider: emit from existing provider");
      yield itemFromItemList;
      return;
    }
  }
  final stream = Cloud.sessionDoc(ids).snapshots();
  await for (final snap in stream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      yield CMISubEvent.fromJson(data);
    }
  }
}