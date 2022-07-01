import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'email_verification_state.dart';

final emailVerificationProvider = StateNotifierProvider.autoDispose.family<
    EmailVerificationNotifier,
    EmailVerificationState,
    EmailVerificationData>((ref, data) {
  return EmailVerificationNotifier(data);
});

class EmailVerificationNotifier extends StateNotifier<EmailVerificationState> {
  final EmailVerificationData data;

  EmailVerificationNotifier(this.data)
      : super(const EmailVerificationState.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      print('init verification email');
      final userRef = Cloud.usersCollection.doc(data.userId);
      final snap = await userRef.get();
      if (!snap.exists) {
        state = const EmailVerificationUserNotExist();
      } else {
        final user = UserCard.fromJson(snap.data()!);
        if (user.emailVerified) {
          state = const EmailVerificationVerified();
        } else if (user.secret == data.secret) {
          await userRef.update({
            'secret': null,
            'emailVerified': true,
          });
          state = const EmailVerificationVerified();
        } else {
          state = const EmailVerificationInvalidData();
        }
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      state = EmailVerificationError(ex, st);
    }
  }
}
