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
  bool get emailVerified => throw _privateConstructorUsedError;
  DateTime get createdOn => throw _privateConstructorUsedError;
  Map<String, UserRole> get providersRole => throw _privateConstructorUsedError;

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
      bool emailVerified,
      DateTime createdOn,
      Map<String, UserRole> providersRole});
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
    Object? emailVerified = freezed,
    Object? createdOn = freezed,
    Object? providersRole = freezed,
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
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      providersRole: providersRole == freezed
          ? _value.providersRole
          : providersRole // ignore: cast_nullable_to_non_nullable
              as Map<String, UserRole>,
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
      bool emailVerified,
      DateTime createdOn,
      Map<String, UserRole> providersRole});
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
    Object? emailVerified = freezed,
    Object? createdOn = freezed,
    Object? providersRole = freezed,
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
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      providersRole: providersRole == freezed
          ? _value._providersRole
          : providersRole // ignore: cast_nullable_to_non_nullable
              as Map<String, UserRole>,
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
      required this.emailVerified,
      required this.createdOn,
      required final Map<String, UserRole> providersRole})
      : _providersRole = providersRole;

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
  final Map<String, UserRole> _providersRole;
  @override
  Map<String, UserRole> get providersRole {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_providersRole);
  }

  @override
  String toString() {
    return 'AuthUser(uid: $uid, name: $name, surname: $surname, email: $email, emailVerified: $emailVerified, createdOn: $createdOn, providersRole: $providersRole)';
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
                .equals(other.emailVerified, emailVerified) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn) &&
            const DeepCollectionEquality()
                .equals(other._providersRole, _providersRole));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(emailVerified),
      const DeepCollectionEquality().hash(createdOn),
      const DeepCollectionEquality().hash(_providersRole));

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
      required final bool emailVerified,
      required final DateTime createdOn,
      required final Map<String, UserRole> providersRole}) = _$_AuthUser;

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
  Map<String, UserRole> get providersRole;
  @override
  @JsonKey(ignore: true)
  _$$_AuthUserCopyWith<_$_AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}
