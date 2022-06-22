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

MUUserDTO _$MUUserDTOFromJson(Map<String, dynamic> json) {
  return _MUUserDTO.fromJson(json);
}

/// @nodoc
class _$MUUserDTOTearOff {
  const _$MUUserDTOTearOff();

  _MUUserDTO call(
      {required String uid,
      required String name,
      required String surname,
      required String email,
      required bool emailVerified,
      required DateTime createdAt}) {
    return _MUUserDTO(
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      emailVerified: emailVerified,
      createdAt: createdAt,
    );
  }

  MUUserDTO fromJson(Map<String, Object?> json) {
    return MUUserDTO.fromJson(json);
  }
}

/// @nodoc
const $MUUserDTO = _$MUUserDTOTearOff();

/// @nodoc
mixin _$MUUserDTO {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MUUserDTOCopyWith<MUUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MUUserDTOCopyWith<$Res> {
  factory $MUUserDTOCopyWith(MUUserDTO value, $Res Function(MUUserDTO) then) =
      _$MUUserDTOCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String name,
      String surname,
      String email,
      bool emailVerified,
      DateTime createdAt});
}

/// @nodoc
class _$MUUserDTOCopyWithImpl<$Res> implements $MUUserDTOCopyWith<$Res> {
  _$MUUserDTOCopyWithImpl(this._value, this._then);

  final MUUserDTO _value;
  // ignore: unused_field
  final $Res Function(MUUserDTO) _then;

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
abstract class _$MUUserDTOCopyWith<$Res> implements $MUUserDTOCopyWith<$Res> {
  factory _$MUUserDTOCopyWith(
          _MUUserDTO value, $Res Function(_MUUserDTO) then) =
      __$MUUserDTOCopyWithImpl<$Res>;
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
class __$MUUserDTOCopyWithImpl<$Res> extends _$MUUserDTOCopyWithImpl<$Res>
    implements _$MUUserDTOCopyWith<$Res> {
  __$MUUserDTOCopyWithImpl(_MUUserDTO _value, $Res Function(_MUUserDTO) _then)
      : super(_value, (v) => _then(v as _MUUserDTO));

  @override
  _MUUserDTO get _value => super._value as _MUUserDTO;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? emailVerified = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_MUUserDTO(
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
@JsonSerializable()
class _$_MUUserDTO implements _MUUserDTO {
  const _$_MUUserDTO(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.email,
      required this.emailVerified,
      required this.createdAt});

  factory _$_MUUserDTO.fromJson(Map<String, dynamic> json) =>
      _$$_MUUserDTOFromJson(json);

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
    return 'MUUserDTO(uid: $uid, name: $name, surname: $surname, email: $email, emailVerified: $emailVerified, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MUUserDTO &&
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
  _$MUUserDTOCopyWith<_MUUserDTO> get copyWith =>
      __$MUUserDTOCopyWithImpl<_MUUserDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MUUserDTOToJson(this);
  }
}

abstract class _MUUserDTO implements MUUserDTO {
  const factory _MUUserDTO(
      {required String uid,
      required String name,
      required String surname,
      required String email,
      required bool emailVerified,
      required DateTime createdAt}) = _$_MUUserDTO;

  factory _MUUserDTO.fromJson(Map<String, dynamic> json) =
      _$_MUUserDTO.fromJson;

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
  _$MUUserDTOCopyWith<_MUUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
