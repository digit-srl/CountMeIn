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
  String sessionId,
) async* {
  final stream =
      Cloud.totemCollection(providerId, eventId, sessionId).snapshots();
  final list = <EmbeddedData>[];
  await for (final snap in stream) {
    for (int i = 0; i < snap.docs.length; i++) {
      try {
        final d = snap.docs[i].data();
        list.add(EmbeddedData.fromJson(d));
      } catch (ex, st) {
        logger.e(ex);
        logger.e(st);
      }
    }
    logger.i('${list.length}/${snap.docs.length} totem mostrati');
    yield list;
  }
}
