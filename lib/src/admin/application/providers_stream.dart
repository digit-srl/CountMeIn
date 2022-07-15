import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cloud.dart';
import '../../../domain/entities/cmi_provider.dart';

final pendingProvidersStreamProvider =
    StreamProvider<List<CMIProvider>>((ref) async* {
  final stream =
      Cloud.providerRequests.where('status', isEqualTo: 'pending').snapshots();

  await for (final snap in stream) {
    try {
      final list = snap.docs.map((doc) {
        final s = CMIProvider.fromJson(doc.data());
        return s;
      }).toList();
      yield list;
    } catch (ex, st) {
      print(ex);
      print(st);
      yield <CMIProvider>[];
    }
  }
});

final activeProvidersStreamProvider =
    StreamProvider<List<CMIProvider>>((ref) async* {
  final stream =
      Cloud.providerCollection.where('status', isEqualTo: 'live').snapshots();

  await for (final snap in stream) {
    try {
      final list = snap.docs.map((doc) {
        final s = CMIProvider.fromJson(doc.data());
        return s;
      }).toList();
      yield list;
    } catch (ex, st) {
      print(ex);
      print(st);
      yield <CMIProvider>[];
    }
  }
});
