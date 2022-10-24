import 'package:countmein/my_logger.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart' show IterableExtension;
import '../../../cloud.dart';
import '../../../domain/entities/cmi_provider.dart';

final pendingProvidersStreamProvider =
    StreamProvider<List<CMIProvider>>((ref) async* {
  final stream =
      Cloud.providerRequests.where('status', isEqualTo: 'pending').snapshots();

  await for (final snap in stream) {
    logger.i('${snap.docs.length} providers trovati');
    final list = <CMIProvider>[];
    for (int i = 0; i < snap.docs.length; i++) {
      final d = snap.docs[i].data();
      try {
        final s = CMIProvider.fromJson(d);
        list.add(s);
      } catch (ex, st) {
        logger.w(d);
        logger.e(ex);
        logger.e(st);
      }
    }
    yield list;
  }
});

final activeProvidersStreamProvider =
    StreamProvider<List<CMIProvider>>((ref) async* {
  final authUserState = ref.watch(authStateProvider);

  if (authUserState is Authenticated) {
    final user = authUserState.user;
    var query = Cloud.providerCollection.where('status', isEqualTo: 'live');
    if (user.role != PlatformRole.cmi) {
      // query = query.where('managers', arrayContains: user.uid);
      query = query.where('managers.${user.uid}.id', isEqualTo: user.uid);
    }
    final stream = query.snapshots();

    await for (final snap in stream) {
      logger.i('${snap.docs.length} providers trovati');
      final list = <CMIProvider>[];
      for (int i = 0; i < snap.docs.length; i++) {
        final d = snap.docs[i].data();
        try {
          final s = CMIProvider.fromJson(d);
          list.add(s);
        } catch (ex, st) {
          logger.w(d);
          logger.e(ex);
          logger.e(st);
        }
      }
      yield list;
    }
  } else {
    logger.i('user is not authenticated');
    yield <CMIProvider>[];
  }
});

final singleCMIProviderProvider =
    Provider.family<CMIProvider?, String>((ref, providerId) {

  final p = ref
      .watch(activeProvidersStreamProvider)
      .asData
      ?.value
      .firstWhereOrNull((element) => element.id == providerId);
  return p;
});
