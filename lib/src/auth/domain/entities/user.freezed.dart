// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthUser {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  List<String> get activityIds => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthUserCopyWith<AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserCopyWith<$Res> {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) then) =
      _$AuthUserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      List<String> activityIds,
      bool emailVerified,
      DateTime createdAt,
      UserRole role});
}

/// @nodoc
class _$AuthUserCopyWithImpl<$Res> implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._value, this._then);

  final AuthUser _value;
  // ignore: unused_field
  final $Res Function(AuthUser) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? activityIds = freezed,
    Object? emailVerified = freezed,
    Object? createdAt = freezed,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      activityIds: activityIds == freezed
          ? _value.activityIds
          : activityIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ));
  }
}

/// @nodoc
abstract class _$$_AuthUserCopyWith<$Res> implements $AuthUserCopyWith<$Res> {
  factory _$$_AuthUserCopyWith(
          _$_AuthUser value, $Res Function(_$_AuthUser) then) =
      __$$_AuthUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      List<String> activityIds,
      bool emailVerified,
      DateTime createdAt,
      UserRole role});
}

/// @nodoc
class __$$_AuthUserCopyWithImpl<$Res> extends _$AuthUserCopyWithImpl<$Res>
    implements _$$_AuthUserCopyWith<$Res> {
  __$$_AuthUserCopyWithImpl(
      _$_AuthUser _value, $Res Function(_$_AuthUser) _then)
      : super(_value, (v) => _then(v as _$_AuthUser));

  @override
  _$_AuthUser get _value => super._value as _$_AuthUser;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? activityIds = freezed,
    Object? emailVerified = freezed,
    Object? createdAt = freezed,
    Object? role = freezed,
  }) {
    return _then(_$_AuthUser(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      activityIds: activityIds == freezed
          ? _value._activityIds
          : activityIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ));
  }
}

/// @nodoc

class _$_AuthUser implements _AuthUser {
  const _$_AuthUser(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required final List<String> activityIds,
      required this.emailVerified,
      required this.createdAt,
      required this.role})
      : _activityIds = activityIds;

  @override
  final String uid;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String email;
  final List<String> _activityIds;
  @override
  List<String> get activityIds {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activityIds);
  }

  @override
  final bool emailVerified;
  @override
  final DateTime createdAt;
  @override
  final UserRole role;

  @override
  String toString() {
    return 'AuthUser(uid: $uid, name: $name, surname: $surname, email: $email, activityIds: $activityIds, emailVerified: $emailVerified, createdAt: $createdAt, role: $role)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthUser &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.surname, surname) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other._activityIds, _activityIds) &&
            const DeepCollectionEquality()
                .equals(other.emailVerified, emailVerified) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.role, role));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(_activityIds),
      const DeepCollectionEquality().hash(emailVerified),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(role));

  @JsonKey(ignore: true)
  @override
  _$$_AuthUserCopyWith<_$_AuthUser> get copyWith =>
      __$$_AuthUserCopyWithImpl<_$_AuthUser>(this, _$identity);
}

abstract class _AuthUser implements AuthUser {
  const factory _AuthUser(
      {required final String uid,
      required final String name,
      required final String surname,
      required final String email,
      required final List<String> activityIds,
      required final bool emailVerified,
      required final DateTime createdAt,
      required final UserRole role}) = _$_AuthUser;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get surname => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  @override
  List<String> get activityIds => throw _privateConstructorUsedError;
  @override
  bool get emailVerified => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  UserRole get role => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AuthUserCopyWith<_$_AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}
