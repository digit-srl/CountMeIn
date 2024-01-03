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
    logger.i('${list.length}/${snap.docs.length} totem mostrati');
    yield list;
  }
}
