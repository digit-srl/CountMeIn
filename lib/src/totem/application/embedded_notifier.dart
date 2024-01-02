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
  final stream = Cloud.totemDoc(providerId, eventId, sessionId, totemId).snapshots();
  await for (final snap in stream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      yield EmbeddedData.fromJson(data);
    }else{
      throw Exception('doc not exist');
    }
  }
}
