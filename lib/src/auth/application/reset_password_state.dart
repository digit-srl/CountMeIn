import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.data() = ResetPasswordData;
  const factory ResetPasswordState.complete() = ResetPasswordComplete;

  const factory ResetPasswordState.firebaseException(
      ResetPasswordException exception,) = ResetPasswordFirebaseException;

  const factory ResetPasswordState.weakPassword() = ResetPasswordWeakPassword;
  const factory ResetPasswordState.loading() = ResetPasswordLoading;

  const factory ResetPasswordState.error(Object error, StackTrace st) =
      ResetPasswordError;
}

@freezed
class ResetPasswordException with _$ResetPasswordException {
  const factory ResetPasswordException.unknown() = ResetPasswordExUnknown;

  const factory ResetPasswordException.expired() = ResetPasswordExExpired;

  const factory ResetPasswordException.userDisabled() = ResetPasswordExDisabled;

  const factory ResetPasswordException.userNotFound() =
      ResetPasswordExUserNotFound;

  const factory ResetPasswordException.invalidCode() =
      ResetPasswordExInvalidCode;
}

extension ResetPasswordExceptionX on ResetPasswordException {
  String get message {
    return when(
      unknown: () => 'Errore sconosciuto',
      expired: () => 'expired',
      userDisabled: () => 'userDisabled',
      userNotFound: () => 'userNotFound',
      invalidCode: () => 'Invalid OTP code',
    );
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
///    code is malformed or has already been used.
