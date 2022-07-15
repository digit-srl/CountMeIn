// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthFailure {
  String get description => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String description) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String description)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String description)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnknownFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthUnknownFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnknownFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthFailureCopyWith<AuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res>;
  $Res call({String description});
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res> implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  final AuthFailure _value;
  // ignore: unused_field
  final $Res Function(AuthFailure) _then;

  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$AuthUnknownFailureCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$AuthUnknownFailureCopyWith(_$AuthUnknownFailure value,
          $Res Function(_$AuthUnknownFailure) then) =
      __$$AuthUnknownFailureCopyWithImpl<$Res>;
  @override
  $Res call({String description});
}

/// @nodoc
class __$$AuthUnknownFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res>
    implements _$$AuthUnknownFailureCopyWith<$Res> {
  __$$AuthUnknownFailureCopyWithImpl(
      _$AuthUnknownFailure _value, $Res Function(_$AuthUnknownFailure) _then)
      : super(_value, (v) => _then(v as _$AuthUnknownFailure));

  @override
  _$AuthUnknownFailure get _value => super._value as _$AuthUnknownFailure;

  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_$AuthUnknownFailure(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthUnknownFailure implements AuthUnknownFailure {
  const _$AuthUnknownFailure({this.description = 'Unknown error'});

  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'AuthFailure.unknown(description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUnknownFailure &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$$AuthUnknownFailureCopyWith<_$AuthUnknownFailure> get copyWith =>
      __$$AuthUnknownFailureCopyWithImpl<_$AuthUnknownFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String description) unknown,
  }) {
    return unknown(description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String description)? unknown,
  }) {
    return unknown?.call(description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String description)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthUnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class AuthUnknownFailure implements AuthFailure {
  const factory AuthUnknownFailure({final String description}) =
      _$AuthUnknownFailure;

  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$AuthUnknownFailureCopyWith<_$AuthUnknownFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
