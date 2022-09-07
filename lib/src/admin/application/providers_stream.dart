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
    print('${snap.docs.length} providers trovati');
    final list = <CMIProvider>[];
    for (int i = 0; i < snap.docs.length; i++) {
      final d = snap.docs[i].data();
      try {
        final s = CMIProvider.fromJson(d);
        list.add(s);
      } catch (ex, st) {
        print(ex);
        print(st);
      }
    }
    yield list;
  }

  /*await for (final snap in stream) {
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
  }*/
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
      print('${snap.docs.length} providers trovati');
      final list = <CMIProvider>[];
      for (int i = 0; i < snap.docs.length; i++) {
        final d = snap.docs[i].data();
        try {
          final s = CMIProvider.fromJson(d);
          list.add(s);
        } catch (ex, st) {
          print(ex);
          print(st);
        }
      }
      yield list;
    }
  } else {
    print('user is not authenticated');
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
