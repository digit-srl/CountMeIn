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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MUUserTearOff {
  const _$MUUserTearOff();

  _MUUser call(
      {required String uid,
      required String name,
      required String surname,
      required String email,
      required bool emailVerified,
      required DateTime createdAt}) {
    return _MUUser(
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      emailVerified: emailVerified,
      createdAt: createdAt,
    );
  }
}

/// @nodoc
const $MUUser = _$MUUserTearOff();

/// @nodoc
mixin _$MUUser {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MUUserCopyWith<MUUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MUUserCopyWith<$Res> {
  factory $MUUserCopyWith(MUUser value, $Res Function(MUUser) then) =
      _$MUUserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      bool emailVerified,
      DateTime createdAt});
}

/// @nodoc
class _$MUUserCopyWithImpl<$Res> implements $MUUserCopyWith<$Res> {
  _$MUUserCopyWithImpl(this._value, this._then);

  final MUUser _value;
  // ignore: unused_field
  final $Res Function(MUUser) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? emailVerified = freezed,
    Object? createdAt = freezed,
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$MUUserCopyWith<$Res> implements $MUUserCopyWith<$Res> {
  factory _$MUUserCopyWith(_MUUser value, $Res Function(_MUUser) then) =
      __$MUUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      bool emailVerified,
      DateTime createdAt});
}

/// @nodoc
class __$MUUserCopyWithImpl<$Res> extends _$MUUserCopyWithImpl<$Res>
    implements _$MUUserCopyWith<$Res> {
  __$MUUserCopyWithImpl(_MUUser _value, $Res Function(_MUUser) _then)
      : super(_value, (v) => _then(v as _MUUser));

  @override
  _MUUser get _value => super._value as _MUUser;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? emailVerified = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_MUUser(
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_MUUser implements _MUUser {
  const _$_MUUser(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required this.emailVerified,
      required this.createdAt});

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
  final DateTime createdAt;

  @override
  String toString() {
    return 'MUUser(uid: $uid, name: $name, surname: $surname, email: $email, emailVerified: $emailVerified, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MUUser &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.surname, surname) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.emailVerified, emailVerified) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(emailVerified),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$MUUserCopyWith<_MUUser> get copyWith =>
      __$MUUserCopyWithImpl<_MUUser>(this, _$identity);
}

abstract class _MUUser implements MUUser {
  const factory _MUUser(
      {required String uid,
      required String name,
      required String surname,
      required String email,
      required bool emailVerified,
      required DateTime createdAt}) = _$_MUUser;

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
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$MUUserCopyWith<_MUUser> get copyWith => throw _privateConstructorUsedError;
}
