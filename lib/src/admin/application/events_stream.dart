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

part 'events_stream.g.dart';

@riverpod
Stream<List<CMIEvent>> eventsStream(EventsStreamRef ref, String providerId,
    {EventStatus status = EventStatus.live}) async* {
  final authUserState = ref.watch(authStateProvider);
  final filter = ref.watch(eventFilterNotifierProvider);
  final isCMIAdmin = ref.watch(platformUserRoleProvider) == PlatformRole.cmi;
  if (authUserState is Authenticated) {
    final user = authUserState.user;
    final pManagers = ref
            .watch(singleCMIProviderProvider(providerId))
            .valueOrNull
            ?.managers ??
        {};
    if (isCMIAdmin || pManagers.containsKey(user.uid)) {
      try {
        var query = Cloud.eventsCollection(providerId)
            .where('status', isEqualTo: status.name);

        if (status == EventStatus.archived) {
          query = Cloud.eventsCollection(providerId).where(Filter.or(
              Filter("status", isEqualTo: EventStatus.archived.name),
              Filter("status", isEqualTo: EventStatus.closed.name)));
        }

        final stream = query.snapshots();

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
          if (filter == EventFilter.byDate) {
            list.sort((a, b) => a.createdOn.compareTo(b.createdOn));
          } else {
            list.sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          }
          yield list;
        }
      } catch (ex, st) {
        logger.e(st);
        rethrow;
      }
    } else {
      logger.i(
          'eventsStreamProvider: user is not manager of this provider $providerId');
      yield <CMIEvent>[];
    }
  } else {
    logger.i('eventsStreamProvider: user is not authenticated');
    yield <CMIEvent>[];
  }
}

enum EventFilter { byName, byDate }

@riverpod
class EventFilterNotifier extends _$EventFilterNotifier {
  @override
  EventFilter build() {
    return EventFilter.byName;
  }

  void onChanged(EventFilter? value) {
    if (value != null) {
      state = value;
    }
  }
}

@riverpod
Stream<CMIEvent> event(EventRef ref, EventIds ids) async* {
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
}


