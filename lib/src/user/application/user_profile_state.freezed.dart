// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) data,
    required TResult Function() wrongCode,
    required TResult Function() waitingOtpCode,
    required TResult Function() loading,
    required TResult Function(Object? error, StackTrace? st) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileInitial value) initial,
    required TResult Function(UserProfileData value) data,
    required TResult Function(UserProfileWrongCode value) wrongCode,
    required TResult Function(UserProfileWaitingOtpCode value) waitingOtpCode,
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileStateCopyWith<$Res> {
  factory $UserProfileStateCopyWith(
          UserProfileState value, $Res Function(UserProfileState) then) =
      _$UserProfileStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._value, this._then);

  final UserProfileState _value;
  // ignore: unused_field
  final $Res Function(UserProfileState) _then;
}

/// @nodoc
abstract class _$$UserProfileInitialCopyWith<$Res> {
  factory _$$UserProfileInitialCopyWith(_$UserProfileInitial value,
          $Res Function(_$UserProfileInitial) then) =
      __$$UserProfileInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserProfileInitialCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$UserProfileInitialCopyWith<$Res> {
  __$$UserProfileInitialCopyWithImpl(
      _$UserProfileInitial _value, $Res Function(_$UserProfileInitial) _then)
      : super(_value, (v) => _then(v as _$UserProfileInitial));

  @override
  _$UserProfileInitial get _value => super._value as _$UserProfileInitial;
}

/// @nodoc

class _$UserProfileInitial implements UserProfileInitial {
  const _$UserProfileInitial();

