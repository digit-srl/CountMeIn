import 'dart:async';

import 'package:countmein/cloud.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'embedded_notifier.g.dart';

//http://localhost:57825/embedded/UNIURB/1d2076b3-8d29-44ca-b7e2-3e68f6e8e0af/5CprXtcNv47OjDDou25D
@riverpod
Stream<EmbeddedData> getTotemData(
  GetTotemDataRef ref,
  String providerId,
  String eventId,
  String sessionId,
  String totemId,
) async* {
  final stream = Cloud.totemDoc(providerId, eventId, totemId).snapshots();
  late EmbeddedData totemData;
  await for (final snap in stream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      totemData = EmbeddedData.fromJson(data);
      yield totemData;
      if (totemData.isStatic) {}
    } else {
      throw Exception('doc not exist');
    }
  }
}

@riverpod
class TotemNotifier extends _$TotemNotifier {
  @override
  AsyncValue<EmbeddedData> build(
    String providerId,
    String eventId,
    String sessionId,
    String totemId,
  ) {
    StreamSubscription? subscription;
    ref.onDispose(() {
      subscription?.cancel();
      subscription = null;
    });

    subscription =
        Cloud.totemDoc(providerId, eventId, totemId).snapshots().listen((snap) {
      final data = snap.data();
      if (snap.exists && data != null) {
        final totemData = EmbeddedData.fromJson(data);
        state = AsyncData(totemData);
        if (totemData.isStatic) {
          subscription?.cancel();
        }
      } else {
        state =
            AsyncError(Exception('document doesn\' exists'), StackTrace.empty);
      }
    });

    return const AsyncValue.loading();
  }
}
