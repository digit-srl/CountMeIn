// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_ids.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserIds {
  String get providerId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserIdsCopyWith<UserIds> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserIdsCopyWith<$Res> {
  factory $UserIdsCopyWith(UserIds value, $Res Function(UserIds) then) =
      _$UserIdsCopyWithImpl<$Res>;
  $Res call({String providerId, String userId});
}

/// @nodoc
class _$UserIdsCopyWithImpl<$Res> implements $UserIdsCopyWith<$Res> {
  _$UserIdsCopyWithImpl(this._value, this._then);

  final UserIds _value;
  // ignore: unused_field
  final $Res Function(UserIds) _then;

  @override
  $Res call({
    Object? providerId = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      providerId: providerId == freezed
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserIdsCopyWith<$Res> implements $UserIdsCopyWith<$Res> {
  factory _$$_UserIdsCopyWith(
          _$_UserIds value, $Res Function(_$_UserIds) then) =
      __$$_UserIdsCopyWithImpl<$Res>;
  @override
  $Res call({String providerId, String userId});
}

/// @nodoc
class __$$_UserIdsCopyWithImpl<$Res> extends _$UserIdsCopyWithImpl<$Res>
    implements _$$_UserIdsCopyWith<$Res> {
  __$$_UserIdsCopyWithImpl(_$_UserIds _value, $Res Function(_$_UserIds) _then)
      : super(_value, (v) => _then(v as _$_UserIds));

  @override
  _$_UserIds get _value => super._value as _$_UserIds;

  @override
  $Res call({
    Object? providerId = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$_UserIds(
      providerId: providerId == freezed
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserIds implements _UserIds {
  const _$_UserIds({required this.providerId, required this.userId});

  @override
  final String providerId;
  @override
  final String userId;

  @override
  String toString() {
    return 'UserIds(providerId: $providerId, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserIds &&
            const DeepCollectionEquality()
                .equals(other.providerId, providerId) &&
            const DeepCollectionEquality().equals(other.userId, userId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(providerId),
      const DeepCollectionEquality().hash(userId));

  @JsonKey(ignore: true)
  @override
  _$$_UserIdsCopyWith<_$_UserIds> get copyWith =>
      __$$_UserIdsCopyWithImpl<_$_UserIds>(this, _$identity);
}

abstract class _UserIds implements UserIds {
  const factory _UserIds(
      {required final String providerId,
      required final String userId}) = _$_UserIds;

  @override
  String get providerId;
  @override
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$_UserIdsCopyWith<_$_UserIds> get copyWith =>
      throw _privateConstructorUsedError;
}
