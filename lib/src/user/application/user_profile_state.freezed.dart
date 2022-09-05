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
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
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
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
  $Res call({Object error, StackTrace st});
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

class _$UserProfileError implements UserProfileError {
  const _$UserProfileError(this.error, this.st);

  @override
  final Object error;
  @override
  final StackTrace st;

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
    required TResult Function() loading,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return error(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Object error, StackTrace st)? error,
  }) {
    return error?.call(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
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
    required TResult Function(UserProfileLoading value) loading,
    required TResult Function(UserProfileError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserProfileLoading value)? loading,
    TResult Function(UserProfileError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
  const factory UserProfileError(final Object error, final StackTrace st) =
      _$UserProfileError;

  Object get error;
  StackTrace get st;
  @JsonKey(ignore: true)
  _$$UserProfileErrorCopyWith<_$UserProfileError> get copyWith =>
      throw _privateConstructorUsedError;
}
