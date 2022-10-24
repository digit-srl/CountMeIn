import 'package:countmein/src/auth/application/reset_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../my_logger.dart';

final resetPasswordProvider = StateNotifierProvider.family<
    ResetPasswordNotifier, ResetPasswordState, String>((ref, oobCode) {
  return ResetPasswordNotifier(oobCode);
});

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final String oobCode;

  ResetPasswordNotifier(this.oobCode) : super(const ResetPasswordLoading()) {
    _init();
  }

  /// - **expired-action-code**:
  ///  - Thrown if the password reset code has expired.
  /// - **invalid-action-code**:
  ///  - Thrown if the password reset code is invalid. This can happen if the
  ///    code is malformed or has already been used.
  /// - **user-disabled**:
  ///  - Thrown if the user corresponding to the given email has been disabled.
  /// - **user-not-found**:
  ///  - Thrown if there is no user corresponding to the password reset code.
  ///    This may have happened if the user was deleted between when the code
  ///    was issued and when this method was called.
  _init() async {
    try {
      final email =
          await FirebaseAuth.instance.verifyPasswordResetCode(oobCode);
      logger.i('email per il reset: $email');
      state = const ResetPasswordData();
    } on FirebaseAuthException catch (ex) {
      handleFirebaseEx(ex);
    } catch (ex, st) {
      state = ResetPasswordError(ex, st);
    }
  }

  /// - **expired-action-code**:
  ///  - Thrown if the action code has expired.
  /// - **invalid-action-code**:
  ///  - Thrown if the action code is invalid. This can happen if the code is
  ///    malformed or has already been used.
  /// - **user-disabled**:
  ///  - Thrown if the user corresponding to the given action code has been
  ///    disabled.
  /// - **user-not-found**:
  ///  - Thrown if there is no user corresponding to the action code. This may
  ///    have happened if the user was deleted between when the action code was
  ///    issued and when this method was called.
  /// - **weak-password**:
  ///  - Thrown if the new password is not strong enough.
  confirmNewPassword(String newPassword) async {
    try {
      logger.i(oobCode);
      await FirebaseAuth.instance
          .confirmPasswordReset(code: oobCode, newPassword: newPassword);
      state = const ResetPasswordComplete();
    } on FirebaseAuthException catch (ex) {
      handleFirebaseEx(ex);
    }
  }

  void handleFirebaseEx(FirebaseAuthException ex) {
    switch (ex.code) {
      case 'expired-action-code':
        state = const ResetPasswordFirebaseException(
            const ResetPasswordExExpired());
        break;
      case 'invalid-action-code':
        state = const ResetPasswordFirebaseException(
            const ResetPasswordExInvalidCode());
        break;
      case 'user-disabled':
        state = const ResetPasswordFirebaseException(
            const ResetPasswordExUserNotFound());
        break;
      case 'user-not-found':
        state = const ResetPasswordFirebaseException(
            const ResetPasswordExUserNotFound());
        break;
      case 'weak-password':
        state = const ResetPasswordState.weakPassword();
        break;
      default:
        state = const ResetPasswordFirebaseException(
            const ResetPasswordExUnknown());
    }
  }
}
