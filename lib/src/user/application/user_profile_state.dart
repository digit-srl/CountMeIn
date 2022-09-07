import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = UserProfileInitial;
  const factory UserProfileState.data(String userId) = UserProfileData;
  const factory UserProfileState.wrongCode() = UserProfileWrongCode;
  const factory UserProfileState.waitingOtpCode() = UserProfileWaitingOtpCode;
  const factory UserProfileState.loading() = UserProfileLoading;
  const factory UserProfileState.error({Object? error, StackTrace? st}) = UserProfileError;
}