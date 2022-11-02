import 'package:countmein/my_logger.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cloud.dart';
import '../../../domain/entities/cmi_provider.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';


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
    logger.i('activeProvidersStreamProvider user is not authenticated');
    yield <CMIProvider>[];
  }
});

final singleCMIProviderProvider =
    StreamProvider.family<CMIProvider?, String>((ref, providerId) async* {

/*  final p = ref
      .watch(activeProvidersStreamProvider)
      .asData
      ?.value
      .firstWhereOrNull((element) => element.id == providerId);
  return p;*/


  if (ref.exists(activeProvidersStreamProvider)) {
    logger.i("eventProvider: eventsStreamProvider exists ");
    final itemFromItemList = await ref.watch(activeProvidersStreamProvider
        .selectAsync(
            (list) => list.firstWhereOrNull((element) => element.id == providerId)));
    if (itemFromItemList != null) {
      logger.i("eventProvider: emit from existing provider");
      yield itemFromItemList;
      return;
    }
  }

  final stream = Cloud.providerDoc(providerId).snapshots();
  await for (final snap in stream) {
    final data = snap.data();
    if (snap.exists && data != null) {
      yield CMIProvider.fromJson(data);
    }
  }
});
