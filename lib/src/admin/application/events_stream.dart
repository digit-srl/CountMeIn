import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cloud.dart';
import 'package:collection/collection.dart' show IterableExtension;

final eventsStreamProvider =
    StreamProvider.family<List<CMIEvent>, String>((ref, providerId) async* {
  final authUserState = ref.watch(authStateProvider);
  if (authUserState is Authenticated) {
    final user = authUserState.user;
    final pManagers = ref
            .watch(singleCMIProviderProvider(providerId))
            .valueOrNull
            ?.managers ??
        {};
    if (pManagers.containsKey(user.uid)) {
      final stream = Cloud.eventsCollection(providerId).snapshots();

      await for (final snap in stream) {
        logger.i('${snap.docs.length} eventi trovati');
        final list = <CMIEvent>[];
        for (int i = 0; i < snap.docs.length; i++) {
          final d = snap.docs[i].data();

          try {
            final s = CMIEvent.fromJson(d);
            if (pManagers[user.uid]?.role != UserRole.scanner ||
                pManagers[user.uid]!.eventsRestriction.contains(s.id)) {
              list.add(s);
            }
          } catch (ex, st) {
            logger.i(d);
            logger.i(ex);
            logger.i(st);
          }
        }
        logger.i('${list.length}/${snap.docs.length} eventi mostrati');
        yield list;
      }
    } else {
      logger.i(
          'eventsStreamProvider user is not manager of this provider $providerId');
      yield <CMIEvent>[];
    }
  } else {
    logger.i('eventsStreamProvider user is not authenticated');
    yield <CMIEvent>[];
  }
});

final eventProvider =
    StreamProvider.family<CMIEvent, EventIds>((ref, ids) async* {
  final providerId = ids.providerId;
  final eventId = ids.eventId;

  if (ref.exists(eventsStreamProvider(providerId))) {
    logger.i("eventProvider: eventsStreamProvider exists ");
    final itemFromItemList = await ref.watch(eventsStreamProvider(providerId)
        .selectAsync(
            (list) => list.firstWhereOrNull((event) => event.id == eventId)));
    if (itemFromItemList != null) {
      logger.i("eventProvider: emit from existing provider");
      yield itemFromItemList;
      return;
    }
  }

  final stream = Cloud.eventsCollection(providerId).doc(eventId).snapshots();
  await for (final snap in stream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      yield CMIEvent.fromJson(data);
    }
  }
});

final sessionsStreamProvider =
    StreamProvider.family<List<CMISubEvent>, EventIds>((ref, ids) async* {
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
    logger.i('sessionsStreamProvider: mostrate ${list.length}/${snap.docs.length}');
    yield list;
  }
});

final subEventProvider =
    StreamProvider.family<CMISubEvent, EventIds>((ref, ids) async* {
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
});
