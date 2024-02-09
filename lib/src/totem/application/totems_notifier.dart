import 'package:countmein/cloud.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'totems_notifier.g.dart';

@riverpod
Stream<List<EmbeddedData>> getTotems(
  GetTotemsRef ref,
  String providerId,
  String eventId,
) async* {
  final stream = Cloud.totemCollection(providerId, eventId).snapshots();
  yield* emb(stream);
}

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
  GetTotemsByEventRef ref,
  String providerId,
  String eventId,
) async* {
  final stream = Cloud.providerTotemCollection(providerId)
      .where('eventId', isEqualTo: eventId)
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
    final stream = Cloud.providerTotemCollection(providerId)
        .where('eventId', isEqualTo: null)
        .snapshots();
    yield* emb(stream);
  }
}

@riverpod
Stream<List<EmbeddedData>> getProviderTotems(
    GetProviderTotemsRef ref, String providerId) async* {
  var stream = Cloud.providerTotemCollection(providerId).snapshots();
  yield* emb(stream);
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
    final stream = Cloud.providerTotemCollection(providerId)
        .where('eventId', isEqualTo: eventId)
        .where('sessionId', isEqualTo: sessionId)
        .snapshots();
    yield* emb(stream);
  }
}
