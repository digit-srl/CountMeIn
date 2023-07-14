import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/screens/user_register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:countmein/ui/screens/user_qr_code.dart';
import 'package:countmein/ui/widgets/loading.dart';
import '../../domain/entities/user_card.dart';

final singleEventProvider = StreamProvider.autoDispose
    .family<CMIProvider, String>((ref, providerId) async* {
  var query = Cloud.providerCollection.doc(providerId);
  final stream = query.snapshots();

  await for (final s in stream) {
    if (s.exists) {
      try {
        final data = s.data();
        if (data != null) {
          yield CMIProvider.fromJson(data);
        }
      } catch (ex, st) {
        logger.i(st);
      }
    } else {
      logger.i('Doc not exists');
      throw Exception('Doc not exists');
    }
  }
});

class UserProviderScreen extends ConsumerWidget {
  static const routeName = '/provider';

  final String providerId;

  const UserProviderScreen({
    Key? key,
    required this.providerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmiProvider = ref.watch(singleEventProvider(providerId)).value;
    if (cmiProvider == null) {
      return const LoadingWidget();
    }

    return Scaffold(
      body: Center(
        child: CMICard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  cmiProvider.name,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.go('/provider/$providerId/register');
                  },
                  child: const Text('Registrati'),
                ),
                const SizedBox(height: 24),
                const Text('oppure'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.go('/provider/$providerId/recover');
                  },
                  child: const Text('Recupera il tuo tesserino'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (cmiProvider.releaseWom) {
      return UserFormScreen(
        providerId: providerId,
      );
    }
    return ValueListenableBuilder<Box<dynamic>>(
        valueListenable: Hive.box('user').listenable(),
        builder: (context, box, child) {
          final userJson = box.get('myUser');
          if (userJson != null) {
            final userMap = Map<String, dynamic>.from(userJson);
            return UserQRCodeScreen(
              session: cmiProvider,
              user: UserCard.fromJson(userMap),
            );
          }
          return UserFormScreen(
            providerId: providerId,
          );
        });
  }
}