  @override
  String toString() {
    return 'UserProfileState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserProfileInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) data,
    required TResult Function() wrongCode,
    required TResult Function() waitingOtpCode,
    required TResult Function() loading,
    required TResult Function(Object? error, StackTrace? st) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
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
    required TResult Function(UserProfileInitial value) initial,
    required TResult Function(UserProfileData value) data,
    required TResult Function(UserProfileWrongCode value) wrongCode,
    required TResult Function(UserProfileWaitingOtpCode value) waitingOtpCode,
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class UserProfileInitial implements UserProfileState {
  const factory UserProfileInitial() = _$UserProfileInitial;
}

/// @nodoc
abstract class _$$UserProfileDataCopyWith<$Res> {
  factory _$$UserProfileDataCopyWith(
          _$UserProfileData value, $Res Function(_$UserProfileData) then) =
      __$$UserProfileDataCopyWithImpl<$Res>;
  $Res call({String userId});
}

/// @nodoc
class __$$UserProfileDataCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$UserProfileDataCopyWith<$Res> {
  __$$UserProfileDataCopyWithImpl(
      _$UserProfileData _value, $Res Function(_$UserProfileData) _then)
      : super(_value, (v) => _then(v as _$UserProfileData));

  @override
  _$UserProfileData get _value => super._value as _$UserProfileData;

  @override
  $Res call({
    Object? userId = freezed,
  }) {
    return _then(_$UserProfileData(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserProfileData implements UserProfileData {
  const _$UserProfileData(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'UserProfileState.data(userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileData &&
            const DeepCollectionEquality().equals(other.userId, userId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(userId));

  @JsonKey(ignore: true)
  @override
  _$$UserProfileDataCopyWith<_$UserProfileData> get copyWith =>
      __$$UserProfileDataCopyWithImpl<_$UserProfileData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) data,
    required TResult Function() wrongCode,
    required TResult Function() waitingOtpCode,
    required TResult Function() loading,
    required TResult Function(Object? error, StackTrace? st) error,
  }) {
    return data(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
  }) {
    return data?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileInitial value) initial,
    required TResult Function(UserProfileData value) data,
    required TResult Function(UserProfileWrongCode value) wrongCode,
    required TResult Function(UserProfileWaitingOtpCode value) waitingOtpCode,
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class UserProfileData implements UserProfileState {
  const factory UserProfileData(final String userId) = _$UserProfileData;

  String get userId;
  @JsonKey(ignore: true)
  _$$UserProfileDataCopyWith<_$UserProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserProfileWrongCodeCopyWith<$Res> {
  factory _$$UserProfileWrongCodeCopyWith(_$UserProfileWrongCode value,
          $Res Function(_$UserProfileWrongCode) then) =
      __$$UserProfileWrongCodeCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserProfileWrongCodeCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$UserProfileWrongCodeCopyWith<$Res> {
  __$$UserProfileWrongCodeCopyWithImpl(_$UserProfileWrongCode _value,
      $Res Function(_$UserProfileWrongCode) _then)
      : super(_value, (v) => _then(v as _$UserProfileWrongCode));

  @override
  _$UserProfileWrongCode get _value => super._value as _$UserProfileWrongCode;
}

/// @nodoc

class _$UserProfileWrongCode implements UserProfileWrongCode {
  const _$UserProfileWrongCode();

  @override
  String toString() {
    return 'UserProfileState.wrongCode()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserProfileWrongCode);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) data,
    required TResult Function() wrongCode,
    required TResult Function() waitingOtpCode,
    required TResult Function() loading,
    required TResult Function(Object? error, StackTrace? st) error,
  }) {
    return wrongCode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
  }) {
    return wrongCode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
    required TResult orElse(),
  }) {
    if (wrongCode != null) {
      return wrongCode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileInitial value) initial,
    required TResult Function(UserProfileData value) data,
    required TResult Function(UserProfileWrongCode value) wrongCode,
    required TResult Function(UserProfileWaitingOtpCode value) waitingOtpCode,
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return wrongCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return wrongCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
    required TResult orElse(),
  }) {
    if (wrongCode != null) {
      return wrongCode(this);
    }
    return orElse();
  }
}

abstract class UserProfileWrongCode implements UserProfileState {
  const factory UserProfileWrongCode() = _$UserProfileWrongCode;
}

/// @nodoc
abstract class _$$UserProfileWaitingOtpCodeCopyWith<$Res> {
  factory _$$UserProfileWaitingOtpCodeCopyWith(
          _$UserProfileWaitingOtpCode value,
          $Res Function(_$UserProfileWaitingOtpCode) then) =
      __$$UserProfileWaitingOtpCodeCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserProfileWaitingOtpCodeCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$UserProfileWaitingOtpCodeCopyWith<$Res> {
  __$$UserProfileWaitingOtpCodeCopyWithImpl(_$UserProfileWaitingOtpCode _value,
      $Res Function(_$UserProfileWaitingOtpCode) _then)
      : super(_value, (v) => _then(v as _$UserProfileWaitingOtpCode));

  @override
  _$UserProfileWaitingOtpCode get _value =>
      super._value as _$UserProfileWaitingOtpCode;
}

/// @nodoc

class _$UserProfileWaitingOtpCode implements UserProfileWaitingOtpCode {
  const _$UserProfileWaitingOtpCode();

  @override
  String toString() {
    return 'UserProfileState.waitingOtpCode()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileWaitingOtpCode);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) data,
    required TResult Function() wrongCode,
    required TResult Function() waitingOtpCode,
    required TResult Function() loading,
    required TResult Function(Object? error, StackTrace? st) error,
  }) {
    return waitingOtpCode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
  }) {
    return waitingOtpCode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
    required TResult orElse(),
  }) {
    if (waitingOtpCode != null) {
      return waitingOtpCode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileInitial value) initial,
    required TResult Function(UserProfileData value) data,
    required TResult Function(UserProfileWrongCode value) wrongCode,
    required TResult Function(UserProfileWaitingOtpCode value) waitingOtpCode,
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return waitingOtpCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return waitingOtpCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
    required TResult orElse(),
  }) {
    if (waitingOtpCode != null) {
      return waitingOtpCode(this);
    }
    return orElse();
  }
}

abstract class UserProfileWaitingOtpCode implements UserProfileState {
  const factory UserProfileWaitingOtpCode() = _$UserProfileWaitingOtpCode;
}

/// @nodoc
abstract class _$$UserProfileLoadingCopyWith<$Res> {
  factory _$$UserProfileLoadingCopyWith(_$UserProfileLoading value,
          $Res Function(_$UserProfileLoading) then) =
      __$$UserProfileLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserProfileLoadingCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$UserProfileLoadingCopyWith<$Res> {
  __$$UserProfileLoadingCopyWithImpl(
      _$UserProfileLoading _value, $Res Function(_$UserProfileLoading) _then)
      : super(_value, (v) => _then(v as _$UserProfileLoading));

  @override
  _$UserProfileLoading get _value => super._value as _$UserProfileLoading;
}

/// @nodoc

class _$UserProfileLoading implements UserProfileLoading {
  const _$UserProfileLoading();

