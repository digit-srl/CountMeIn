// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserCard _$UserCardFromJson(Map<String, dynamic> json) {
  return _UserCard.fromJson(json);
}

/// @nodoc
mixin _$UserCard {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get cf => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get secret => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get addedOn => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCardCopyWith<UserCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCardCopyWith<$Res> {
  factory $UserCardCopyWith(UserCard value, $Res Function(UserCard) then) =
      _$UserCardCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String? email,
      String? secret,
      @MyDateTimeConverter() DateTime? addedOn,
      bool emailVerified});
}

/// @nodoc
class _$UserCardCopyWithImpl<$Res> implements $UserCardCopyWith<$Res> {
  _$UserCardCopyWithImpl(this._value, this._then);

  final UserCard _value;
  // ignore: unused_field
  final $Res Function(UserCard) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? secret = freezed,
    Object? addedOn = freezed,
    Object? emailVerified = freezed,
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
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: secret == freezed
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: addedOn == freezed
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_UserCardCopyWith<$Res> implements $UserCardCopyWith<$Res> {
  factory _$$_UserCardCopyWith(
          _$_UserCard value, $Res Function(_$_UserCard) then) =
      __$$_UserCardCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String? email,
      String? secret,
      @MyDateTimeConverter() DateTime? addedOn,
      bool emailVerified});
}

