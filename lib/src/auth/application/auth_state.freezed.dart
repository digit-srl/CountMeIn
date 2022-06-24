// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthUser user) authenticated,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(User user) emailNotVerified,
    required TResult Function(Object err, StackTrace? stack) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Unautenticated value) unauthenticated,
    required TResult Function(EmailNotVerified value) emailNotVerified,
    required TResult Function(AuthError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class _$$AuthenticatedCopyWith<$Res> {
  factory _$$AuthenticatedCopyWith(
          _$Authenticated value, $Res Function(_$Authenticated) then) =
      __$$AuthenticatedCopyWithImpl<$Res>;
  $Res call({AuthUser user});

  $AuthUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthenticatedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$AuthenticatedCopyWith<$Res> {
  __$$AuthenticatedCopyWithImpl(
      _$Authenticated _value, $Res Function(_$Authenticated) _then)
      : super(_value, (v) => _then(v as _$Authenticated));

  @override
  _$Authenticated get _value => super._value as _$Authenticated;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$Authenticated(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuthUser,
    ));
  }

  @override
  $AuthUserCopyWith<$Res> get user {
    return $AuthUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$Authenticated implements Authenticated {
  const _$Authenticated(this.user);

  @override
  final AuthUser user;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Authenticated &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$AuthenticatedCopyWith<_$Authenticated> get copyWith =>
      __$$AuthenticatedCopyWithImpl<_$Authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthUser user) authenticated,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(User user) emailNotVerified,
    required TResult Function(Object err, StackTrace? stack) error,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Unautenticated value) unauthenticated,
    required TResult Function(EmailNotVerified value) emailNotVerified,
    required TResult Function(AuthError value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class Authenticated implements AuthState {
  const factory Authenticated(final AuthUser user) = _$Authenticated;

  AuthUser get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$AuthenticatedCopyWith<_$Authenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthLoadingCopyWith<$Res> {
  factory _$$AuthLoadingCopyWith(
          _$AuthLoading value, $Res Function(_$AuthLoading) then) =
      __$$AuthLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLoadingCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$AuthLoadingCopyWith<$Res> {
  __$$AuthLoadingCopyWithImpl(
      _$AuthLoading _value, $Res Function(_$AuthLoading) _then)
      : super(_value, (v) => _then(v as _$AuthLoading));

  @override
  _$AuthLoading get _value => super._value as _$AuthLoading;
}

/// @nodoc

class _$AuthLoading implements AuthLoading {
  const _$AuthLoading();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthUser user) authenticated,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(User user) emailNotVerified,
    required TResult Function(Object err, StackTrace? stack) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Unautenticated value) unauthenticated,
    required TResult Function(EmailNotVerified value) emailNotVerified,
    required TResult Function(AuthError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading() = _$AuthLoading;
}

/// @nodoc
abstract class _$$UnautenticatedCopyWith<$Res> {
  factory _$$UnautenticatedCopyWith(
          _$Unautenticated value, $Res Function(_$Unautenticated) then) =
      __$$UnautenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnautenticatedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$UnautenticatedCopyWith<$Res> {
  __$$UnautenticatedCopyWithImpl(
      _$Unautenticated _value, $Res Function(_$Unautenticated) _then)
      : super(_value, (v) => _then(v as _$Unautenticated));

  @override
  _$Unautenticated get _value => super._value as _$Unautenticated;
}

/// @nodoc

class _$Unautenticated implements Unautenticated {
  const _$Unautenticated();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Unautenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthUser user) authenticated,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(User user) emailNotVerified,
    required TResult Function(Object err, StackTrace? stack) error,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Unautenticated value) unauthenticated,
    required TResult Function(EmailNotVerified value) emailNotVerified,
    required TResult Function(AuthError value) error,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class Unautenticated implements AuthState {
  const factory Unautenticated() = _$Unautenticated;
}

/// @nodoc
abstract class _$$EmailNotVerifiedCopyWith<$Res> {
  factory _$$EmailNotVerifiedCopyWith(
          _$EmailNotVerified value, $Res Function(_$EmailNotVerified) then) =
      __$$EmailNotVerifiedCopyWithImpl<$Res>;
  $Res call({User user});
}

/// @nodoc
class __$$EmailNotVerifiedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$$EmailNotVerifiedCopyWith<$Res> {
  __$$EmailNotVerifiedCopyWithImpl(
      _$EmailNotVerified _value, $Res Function(_$EmailNotVerified) _then)
      : super(_value, (v) => _then(v as _$EmailNotVerified));

  @override
  _$EmailNotVerified get _value => super._value as _$EmailNotVerified;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$EmailNotVerified(
      user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$EmailNotVerified implements EmailNotVerified {
  const _$EmailNotVerified(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.emailNotVerified(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailNotVerified &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$EmailNotVerifiedCopyWith<_$EmailNotVerified> get copyWith =>
      __$$EmailNotVerifiedCopyWithImpl<_$EmailNotVerified>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthUser user) authenticated,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(User user) emailNotVerified,
    required TResult Function(Object err, StackTrace? stack) error,
  }) {
    return emailNotVerified(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
  }) {
    return emailNotVerified?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
    required TResult orElse(),
  }) {
    if (emailNotVerified != null) {
      return emailNotVerified(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Unautenticated value) unauthenticated,
    required TResult Function(EmailNotVerified value) emailNotVerified,
    required TResult Function(AuthError value) error,
  }) {
    return emailNotVerified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
  }) {
    return emailNotVerified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (emailNotVerified != null) {
      return emailNotVerified(this);
    }
    return orElse();
  }
}

abstract class EmailNotVerified implements AuthState {
  const factory EmailNotVerified(final User user) = _$EmailNotVerified;

  User get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$EmailNotVerifiedCopyWith<_$EmailNotVerified> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorCopyWith<$Res> {
  factory _$$AuthErrorCopyWith(
          _$AuthError value, $Res Function(_$AuthError) then) =
      __$$AuthErrorCopyWithImpl<$Res>;
  $Res call({Object err, StackTrace? stack});
}

/// @nodoc
class __$$AuthErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$AuthErrorCopyWith<$Res> {
  __$$AuthErrorCopyWithImpl(
      _$AuthError _value, $Res Function(_$AuthError) _then)
      : super(_value, (v) => _then(v as _$AuthError));

  @override
  _$AuthError get _value => super._value as _$AuthError;

  @override
  $Res call({
    Object? err = freezed,
    Object? stack = freezed,
  }) {
    return _then(_$AuthError(
      err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Object,
      stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$AuthError implements AuthError {
  const _$AuthError(this.err, this.stack);

  @override
  final Object err;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'AuthState.error(err: $err, stack: $stack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthError &&
            const DeepCollectionEquality().equals(other.err, err) &&
            const DeepCollectionEquality().equals(other.stack, stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(err),
      const DeepCollectionEquality().hash(stack));

  @JsonKey(ignore: true)
  @override
  _$$AuthErrorCopyWith<_$AuthError> get copyWith =>
      __$$AuthErrorCopyWithImpl<_$AuthError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthUser user) authenticated,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(User user) emailNotVerified,
    required TResult Function(Object err, StackTrace? stack) error,
  }) {
    return error(err, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
  }) {
    return error?.call(err, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthUser user)? authenticated,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(User user)? emailNotVerified,
    TResult Function(Object err, StackTrace? stack)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(err, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Unautenticated value) unauthenticated,
    required TResult Function(EmailNotVerified value) emailNotVerified,
    required TResult Function(AuthError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Unautenticated value)? unauthenticated,
    TResult Function(EmailNotVerified value)? emailNotVerified,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError(final Object err, final StackTrace? stack) =
      _$AuthError;

  Object get err => throw _privateConstructorUsedError;
  StackTrace? get stack => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$AuthErrorCopyWith<_$AuthError> get copyWith =>
      throw _privateConstructorUsedError;
}
