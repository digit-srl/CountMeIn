import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_state.freezed.dart';

@freezed
class EmailVerificationState with _$EmailVerificationState {
  const factory EmailVerificationState.verified() = EmailVerificationVerified;
  const factory EmailVerificationState.userNotExist() = EmailVerificationUserNotExist;
  const factory EmailVerificationState.invalidData() = EmailVerificationInvalidData;
  const factory EmailVerificationState.loading() = EmailVerificationLoading;
  const factory EmailVerificationState.error(Object error, StackTrace st) = EmailVerificationError;
}

@freezed
class EmailVerificationData with _$EmailVerificationData {
  const factory EmailVerificationData({
    required String secret,
    required String userId,
  }) = _EmailVerificationData;
}