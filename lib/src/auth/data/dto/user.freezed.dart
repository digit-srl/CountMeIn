// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthUserDTO _$AuthUserDTOFromJson(Map<String, dynamic> json) {
  return _AuthUserDTO.fromJson(json);
}

/// @nodoc
mixin _$AuthUserDTO {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  bool get temporaryPassword => throw _privateConstructorUsedError;
  @CMIRoleConverter()
  PlatformRole get role =>
      throw _privateConstructorUsedError; // Map<String, String>? providersRole,
  @MyDateTimeConverter()
  DateTime get createdOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthUserDTOCopyWith<AuthUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserDTOCopyWith<$Res> {
  factory $AuthUserDTOCopyWith(
          AuthUserDTO value, $Res Function(AuthUserDTO) then) =
      _$AuthUserDTOCopyWithImpl<$Res, AuthUserDTO>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      bool emailVerified,
      bool temporaryPassword,
      @CMIRoleConverter() PlatformRole role,
      @MyDateTimeConverter() DateTime createdOn});
}

/// @nodoc
class _$AuthUserDTOCopyWithImpl<$Res, $Val extends AuthUserDTO>
    implements $AuthUserDTOCopyWith<$Res> {
  _$AuthUserDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? emailVerified = null,
    Object? temporaryPassword = null,
    Object? role = null,
    Object? createdOn = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      temporaryPassword: null == temporaryPassword
          ? _value.temporaryPassword
          : temporaryPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as PlatformRole,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserDTOImplCopyWith<$Res>
    implements $AuthUserDTOCopyWith<$Res> {
  factory _$$AuthUserDTOImplCopyWith(
          _$AuthUserDTOImpl value, $Res Function(_$AuthUserDTOImpl) then) =
      __$$AuthUserDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      bool emailVerified,
      bool temporaryPassword,
      @CMIRoleConverter() PlatformRole role,
      @MyDateTimeConverter() DateTime createdOn});
}

/// @nodoc
class __$$AuthUserDTOImplCopyWithImpl<$Res>
    extends _$AuthUserDTOCopyWithImpl<$Res, _$AuthUserDTOImpl>
    implements _$$AuthUserDTOImplCopyWith<$Res> {
  __$$AuthUserDTOImplCopyWithImpl(
      _$AuthUserDTOImpl _value, $Res Function(_$AuthUserDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? emailVerified = null,
    Object? temporaryPassword = null,
    Object? role = null,
    Object? createdOn = null,
  }) {
    return _then(_$AuthUserDTOImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      temporaryPassword: null == temporaryPassword
          ? _value.temporaryPassword
          : temporaryPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as PlatformRole,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserDTOImpl implements _AuthUserDTO {
  const _$AuthUserDTOImpl(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required this.emailVerified,
      this.temporaryPassword = true,
      @CMIRoleConverter() required this.role,
      @MyDateTimeConverter() required this.createdOn});

  factory _$AuthUserDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserDTOImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String email;
  @override
  final bool emailVerified;
  @override
  @JsonKey()
  final bool temporaryPassword;
  @override
  @CMIRoleConverter()
  final PlatformRole role;
// Map<String, String>? providersRole,
  @override
  @MyDateTimeConverter()
  final DateTime createdOn;

  @override
  String toString() {
    return 'AuthUserDTO(uid: $uid, name: $name, surname: $surname, email: $email, emailVerified: $emailVerified, temporaryPassword: $temporaryPassword, role: $role, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserDTOImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.temporaryPassword, temporaryPassword) ||
                other.temporaryPassword == temporaryPassword) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, name, surname, email,
      emailVerified, temporaryPassword, role, createdOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserDTOImplCopyWith<_$AuthUserDTOImpl> get copyWith =>
      __$$AuthUserDTOImplCopyWithImpl<_$AuthUserDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserDTOImplToJson(
      this,
    );
  }
}

abstract class _AuthUserDTO implements AuthUserDTO {
  const factory _AuthUserDTO(
          {required final String uid,
          required final String name,
          required final String surname,
          required final String email,
          required final bool emailVerified,
          final bool temporaryPassword,
          @CMIRoleConverter() required final PlatformRole role,
          @MyDateTimeConverter() required final DateTime createdOn}) =
      _$AuthUserDTOImpl;

  factory _AuthUserDTO.fromJson(Map<String, dynamic> json) =
      _$AuthUserDTOImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get email;
  @override
  bool get emailVerified;
  @override
  bool get temporaryPassword;
  @override
  @CMIRoleConverter()
  PlatformRole get role;
  @override // Map<String, String>? providersRole,
  @MyDateTimeConverter()
  DateTime get createdOn;
  @override
  @JsonKey(ignore: true)
  _$$AuthUserDTOImplCopyWith<_$AuthUserDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
