// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_qr_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserQrCode _$UserQrCodeFromJson(Map<String, dynamic> json) {
  return _UserQrCode.fromJson(json);
}

/// @nodoc
mixin _$UserQrCode {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get cf => throw _privateConstructorUsedError;
  String get activityId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserQrCodeCopyWith<UserQrCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserQrCodeCopyWith<$Res> {
  factory $UserQrCodeCopyWith(
          UserQrCode value, $Res Function(UserQrCode) then) =
      _$UserQrCodeCopyWithImpl<$Res, UserQrCode>;
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String activityId,
      String? email});
}

/// @nodoc
class _$UserQrCodeCopyWithImpl<$Res, $Val extends UserQrCode>
    implements $UserQrCodeCopyWith<$Res> {
  _$UserQrCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? cf = null,
    Object? activityId = null,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      cf: null == cf
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserQrCodeImplCopyWith<$Res>
    implements $UserQrCodeCopyWith<$Res> {
  factory _$$UserQrCodeImplCopyWith(
          _$UserQrCodeImpl value, $Res Function(_$UserQrCodeImpl) then) =
      __$$UserQrCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String activityId,
      String? email});
}

/// @nodoc
class __$$UserQrCodeImplCopyWithImpl<$Res>
    extends _$UserQrCodeCopyWithImpl<$Res, _$UserQrCodeImpl>
    implements _$$UserQrCodeImplCopyWith<$Res> {
  __$$UserQrCodeImplCopyWithImpl(
      _$UserQrCodeImpl _value, $Res Function(_$UserQrCodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? cf = null,
    Object? activityId = null,
    Object? email = freezed,
  }) {
    return _then(_$UserQrCodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      cf: null == cf
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserQrCodeImpl implements _UserQrCode {
  const _$UserQrCodeImpl(
      {required this.id,
      required this.name,
      required this.surname,
      required this.cf,
      required this.activityId,
      this.email});

  factory _$UserQrCodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserQrCodeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String cf;
  @override
  final String activityId;
  @override
  final String? email;

  @override
  String toString() {
    return 'UserQrCode(id: $id, name: $name, surname: $surname, cf: $cf, activityId: $activityId, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserQrCodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.cf, cf) || other.cf == cf) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, surname, cf, activityId, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserQrCodeImplCopyWith<_$UserQrCodeImpl> get copyWith =>
      __$$UserQrCodeImplCopyWithImpl<_$UserQrCodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserQrCodeImplToJson(
      this,
    );
  }
}

abstract class _UserQrCode implements UserQrCode {
  const factory _UserQrCode(
      {required final String id,
      required final String name,
      required final String surname,
      required final String cf,
      required final String activityId,
      final String? email}) = _$UserQrCodeImpl;

  factory _UserQrCode.fromJson(Map<String, dynamic> json) =
      _$UserQrCodeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get cf;
  @override
  String get activityId;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  _$$UserQrCodeImplCopyWith<_$UserQrCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
