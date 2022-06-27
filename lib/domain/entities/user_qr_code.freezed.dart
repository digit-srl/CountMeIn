// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_qr_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$UserQrCodeCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String activityId,
      String? email});
}

/// @nodoc
class _$UserQrCodeCopyWithImpl<$Res> implements $UserQrCodeCopyWith<$Res> {
  _$UserQrCodeCopyWithImpl(this._value, this._then);

  final UserQrCode _value;
  // ignore: unused_field
  final $Res Function(UserQrCode) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? activityId = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      cf: cf == freezed
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: activityId == freezed
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserQrCodeCopyWith<$Res>
    implements $UserQrCodeCopyWith<$Res> {
  factory _$$_UserQrCodeCopyWith(
          _$_UserQrCode value, $Res Function(_$_UserQrCode) then) =
      __$$_UserQrCodeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String activityId,
      String? email});
}

/// @nodoc
class __$$_UserQrCodeCopyWithImpl<$Res> extends _$UserQrCodeCopyWithImpl<$Res>
    implements _$$_UserQrCodeCopyWith<$Res> {
  __$$_UserQrCodeCopyWithImpl(
      _$_UserQrCode _value, $Res Function(_$_UserQrCode) _then)
      : super(_value, (v) => _then(v as _$_UserQrCode));

  @override
  _$_UserQrCode get _value => super._value as _$_UserQrCode;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? activityId = freezed,
    Object? email = freezed,
  }) {
    return _then(_$_UserQrCode(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      cf: cf == freezed
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: activityId == freezed
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserQrCode implements _UserQrCode {
  const _$_UserQrCode(
      {required this.id,
      required this.name,
      required this.surname,
      required this.cf,
      required this.activityId,
      this.email});

  factory _$_UserQrCode.fromJson(Map<String, dynamic> json) =>
      _$$_UserQrCodeFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserQrCode &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.surname, surname) &&
            const DeepCollectionEquality().equals(other.cf, cf) &&
            const DeepCollectionEquality()
                .equals(other.activityId, activityId) &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(cf),
      const DeepCollectionEquality().hash(activityId),
      const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  _$$_UserQrCodeCopyWith<_$_UserQrCode> get copyWith =>
      __$$_UserQrCodeCopyWithImpl<_$_UserQrCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserQrCodeToJson(this);
  }
}

abstract class _UserQrCode implements UserQrCode {
  const factory _UserQrCode(
      {required final String id,
      required final String name,
      required final String surname,
      required final String cf,
      required final String activityId,
      final String? email}) = _$_UserQrCode;

  factory _UserQrCode.fromJson(Map<String, dynamic> json) =
      _$_UserQrCode.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get surname => throw _privateConstructorUsedError;
  @override
  String get cf => throw _privateConstructorUsedError;
  @override
  String get activityId => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserQrCodeCopyWith<_$_UserQrCode> get copyWith =>
      throw _privateConstructorUsedError;
}