  @override
  String toString() {
    return 'UserProfileState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserProfileLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) data,
    required TResult Function() wrongCode,
    required TResult Function() waitingOtpCode,
    required TResult Function() loading,
    required TResult Function(Object? error, StackTrace? st) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
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
    required TResult Function(UserProfileInitial value) initial,
    required TResult Function(UserProfileData value) data,
    required TResult Function(UserProfileWrongCode value) wrongCode,
    required TResult Function(UserProfileWaitingOtpCode value) waitingOtpCode,
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UserProfileLoading implements UserProfileState {
  const factory UserProfileLoading() = _$UserProfileLoading;
}

/// @nodoc
abstract class _$$UserProfileErrorCopyWith<$Res> {
  factory _$$UserProfileErrorCopyWith(
          _$UserProfileError value, $Res Function(_$UserProfileError) then) =
      __$$UserProfileErrorCopyWithImpl<$Res>;
  $Res call({Object? error, StackTrace? st});
}

/// @nodoc
class __$$UserProfileErrorCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$UserProfileErrorCopyWith<$Res> {
  __$$UserProfileErrorCopyWithImpl(
      _$UserProfileError _value, $Res Function(_$UserProfileError) _then)
      : super(_value, (v) => _then(v as _$UserProfileError));

  @override
  _$UserProfileError get _value => super._value as _$UserProfileError;

  @override
  $Res call({
    Object? error = freezed,
    Object? st = freezed,
  }) {
    return _then(_$UserProfileError(
      error: error == freezed ? _value.error : error,
      st: st == freezed
          ? _value.st
          : st // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$UserProfileError implements UserProfileError {
  const _$UserProfileError({this.error, this.st});

  @override
  final Object? error;
  @override
  final StackTrace? st;

  @override
  String toString() {
    return 'UserProfileState.error(error: $error, st: $st)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileError &&
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
  _$$UserProfileErrorCopyWith<_$UserProfileError> get copyWith =>
      __$$UserProfileErrorCopyWithImpl<_$UserProfileError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String userId) data,
    required TResult Function() wrongCode,
    required TResult Function() waitingOtpCode,
    required TResult Function() loading,
    required TResult Function(Object? error, StackTrace? st) error,
  }) {
    return error(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
  }) {
    return error?.call(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String userId)? data,
    TResult Function()? wrongCode,
    TResult Function()? waitingOtpCode,
    TResult Function()? loading,
    TResult Function(Object? error, StackTrace? st)? error,
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
    required TResult Function(UserProfileInitial value) initial,
    required TResult Function(UserProfileData value) data,
    required TResult Function(UserProfileWrongCode value) wrongCode,
    required TResult Function(UserProfileWaitingOtpCode value) waitingOtpCode,
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileInitial value)? initial,
    TResult Function(UserProfileData value)? data,
    TResult Function(UserProfileWrongCode value)? wrongCode,
    TResult Function(UserProfileWaitingOtpCode value)? waitingOtpCode,
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UserProfileError implements UserProfileState {
  const factory UserProfileError({final Object? error, final StackTrace? st}) =
      _$UserProfileError;

  Object? get error;
  StackTrace? get st;
  @JsonKey(ignore: true)
  _$$UserProfileErrorCopyWith<_$UserProfileError> get copyWith =>
      throw _privateConstructorUsedError;
}
