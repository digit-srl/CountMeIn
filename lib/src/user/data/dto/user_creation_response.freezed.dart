// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_creation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserCreationResponse _$UserCreationResponseFromJson(Map<String, dynamic> json) {
  return _UserCreationResponse.fromJson(json);
}

/// @nodoc
mixin _$UserCreationResponse {
  String get status => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  bool? get emailVerified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCreationResponseCopyWith<UserCreationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCreationResponseCopyWith<$Res> {
  factory $UserCreationResponseCopyWith(UserCreationResponse value,
          $Res Function(UserCreationResponse) then) =
      _$UserCreationResponseCopyWithImpl<$Res>;
  $Res call({String status, String? userId, bool? emailVerified});
}

/// @nodoc
class _$UserCreationResponseCopyWithImpl<$Res>
    implements $UserCreationResponseCopyWith<$Res> {
  _$UserCreationResponseCopyWithImpl(this._value, this._then);

  final UserCreationResponse _value;
  // ignore: unused_field
  final $Res Function(UserCreationResponse) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? userId = freezed,
    Object? emailVerified = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserCreationResponseCopyWith<$Res>
    implements $UserCreationResponseCopyWith<$Res> {
  factory _$$_UserCreationResponseCopyWith(_$_UserCreationResponse value,
          $Res Function(_$_UserCreationResponse) then) =
      __$$_UserCreationResponseCopyWithImpl<$Res>;
  @override
  $Res call({String status, String? userId, bool? emailVerified});
}

/// @nodoc
class __$$_UserCreationResponseCopyWithImpl<$Res>
    extends _$UserCreationResponseCopyWithImpl<$Res>
    implements _$$_UserCreationResponseCopyWith<$Res> {
  __$$_UserCreationResponseCopyWithImpl(_$_UserCreationResponse _value,
      $Res Function(_$_UserCreationResponse) _then)
      : super(_value, (v) => _then(v as _$_UserCreationResponse));

  @override
  _$_UserCreationResponse get _value => super._value as _$_UserCreationResponse;

  @override
  $Res call({
    Object? status = freezed,
    Object? userId = freezed,
    Object? emailVerified = freezed,
  }) {
    return _then(_$_UserCreationResponse(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserCreationResponse implements _UserCreationResponse {
  const _$_UserCreationResponse(
      {required this.status, this.userId, this.emailVerified});

  factory _$_UserCreationResponse.fromJson(Map<String, dynamic> json) =>
      _$$_UserCreationResponseFromJson(json);

  @override
  final String status;
  @override
  final String? userId;
  @override
  final bool? emailVerified;

  @override
  String toString() {
    return 'UserCreationResponse(status: $status, userId: $userId, emailVerified: $emailVerified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserCreationResponse &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.emailVerified, emailVerified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(emailVerified));

  @JsonKey(ignore: true)
  @override
  _$$_UserCreationResponseCopyWith<_$_UserCreationResponse> get copyWith =>
      __$$_UserCreationResponseCopyWithImpl<_$_UserCreationResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserCreationResponseToJson(
      this,
    );
  }
}

abstract class _UserCreationResponse implements UserCreationResponse {
  const factory _UserCreationResponse(
      {required final String status,
      final String? userId,
      final bool? emailVerified}) = _$_UserCreationResponse;

  factory _UserCreationResponse.fromJson(Map<String, dynamic> json) =
      _$_UserCreationResponse.fromJson;

  @override
  String get status;
  @override
  String? get userId;
  @override
  bool? get emailVerified;
  @override
  @JsonKey(ignore: true)
  _$$_UserCreationResponseCopyWith<_$_UserCreationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
