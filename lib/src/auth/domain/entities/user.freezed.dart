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

/// @nodoc
mixin _$AuthUser {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  DateTime get createdOn => throw _privateConstructorUsedError;
  PlatformRole get role => throw _privateConstructorUsedError;
  bool get temporaryPassword => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthUserCopyWith<AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserCopyWith<$Res> {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) then) =
      _$AuthUserCopyWithImpl<$Res, AuthUser>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      bool emailVerified,
      DateTime createdOn,
      PlatformRole role,
      bool temporaryPassword});
}

/// @nodoc
class _$AuthUserCopyWithImpl<$Res, $Val extends AuthUser>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._value, this._then);

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
    Object? createdOn = null,
    Object? role = null,
    Object? temporaryPassword = null,
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
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as PlatformRole,
      temporaryPassword: null == temporaryPassword
          ? _value.temporaryPassword
          : temporaryPassword // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserImplCopyWith<$Res>
    implements $AuthUserCopyWith<$Res> {
  factory _$$AuthUserImplCopyWith(
          _$AuthUserImpl value, $Res Function(_$AuthUserImpl) then) =
      __$$AuthUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      bool emailVerified,
      DateTime createdOn,
      PlatformRole role,
      bool temporaryPassword});
}

/// @nodoc
class __$$AuthUserImplCopyWithImpl<$Res>
    extends _$AuthUserCopyWithImpl<$Res, _$AuthUserImpl>
    implements _$$AuthUserImplCopyWith<$Res> {
  __$$AuthUserImplCopyWithImpl(
      _$AuthUserImpl _value, $Res Function(_$AuthUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? emailVerified = null,
    Object? createdOn = null,
    Object? role = null,
    Object? temporaryPassword = null,
  }) {
    return _then(_$AuthUserImpl(
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
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as PlatformRole,
      temporaryPassword: null == temporaryPassword
          ? _value.temporaryPassword
          : temporaryPassword // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthUserImpl implements _AuthUser {
  const _$AuthUserImpl(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required this.emailVerified,
      required this.createdOn,
      required this.role,
      this.temporaryPassword = true});

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
  final DateTime createdOn;
  @override
  final PlatformRole role;
  @override
  @JsonKey()
  final bool temporaryPassword;

  @override
  String toString() {
    return 'AuthUser(uid: $uid, name: $name, surname: $surname, email: $email, emailVerified: $emailVerified, createdOn: $createdOn, role: $role, temporaryPassword: $temporaryPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.temporaryPassword, temporaryPassword) ||
                other.temporaryPassword == temporaryPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, name, surname, email,
      emailVerified, createdOn, role, temporaryPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      __$$AuthUserImplCopyWithImpl<_$AuthUserImpl>(this, _$identity);
}

abstract class _AuthUser implements AuthUser {
  const factory _AuthUser(
      {required final String uid,
      required final String name,
      required final String surname,
      required final String email,
      required final bool emailVerified,
      required final DateTime createdOn,
      required final PlatformRole role,
      final bool temporaryPassword}) = _$AuthUserImpl;

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
  DateTime get createdOn;
  @override
  PlatformRole get role;
  @override
  bool get temporaryPassword;
  @override
  @JsonKey(ignore: true)
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