/// @nodoc
class __$$_UserCardCopyWithImpl<$Res> extends _$UserCardCopyWithImpl<$Res>
    implements _$$_UserCardCopyWith<$Res> {
  __$$_UserCardCopyWithImpl(
      _$_UserCard _value, $Res Function(_$_UserCard) _then)
      : super(_value, (v) => _then(v as _$_UserCard));

  @override
  _$_UserCard get _value => super._value as _$_UserCard;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? secret = freezed,
    Object? addedOn = freezed,
    Object? emailVerified = freezed,
  }) {
    return _then(_$_UserCard(
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
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: secret == freezed
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: addedOn == freezed
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserCard implements _UserCard {
  const _$_UserCard(
      {required this.id,
      required this.name,
      required this.surname,
      required this.cf,
      this.email,
      this.secret,
      @MyDateTimeConverter() this.addedOn,
      this.emailVerified = false});

  factory _$_UserCard.fromJson(Map<String, dynamic> json) =>
      _$$_UserCardFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String cf;
  @override
  final String? email;
  @override
  final String? secret;
  @override
  @MyDateTimeConverter()
  final DateTime? addedOn;
  @override
  @JsonKey()
  final bool emailVerified;

  @override
  String toString() {
    return 'UserCard(id: $id, name: $name, surname: $surname, cf: $cf, email: $email, secret: $secret, addedOn: $addedOn, emailVerified: $emailVerified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserCard &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.surname, surname) &&
            const DeepCollectionEquality().equals(other.cf, cf) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.secret, secret) &&
            const DeepCollectionEquality().equals(other.addedOn, addedOn) &&
            const DeepCollectionEquality()
                .equals(other.emailVerified, emailVerified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(cf),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(secret),
      const DeepCollectionEquality().hash(addedOn),
      const DeepCollectionEquality().hash(emailVerified));

  @JsonKey(ignore: true)
  @override
  _$$_UserCardCopyWith<_$_UserCard> get copyWith =>
      __$$_UserCardCopyWithImpl<_$_UserCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserCardToJson(
      this,
    );
  }
}

abstract class _UserCard implements UserCard {
  const factory _UserCard(
      {required final String id,
      required final String name,
      required final String surname,
      required final String cf,
      final String? email,
      final String? secret,
      @MyDateTimeConverter() final DateTime? addedOn,
      final bool emailVerified}) = _$_UserCard;

  factory _UserCard.fromJson(Map<String, dynamic> json) = _$_UserCard.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get cf;
  @override
  String? get email;
  @override
  String? get secret;
  @override
  @MyDateTimeConverter()
  DateTime? get addedOn;
  @override
  bool get emailVerified;
  @override
  @JsonKey(ignore: true)
  _$$_UserCardCopyWith<_$_UserCard> get copyWith =>
      throw _privateConstructorUsedError;
}

EventUser _$EventUserFromJson(Map<String, dynamic> json) {
  return _EventUser.fromJson(json);
}

/// @nodoc
mixin _$EventUser {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get surname => throw _privateConstructorUsedError;
  String? get cf => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get checkInAt => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get checkOutAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventUserCopyWith<EventUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventUserCopyWith<$Res> {
  factory $EventUserCopyWith(EventUser value, $Res Function(EventUser) then) =
      _$EventUserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String? name,
      String? surname,
      String? cf,
      String? email,
      @MyDateTimeConverter() DateTime? checkInAt,
      @MyDateTimeConverter() DateTime? checkOutAt});
}

/// @nodoc
class _$EventUserCopyWithImpl<$Res> implements $EventUserCopyWith<$Res> {
  _$EventUserCopyWithImpl(this._value, this._then);

  final EventUser _value;
  // ignore: unused_field
  final $Res Function(EventUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? checkInAt = freezed,
    Object? checkOutAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      cf: cf == freezed
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInAt: checkInAt == freezed
          ? _value.checkInAt
          : checkInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkOutAt: checkOutAt == freezed
          ? _value.checkOutAt
          : checkOutAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_EventUserCopyWith<$Res> implements $EventUserCopyWith<$Res> {
  factory _$$_EventUserCopyWith(
          _$_EventUser value, $Res Function(_$_EventUser) then) =
      __$$_EventUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String? name,
      String? surname,
      String? cf,
      String? email,
      @MyDateTimeConverter() DateTime? checkInAt,
      @MyDateTimeConverter() DateTime? checkOutAt});
}

/// @nodoc
class __$$_EventUserCopyWithImpl<$Res> extends _$EventUserCopyWithImpl<$Res>
    implements _$$_EventUserCopyWith<$Res> {
  __$$_EventUserCopyWithImpl(
      _$_EventUser _value, $Res Function(_$_EventUser) _then)
      : super(_value, (v) => _then(v as _$_EventUser));

  @override
  _$_EventUser get _value => super._value as _$_EventUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? checkInAt = freezed,
    Object? checkOutAt = freezed,
  }) {
    return _then(_$_EventUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      cf: cf == freezed
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInAt: checkInAt == freezed
          ? _value.checkInAt
          : checkInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkOutAt: checkOutAt == freezed
          ? _value.checkOutAt
          : checkOutAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventUser implements _EventUser {
  const _$_EventUser(
      {required this.id,
      this.name,
      this.surname,
      this.cf,
      this.email,
      @MyDateTimeConverter() this.checkInAt,
      @MyDateTimeConverter() this.checkOutAt});

  factory _$_EventUser.fromJson(Map<String, dynamic> json) =>
      _$$_EventUserFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? surname;
  @override
  final String? cf;
  @override
  final String? email;
  @override
  @MyDateTimeConverter()
  final DateTime? checkInAt;
  @override
  @MyDateTimeConverter()
  final DateTime? checkOutAt;

  @override
  String toString() {
    return 'EventUser(id: $id, name: $name, surname: $surname, cf: $cf, email: $email, checkInAt: $checkInAt, checkOutAt: $checkOutAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventUser &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.surname, surname) &&
            const DeepCollectionEquality().equals(other.cf, cf) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.checkInAt, checkInAt) &&
            const DeepCollectionEquality()
                .equals(other.checkOutAt, checkOutAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(cf),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(checkInAt),
      const DeepCollectionEquality().hash(checkOutAt));

  @JsonKey(ignore: true)
  @override
  _$$_EventUserCopyWith<_$_EventUser> get copyWith =>
      __$$_EventUserCopyWithImpl<_$_EventUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventUserToJson(
      this,
    );
  }
}

abstract class _EventUser implements EventUser {
  const factory _EventUser(
      {required final String id,
      final String? name,
      final String? surname,
      final String? cf,
      final String? email,
      @MyDateTimeConverter() final DateTime? checkInAt,
      @MyDateTimeConverter() final DateTime? checkOutAt}) = _$_EventUser;

  factory _EventUser.fromJson(Map<String, dynamic> json) =
      _$_EventUser.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get surname;
  @override
  String? get cf;
  @override
  String? get email;
  @override
  @MyDateTimeConverter()
  DateTime? get checkInAt;
  @override
  @MyDateTimeConverter()
  DateTime? get checkOutAt;
  @override
  @JsonKey(ignore: true)
  _$$_EventUserCopyWith<_$_EventUser> get copyWith =>
      throw _privateConstructorUsedError;
}
