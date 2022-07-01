// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_registering_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserRegisteringState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool newUser, String email) verificationEmailSent,
    required TResult Function(String email) userCardSentByEmail,
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRegisteringInitial value) initial,
    required TResult Function(UserRegisteringVerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(UserRegisteringUserCardSentByEmail value)
        userCardSentByEmail,
    required TResult Function(UserRegisteringLoading value) loading,
    required TResult Function(UserRegisteringError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRegisteringStateCopyWith<$Res> {
  factory $UserRegisteringStateCopyWith(UserRegisteringState value,
          $Res Function(UserRegisteringState) then) =
      _$UserRegisteringStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserRegisteringStateCopyWithImpl<$Res>
    implements $UserRegisteringStateCopyWith<$Res> {
  _$UserRegisteringStateCopyWithImpl(this._value, this._then);

  final UserRegisteringState _value;
  // ignore: unused_field
  final $Res Function(UserRegisteringState) _then;
}

/// @nodoc
abstract class _$$UserRegisteringInitialCopyWith<$Res> {
  factory _$$UserRegisteringInitialCopyWith(_$UserRegisteringInitial value,
          $Res Function(_$UserRegisteringInitial) then) =
      __$$UserRegisteringInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserRegisteringInitialCopyWithImpl<$Res>
    extends _$UserRegisteringStateCopyWithImpl<$Res>
    implements _$$UserRegisteringInitialCopyWith<$Res> {
  __$$UserRegisteringInitialCopyWithImpl(_$UserRegisteringInitial _value,
      $Res Function(_$UserRegisteringInitial) _then)
      : super(_value, (v) => _then(v as _$UserRegisteringInitial));

  @override
  _$UserRegisteringInitial get _value =>
      super._value as _$UserRegisteringInitial;
}

/// @nodoc

class _$UserRegisteringInitial implements UserRegisteringInitial {
  const _$UserRegisteringInitial();

  @override
  String toString() {
    return 'UserRegisteringState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserRegisteringInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool newUser, String email) verificationEmailSent,
    required TResult Function(String email) userCardSentByEmail,
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRegisteringInitial value) initial,
    required TResult Function(UserRegisteringVerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(UserRegisteringUserCardSentByEmail value)
        userCardSentByEmail,
    required TResult Function(UserRegisteringLoading value) loading,
    required TResult Function(UserRegisteringError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class UserRegisteringInitial implements UserRegisteringState {
  const factory UserRegisteringInitial() = _$UserRegisteringInitial;
}

/// @nodoc
abstract class _$$UserRegisteringVerificationEmailSentCopyWith<$Res> {
  factory _$$UserRegisteringVerificationEmailSentCopyWith(
          _$UserRegisteringVerificationEmailSent value,
          $Res Function(_$UserRegisteringVerificationEmailSent) then) =
      __$$UserRegisteringVerificationEmailSentCopyWithImpl<$Res>;
  $Res call({bool newUser, String email});
}

/// @nodoc
class __$$UserRegisteringVerificationEmailSentCopyWithImpl<$Res>
    extends _$UserRegisteringStateCopyWithImpl<$Res>
    implements _$$UserRegisteringVerificationEmailSentCopyWith<$Res> {
  __$$UserRegisteringVerificationEmailSentCopyWithImpl(
      _$UserRegisteringVerificationEmailSent _value,
      $Res Function(_$UserRegisteringVerificationEmailSent) _then)
      : super(
            _value, (v) => _then(v as _$UserRegisteringVerificationEmailSent));

  @override
  _$UserRegisteringVerificationEmailSent get _value =>
      super._value as _$UserRegisteringVerificationEmailSent;

  @override
  $Res call({
    Object? newUser = freezed,
    Object? email = freezed,
  }) {
    return _then(_$UserRegisteringVerificationEmailSent(
      newUser: newUser == freezed
          ? _value.newUser
          : newUser // ignore: cast_nullable_to_non_nullable
              as bool,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserRegisteringVerificationEmailSent
    implements UserRegisteringVerificationEmailSent {
  const _$UserRegisteringVerificationEmailSent(
      {this.newUser = false, required this.email});

  @override
  @JsonKey()
  final bool newUser;
  @override
  final String email;

  @override
  String toString() {
    return 'UserRegisteringState.verificationEmailSent(newUser: $newUser, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRegisteringVerificationEmailSent &&
            const DeepCollectionEquality().equals(other.newUser, newUser) &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(newUser),
      const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  _$$UserRegisteringVerificationEmailSentCopyWith<
          _$UserRegisteringVerificationEmailSent>
      get copyWith => __$$UserRegisteringVerificationEmailSentCopyWithImpl<
          _$UserRegisteringVerificationEmailSent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool newUser, String email) verificationEmailSent,
    required TResult Function(String email) userCardSentByEmail,
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return verificationEmailSent(newUser, email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) {
    return verificationEmailSent?.call(newUser, email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (verificationEmailSent != null) {
      return verificationEmailSent(newUser, email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRegisteringInitial value) initial,
    required TResult Function(UserRegisteringVerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(UserRegisteringUserCardSentByEmail value)
        userCardSentByEmail,
    required TResult Function(UserRegisteringLoading value) loading,
    required TResult Function(UserRegisteringError value) error,
  }) {
    return verificationEmailSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
  }) {
    return verificationEmailSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
    required TResult orElse(),
  }) {
    if (verificationEmailSent != null) {
      return verificationEmailSent(this);
    }
    return orElse();
  }
}

abstract class UserRegisteringVerificationEmailSent
    implements UserRegisteringState {
  const factory UserRegisteringVerificationEmailSent(
      {final bool newUser,
      required final String email}) = _$UserRegisteringVerificationEmailSent;

  bool get newUser => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$UserRegisteringVerificationEmailSentCopyWith<
          _$UserRegisteringVerificationEmailSent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserRegisteringUserCardSentByEmailCopyWith<$Res> {
  factory _$$UserRegisteringUserCardSentByEmailCopyWith(
          _$UserRegisteringUserCardSentByEmail value,
          $Res Function(_$UserRegisteringUserCardSentByEmail) then) =
      __$$UserRegisteringUserCardSentByEmailCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class __$$UserRegisteringUserCardSentByEmailCopyWithImpl<$Res>
    extends _$UserRegisteringStateCopyWithImpl<$Res>
    implements _$$UserRegisteringUserCardSentByEmailCopyWith<$Res> {
  __$$UserRegisteringUserCardSentByEmailCopyWithImpl(
      _$UserRegisteringUserCardSentByEmail _value,
      $Res Function(_$UserRegisteringUserCardSentByEmail) _then)
      : super(_value, (v) => _then(v as _$UserRegisteringUserCardSentByEmail));

  @override
  _$UserRegisteringUserCardSentByEmail get _value =>
      super._value as _$UserRegisteringUserCardSentByEmail;

  @override
  $Res call({
    Object? email = freezed,
  }) {
    return _then(_$UserRegisteringUserCardSentByEmail(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserRegisteringUserCardSentByEmail
    implements UserRegisteringUserCardSentByEmail {
  const _$UserRegisteringUserCardSentByEmail({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'UserRegisteringState.userCardSentByEmail(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRegisteringUserCardSentByEmail &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  _$$UserRegisteringUserCardSentByEmailCopyWith<
          _$UserRegisteringUserCardSentByEmail>
      get copyWith => __$$UserRegisteringUserCardSentByEmailCopyWithImpl<
          _$UserRegisteringUserCardSentByEmail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool newUser, String email) verificationEmailSent,
    required TResult Function(String email) userCardSentByEmail,
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return userCardSentByEmail(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) {
    return userCardSentByEmail?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (userCardSentByEmail != null) {
      return userCardSentByEmail(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRegisteringInitial value) initial,
    required TResult Function(UserRegisteringVerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(UserRegisteringUserCardSentByEmail value)
        userCardSentByEmail,
    required TResult Function(UserRegisteringLoading value) loading,
    required TResult Function(UserRegisteringError value) error,
  }) {
    return userCardSentByEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
  }) {
    return userCardSentByEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
    required TResult orElse(),
  }) {
    if (userCardSentByEmail != null) {
      return userCardSentByEmail(this);
    }
    return orElse();
  }
}

abstract class UserRegisteringUserCardSentByEmail
    implements UserRegisteringState {
  const factory UserRegisteringUserCardSentByEmail(
      {required final String email}) = _$UserRegisteringUserCardSentByEmail;

  String get email => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$UserRegisteringUserCardSentByEmailCopyWith<
          _$UserRegisteringUserCardSentByEmail>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserRegisteringLoadingCopyWith<$Res> {
  factory _$$UserRegisteringLoadingCopyWith(_$UserRegisteringLoading value,
          $Res Function(_$UserRegisteringLoading) then) =
      __$$UserRegisteringLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserRegisteringLoadingCopyWithImpl<$Res>
    extends _$UserRegisteringStateCopyWithImpl<$Res>
    implements _$$UserRegisteringLoadingCopyWith<$Res> {
  __$$UserRegisteringLoadingCopyWithImpl(_$UserRegisteringLoading _value,
      $Res Function(_$UserRegisteringLoading) _then)
      : super(_value, (v) => _then(v as _$UserRegisteringLoading));

  @override
  _$UserRegisteringLoading get _value =>
      super._value as _$UserRegisteringLoading;
}

/// @nodoc

class _$UserRegisteringLoading implements UserRegisteringLoading {
  const _$UserRegisteringLoading();

  @override
  String toString() {
    return 'UserRegisteringState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserRegisteringLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool newUser, String email) verificationEmailSent,
    required TResult Function(String email) userCardSentByEmail,
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
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
    required TResult Function(UserRegisteringInitial value) initial,
    required TResult Function(UserRegisteringVerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(UserRegisteringUserCardSentByEmail value)
        userCardSentByEmail,
    required TResult Function(UserRegisteringLoading value) loading,
    required TResult Function(UserRegisteringError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UserRegisteringLoading implements UserRegisteringState {
  const factory UserRegisteringLoading() = _$UserRegisteringLoading;
}

/// @nodoc
abstract class _$$UserRegisteringErrorCopyWith<$Res> {
  factory _$$UserRegisteringErrorCopyWith(_$UserRegisteringError value,
          $Res Function(_$UserRegisteringError) then) =
      __$$UserRegisteringErrorCopyWithImpl<$Res>;
  $Res call({Object error, StackTrace st});
}

/// @nodoc
class __$$UserRegisteringErrorCopyWithImpl<$Res>
    extends _$UserRegisteringStateCopyWithImpl<$Res>
    implements _$$UserRegisteringErrorCopyWith<$Res> {
  __$$UserRegisteringErrorCopyWithImpl(_$UserRegisteringError _value,
      $Res Function(_$UserRegisteringError) _then)
      : super(_value, (v) => _then(v as _$UserRegisteringError));

  @override
  _$UserRegisteringError get _value => super._value as _$UserRegisteringError;

  @override
  $Res call({
    Object? error = freezed,
    Object? st = freezed,
  }) {
    return _then(_$UserRegisteringError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Object,
      st == freezed
          ? _value.st
          : st // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$UserRegisteringError implements UserRegisteringError {
  const _$UserRegisteringError(this.error, this.st);

  @override
  final Object error;
  @override
  final StackTrace st;

  @override
  String toString() {
    return 'UserRegisteringState.error(error: $error, st: $st)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRegisteringError &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.st, st));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(st));

  @JsonKey(ignore: true)
  @override
  _$$UserRegisteringErrorCopyWith<_$UserRegisteringError> get copyWith =>
      __$$UserRegisteringErrorCopyWithImpl<_$UserRegisteringError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool newUser, String email) verificationEmailSent,
    required TResult Function(String email) userCardSentByEmail,
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return error(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) {
    return error?.call(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool newUser, String email)? verificationEmailSent,
    TResult Function(String email)? userCardSentByEmail,
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, st);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserRegisteringInitial value) initial,
    required TResult Function(UserRegisteringVerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(UserRegisteringUserCardSentByEmail value)
        userCardSentByEmail,
    required TResult Function(UserRegisteringLoading value) loading,
    required TResult Function(UserRegisteringError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserRegisteringInitial value)? initial,
    TResult Function(UserRegisteringVerificationEmailSent value)?
        verificationEmailSent,
    TResult Function(UserRegisteringUserCardSentByEmail value)?
        userCardSentByEmail,
    TResult Function(UserRegisteringLoading value)? loading,
    TResult Function(UserRegisteringError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UserRegisteringError implements UserRegisteringState {
  const factory UserRegisteringError(final Object error, final StackTrace st) =
      _$UserRegisteringError;

  Object get error => throw _privateConstructorUsedError;
  StackTrace get st => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$UserRegisteringErrorCopyWith<_$UserRegisteringError> get copyWith =>
      throw _privateConstructorUsedError;
}
