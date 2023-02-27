import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_registering_state.freezed.dart';

@freezed
class UserRegisteringState with _$UserRegisteringState {
  const factory UserRegisteringState.initial() = UserRegisteringInitial;
  const factory UserRegisteringState.verificationEmailSent({@Default(false) bool newUser, required String email}) = UserRegisteringVerificationEmailSent;
  const factory UserRegisteringState.userAlreadySubscribed({required String email, required String cf, required String userId, required String providerId}) = UserRegisteringUserAlreadySubscribed;
  const factory UserRegisteringState.loading() = UserRegisteringLoading;
  const factory UserRegisteringState.invalidFiscalCode() = UserRegisteringInvalidFiscalCode;
  const factory UserRegisteringState.error(Object error, StackTrace st) = UserRegisteringError;
}