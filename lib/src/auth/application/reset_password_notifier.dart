import 'package:countmein/src/auth/application/reset_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    try{
      final email = await FirebaseAuth.instance.verifyPasswordResetCode(oobCode);
      print('email per il reset: $email');
    } on FirebaseAuthException catch(ex){
     handleFirebaseEx(ex);
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
      print(oobCode);
      await FirebaseAuth.instance
          .confirmPasswordReset(code: oobCode, newPassword: newPassword);
    } on FirebaseAuthException catch(ex){
      handleFirebaseEx(ex);
    }
  }

  void handleFirebaseEx(FirebaseAuthException ex) {
    switch(ex.code){
      case 'expired-action-code':
        state = ResetPasswordFirebaseException(ResetPasswordExUnknown());
        break;
      case 'invalid-action-code':
        state = ResetPasswordFirebaseException(ResetPasswordExUnknown());
        break;
      case 'user-disabled':
        state = ResetPasswordFirebaseException(ResetPasswordExUnknown());
        break;
      case 'user-not-found':
        state = ResetPasswordFirebaseException(ResetPasswordExUnknown());
        break;
      case 'weak-password':
        state = ResetPasswordState.weakPassword();
        break;
      default:
        state = ResetPasswordFirebaseException(ResetPasswordExUnknown());
    }
  }
}
