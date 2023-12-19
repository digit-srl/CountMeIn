// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$UserIdsCopyWithImpl<$Res, UserIds>;
  @useResult
  $Res call({String providerId, String userId});
}

/// @nodoc
class _$UserIdsCopyWithImpl<$Res, $Val extends UserIds>
    implements $UserIdsCopyWith<$Res> {
  _$UserIdsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserIdsImplCopyWith<$Res> implements $UserIdsCopyWith<$Res> {
  factory _$$UserIdsImplCopyWith(
          _$UserIdsImpl value, $Res Function(_$UserIdsImpl) then) =
      __$$UserIdsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String providerId, String userId});
}

/// @nodoc
class __$$UserIdsImplCopyWithImpl<$Res>
    extends _$UserIdsCopyWithImpl<$Res, _$UserIdsImpl>
    implements _$$UserIdsImplCopyWith<$Res> {
  __$$UserIdsImplCopyWithImpl(
      _$UserIdsImpl _value, $Res Function(_$UserIdsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? userId = null,
  }) {
    return _then(_$UserIdsImpl(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserIdsImpl implements _UserIds {
  const _$UserIdsImpl({required this.providerId, required this.userId});

  @override
  final String providerId;
  @override
  final String userId;

  @override
  String toString() {
    return 'UserIds(providerId: $providerId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserIdsImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerId, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserIdsImplCopyWith<_$UserIdsImpl> get copyWith =>
      __$$UserIdsImplCopyWithImpl<_$UserIdsImpl>(this, _$identity);
}

abstract class _UserIds implements UserIds {
  const factory _UserIds(
      {required final String providerId,
      required final String userId}) = _$UserIdsImpl;

  @override
  String get providerId;
  @override
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$UserIdsImplCopyWith<_$UserIdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
