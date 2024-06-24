import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/src/auth/application/reset_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:countmein/my_logger.dart';

part 'reset_password_notifier.freezed.dart';

@freezed
class ResetPasswordRequest with _$ResetPasswordRequest {
  factory ResetPasswordRequest({
    required String oobCode,
    required String userId,
    required String fullName,
  }) = _ResetPasswordRequest;
}

final resetPasswordProvider = StateNotifierProvider.family<
    ResetPasswordNotifier,
    ResetPasswordState,
    ResetPasswordRequest>((ref, oobCode) {
  return ResetPasswordNotifier(oobCode);
});

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final ResetPasswordRequest resetPasswordRequest;

  ResetPasswordNotifier(this.resetPasswordRequest)
      : super(const ResetPasswordLoading()) {
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
      logger.i(resetPasswordRequest.toString());
      final email = await FirebaseAuth.instance
          .verifyPasswordResetCode(resetPasswordRequest.oobCode);
      logger.i('email per il reset: $email');
      state = const ResetPasswordData();
    } on FirebaseAuthException catch (ex) {
      handleFirebaseEx(ex);
    } catch (ex, st) {
      logger.e(ex);
      logger.e(st);
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
      logger.i(resetPasswordRequest.oobCode);
      await FirebaseAuth.instance.confirmPasswordReset(
          code: resetPasswordRequest.oobCode, newPassword: newPassword,);
      FirebaseFirestore.instance
          .collection('/credentials')
          .doc(resetPasswordRequest.userId)
          .update({
        'temporaryPassword': false,
      });
      state = const ResetPasswordComplete();
    } on FirebaseAuthException catch (ex) {
      handleFirebaseEx(ex);
    }catch (ex, st) {
      logger.e(ex);
      logger.e(st);
      state = ResetPasswordError(ex, st);
    }
  }

  void handleFirebaseEx(FirebaseAuthException ex) {
    logger.e(ex);
    logger.e(ex.code);
    switch (ex.code) {
      case 'expired-action-code':
        state = const ResetPasswordFirebaseException(ResetPasswordExExpired());
        break;
      case 'invalid-action-code':
        state =
            const ResetPasswordFirebaseException(ResetPasswordExInvalidCode());
        break;
      case 'user-disabled':
        state =
            const ResetPasswordFirebaseException(ResetPasswordExUserNotFound());
        break;
      case 'user-not-found':
        state =
            const ResetPasswordFirebaseException(ResetPasswordExUserNotFound());
        break;
      case 'weak-password':
        state = const ResetPasswordState.weakPassword();
        break;
      default:
        state = const ResetPasswordFirebaseException(ResetPasswordExUnknown());
    }
  }
}
