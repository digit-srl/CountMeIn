import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/user/application/user_profile_notifier.dart';
import 'package:countmein/src/user/ui/widgets/user_profile.dart';
import 'package:countmein/src/user/ui/widgets/waiting_otp_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserConsoleScreen extends ConsumerStatefulWidget {
  static const routeName = '/profile';
  final UserIds userIds;

  const UserConsoleScreen({required this.userIds, super.key});

  @override
  ConsumerState<UserConsoleScreen> createState() => _UserConsoleScreenState();
}

class _UserConsoleScreenState extends ConsumerState<UserConsoleScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProfileNotifierProvider(widget.userIds));
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: CMICard(
            child: state.when(
              initial: () {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                          'Richiedi il codice otp per accedere al tuo profilo',),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () {
                            ref
                                .read(userProfileNotifierProvider(widget.userIds)
                                    .notifier,)
                                .getOtpCode();
                          },
                          child: const Text('Richiedi codice'),),
                    ],
                  ),
                );
              },
              loading: () {
                return const CircularProgressIndicator();
              },
              error: (ex, st) {
                return Text(ex.toString());
              },
              waitingOtpCode: () {
                return WaitingOtpCode(
                  userIds: widget.userIds,
                    verify:(otpCode){
                      ref
                          .read(userProfileNotifierProvider(widget.userIds).notifier)
                          .verifyOtpCode(otpCode);
                    },
                );
              },
              wrongCode: () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Otp non valido'),
                    ElevatedButton(
                        onPressed: () {
                          ref
                              .read(userProfileNotifierProvider(widget.userIds)
                                  .notifier,)
                              .reset();
                        },
                        child: const Text('Riprova'),),
                  ],
                );
              },
              data: () {
                return UserProfileDataWidget(
                  userIds: widget.userIds,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

