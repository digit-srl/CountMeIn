import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.loading() = UserProfileLoading;
  const factory UserProfileState.error(Object error, StackTrace st) = UserProfileError;
}