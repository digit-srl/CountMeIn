import 'package:countmein/my_logger.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/application/auth_state.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'info_text.dart';

class AdminInfoWidget extends ConsumerWidget {
  const AdminInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserState = ref.watch(authStateProvider);
    final user = authUserState is Authenticated ? authUserState.user : null;
    logger.i(user);
    return CMICard(
      // margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoText(
            label: 'Name',
            value: user?.name,
          ),
          InfoText(
            label: 'Cognome',
            value: user?.surname,
          ),
          InfoText(
            label: 'Email',
            value: user?.email,
            copyable: true,
          ),
          InfoText(
            label: 'Ruolo piattaforma',
            value: user?.role.text,
          ),
          InfoText(
            label: 'ID',
            value: user?.uid,
            copyable: true,
          ),
        ],
      ),
    );
  }
}
