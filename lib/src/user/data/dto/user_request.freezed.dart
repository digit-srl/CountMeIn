// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) {
  return _UserRequest.fromJson(json);
}

/// @nodoc
mixin _$UserRequest {
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get cf => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserRequestCopyWith<UserRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRequestCopyWith<$Res> {
  factory $UserRequestCopyWith(
          UserRequest value, $Res Function(UserRequest) then) =
      _$UserRequestCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String surname,
      String cf,
      String email,
      String providerId,
      String providerName,
      String gender});
}

/// @nodoc
class _$UserRequestCopyWithImpl<$Res> implements $UserRequestCopyWith<$Res> {
  _$UserRequestCopyWithImpl(this._value, this._then);

  final UserRequest _value;
  // ignore: unused_field
  final $Res Function(UserRequest) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? providerId = freezed,
    Object? providerName = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
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
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: providerId == freezed
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: providerName == freezed
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserRequestCopyWith<$Res>
    implements $UserRequestCopyWith<$Res> {
  factory _$$_UserRequestCopyWith(
          _$_UserRequest value, $Res Function(_$_UserRequest) then) =
      __$$_UserRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String surname,
      String cf,
      String email,
      String providerId,
      String providerName,
      String gender});
}

/// @nodoc
class __$$_UserRequestCopyWithImpl<$Res> extends _$UserRequestCopyWithImpl<$Res>
    implements _$$_UserRequestCopyWith<$Res> {
  __$$_UserRequestCopyWithImpl(
      _$_UserRequest _value, $Res Function(_$_UserRequest) _then)
      : super(_value, (v) => _then(v as _$_UserRequest));

  @override
  _$_UserRequest get _value => super._value as _$_UserRequest;

  @override
  $Res call({
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? providerId = freezed,
    Object? providerName = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$_UserRequest(
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
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: providerId == freezed
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: providerName == freezed
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserRequest implements _UserRequest {
  const _$_UserRequest(
      {required this.name,
      required this.surname,
      required this.cf,
      required this.email,
      required this.providerId,
      required this.providerName,
      required this.gender});

  factory _$_UserRequest.fromJson(Map<String, dynamic> json) =>
      _$$_UserRequestFromJson(json);

  @override
  final String name;
  @override
  final String surname;
  @override
  final String cf;
  @override
  final String email;
  @override
  final String providerId;
  @override
  final String providerName;
  @override
  final String gender;

  @override
  String toString() {
    return 'UserRequest(name: $name, surname: $surname, cf: $cf, email: $email, providerId: $providerId, providerName: $providerName, gender: $gender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserRequest &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.surname, surname) &&
            const DeepCollectionEquality().equals(other.cf, cf) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.providerId, providerId) &&
            const DeepCollectionEquality()
                .equals(other.providerName, providerName) &&
            const DeepCollectionEquality().equals(other.gender, gender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(cf),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(providerId),
      const DeepCollectionEquality().hash(providerName),
      const DeepCollectionEquality().hash(gender));

  @JsonKey(ignore: true)
  @override
  _$$_UserRequestCopyWith<_$_UserRequest> get copyWith =>
      __$$_UserRequestCopyWithImpl<_$_UserRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserRequestToJson(
      this,
    );
  }
}

abstract class _UserRequest implements UserRequest {
  const factory _UserRequest(
      {required final String name,
      required final String surname,
      required final String cf,
      required final String email,
      required final String providerId,
      required final String providerName,
      required final String gender}) = _$_UserRequest;

  factory _UserRequest.fromJson(Map<String, dynamic> json) =
      _$_UserRequest.fromJson;

  @override
  String get name;
  @override
  String get surname;
  @override
  String get cf;
  @override
  String get email;
  @override
  String get providerId;
  @override
  String get providerName;
  @override
  String get gender;
  @override
  @JsonKey(ignore: true)
  _$$_UserRequestCopyWith<_$_UserRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
