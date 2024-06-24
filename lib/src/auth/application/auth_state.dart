import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:countmein/src/auth/domain/entities/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated(AuthUser user) = Authenticated;

  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.unauthenticated() = Unauthenticated;

  // const factory AuthState.emailNotVerified(User user) = EmailNotVerified;
  const factory AuthState.error(Object err, StackTrace? stack) = AuthError;
}
