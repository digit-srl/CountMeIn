import 'package:countmein/cloud.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'totems_notifier.g.dart';

Stream<List<EmbeddedData>> emb(Stream stream) async* {
  await for (final snap in stream) {
    final list = <EmbeddedData>[];
    for (int i = 0; i < snap.docs.length; i++) {
      try {
        final d = snap.docs[i].data();
        list.add(EmbeddedData.fromJson(d));
      } catch (ex, st) {
        logger.e(ex);
        logger.e(st);
      }
    }
    logger.i('${list.length}/${snap.docs.length} totem dedicati mostrati');
    yield list;
  }
}

@riverpod
Stream<List<EmbeddedData>> getTotemsByEvent(
    GetTotemsByEventRef ref, String providerId, String eventId,
    {bool dedicated = true}) async* {
  final stream = Cloud.totemCollection(providerId)
      .where('eventId', isEqualTo: eventId)
      .where('dedicated', isEqualTo: dedicated)
      .snapshots();
  yield* emb(stream);
}

@riverpod
Stream<List<EmbeddedData>> getAvailableTotems(
    GetAvailableTotemsRef ref, String providerId) async* {
  if (ref.exists(getProviderTotemsProvider(providerId))) {
    final totems =
        ref.watch(getProviderTotemsProvider(providerId)).valueOrNull ?? [];
    yield* Stream.value(
        totems.where((element) => element.eventId == null).toList());
  } else {
    final stream = Cloud.totemCollection(providerId)
        .where('eventId', isEqualTo: null)
        .snapshots();
    yield* emb(stream);
  }
}

@riverpod
Stream<List<EmbeddedData>> getProviderTotems(
    GetProviderTotemsRef ref, String providerId,
    {bool? dedicated}) async* {
  if (dedicated != null) {
    yield* emb(Cloud.totemCollection(providerId)
        .where('dedicated', isEqualTo: dedicated)
        .snapshots());
  } else {
    yield* emb(Cloud.totemCollection(providerId).snapshots());
  }
}

@riverpod
Stream<List<EmbeddedData>> getSessionTotems(GetSessionTotemsRef ref,
    String providerId, String eventId, String sessionId) async* {
  if (ref.exists(getProviderTotemsProvider(providerId))) {
    final totems =
        ref.watch(getProviderTotemsProvider(providerId)).valueOrNull ?? [];
    yield* Stream.value(totems
        .where((element) =>
            element.eventId == eventId && element.sessionId == sessionId)
        .toList());
  } else {
    final stream = Cloud.totemCollection(providerId)
        .where('eventId', isEqualTo: eventId)
        .where('sessionId', isEqualTo: sessionId)
        .snapshots();
    yield* emb(stream);
  }
}

@riverpod
Stream<EmbeddedData> getTotemData(
    GetTotemDataRef ref, String providerId, String totemId) async* {
  if (ref.exists(getProviderTotemsProvider(providerId))) {
    final totems =
        ref.watch(getProviderTotemsProvider(providerId)).valueOrNull ?? [];
    final t = totems.firstWhereOrNull((element) => element.id == totemId);
    if (t != null) {
      yield* Stream.value(t);
      return;
    }
  }
  final stream = Cloud.totemDoc(providerId, totemId).snapshots();
  await for (final snap in stream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      final totemData = EmbeddedData.fromJson(data);
      yield totemData;
    } else {
      throw Exception('doc not exist');
    }
  }
}
