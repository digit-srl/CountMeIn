// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
  String? get gender => throw _privateConstructorUsedError;
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
      _$UserCardCopyWithImpl<$Res, UserCard>;
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String? email,
      String? secret,
      String? gender,
      @MyDateTimeConverter() DateTime? addedOn,
      bool emailVerified});
}

/// @nodoc
class _$UserCardCopyWithImpl<$Res, $Val extends UserCard>
    implements $UserCardCopyWith<$Res> {
  _$UserCardCopyWithImpl(this._value, this._then);

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
    Object? email = freezed,
    Object? secret = freezed,
    Object? gender = freezed,
    Object? addedOn = freezed,
    Object? emailVerified = null,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCardImplCopyWith<$Res>
    implements $UserCardCopyWith<$Res> {
  factory _$$UserCardImplCopyWith(
          _$UserCardImpl value, $Res Function(_$UserCardImpl) then) =
      __$$UserCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String cf,
      String? email,
      String? secret,
      String? gender,
      @MyDateTimeConverter() DateTime? addedOn,
      bool emailVerified});
}

/// @nodoc
class __$$UserCardImplCopyWithImpl<$Res>
    extends _$UserCardCopyWithImpl<$Res, _$UserCardImpl>
    implements _$$UserCardImplCopyWith<$Res> {
  __$$UserCardImplCopyWithImpl(
      _$UserCardImpl _value, $Res Function(_$UserCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? cf = null,
    Object? email = freezed,
    Object? secret = freezed,
    Object? gender = freezed,
    Object? addedOn = freezed,
    Object? emailVerified = null,
  }) {
    return _then(_$UserCardImpl(
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCardImpl implements _UserCard {
  const _$UserCardImpl(
      {required this.id,
      required this.name,
      required this.surname,
      required this.cf,
      this.email,
      this.secret,
      this.gender,
      @MyDateTimeConverter() this.addedOn,
      this.emailVerified = false});

  factory _$UserCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCardImplFromJson(json);

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
  final String? gender;
  @override
  @MyDateTimeConverter()
  final DateTime? addedOn;
  @override
  @JsonKey()
  final bool emailVerified;

  @override
  String toString() {
    return 'UserCard(id: $id, name: $name, surname: $surname, cf: $cf, email: $email, secret: $secret, gender: $gender, addedOn: $addedOn, emailVerified: $emailVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.cf, cf) || other.cf == cf) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.secret, secret) || other.secret == secret) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, surname, cf, email,
      secret, gender, addedOn, emailVerified);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCardImplCopyWith<_$UserCardImpl> get copyWith =>
      __$$UserCardImplCopyWithImpl<_$UserCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCardImplToJson(
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
      final String? gender,
      @MyDateTimeConverter() final DateTime? addedOn,
      final bool emailVerified}) = _$UserCardImpl;

  factory _UserCard.fromJson(Map<String, dynamic> json) =
      _$UserCardImpl.fromJson;

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
  String? get gender;
  @override
  @MyDateTimeConverter()
  DateTime? get addedOn;
  @override
  bool get emailVerified;
  @override
  @JsonKey(ignore: true)
  _$$UserCardImplCopyWith<_$UserCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventUser _$EventUserFromJson(Map<String, dynamic> json) {
  return _EventUser.fromJson(json);
}

/// @nodoc
mixin _$EventUser {
  String get id => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String? get userCardProviderId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get surname => throw _privateConstructorUsedError;
  String? get cf => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get privateId => throw _privateConstructorUsedError;
  bool get fromExternalOrganization => throw _privateConstructorUsedError;
  bool get isGroup => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get checkInAt => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get checkOutAt => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;
  int? get averageAge => throw _privateConstructorUsedError;
  int? get groupCount => throw _privateConstructorUsedError;
  int? get participationCount => throw _privateConstructorUsedError;
  double? get womanPercentage => throw _privateConstructorUsedError;
  double? get manPercentage => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint? get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventUserCopyWith<EventUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventUserCopyWith<$Res> {
  factory $EventUserCopyWith(EventUser value, $Res Function(EventUser) then) =
      _$EventUserCopyWithImpl<$Res, EventUser>;
  @useResult
  $Res call(
      {String id,
      String providerId,
      String? userCardProviderId,
      String? name,
      String? surname,
      String? cf,
      String? email,
      String? privateId,
      bool fromExternalOrganization,
      bool isGroup,
      bool isAnonymous,
      @MyDateTimeConverter() DateTime? checkInAt,
      @MyDateTimeConverter() DateTime? checkOutAt,
      String? groupName,
      int? averageAge,
      int? groupCount,
      int? participationCount,
      double? womanPercentage,
      double? manPercentage,
      @GeoPointConverter() GeoPoint? position});
}

/// @nodoc
class _$EventUserCopyWithImpl<$Res, $Val extends EventUser>
    implements $EventUserCopyWith<$Res> {
  _$EventUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? providerId = null,
    Object? userCardProviderId = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? privateId = freezed,
    Object? fromExternalOrganization = null,
    Object? isGroup = null,
    Object? isAnonymous = null,
    Object? checkInAt = freezed,
    Object? checkOutAt = freezed,
    Object? groupName = freezed,
    Object? averageAge = freezed,
    Object? groupCount = freezed,
    Object? participationCount = freezed,
    Object? womanPercentage = freezed,
    Object? manPercentage = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      userCardProviderId: freezed == userCardProviderId
          ? _value.userCardProviderId
          : userCardProviderId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      cf: freezed == cf
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      privateId: freezed == privateId
          ? _value.privateId
          : privateId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromExternalOrganization: null == fromExternalOrganization
          ? _value.fromExternalOrganization
          : fromExternalOrganization // ignore: cast_nullable_to_non_nullable
              as bool,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      checkInAt: freezed == checkInAt
          ? _value.checkInAt
          : checkInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkOutAt: freezed == checkOutAt
          ? _value.checkOutAt
          : checkOutAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      averageAge: freezed == averageAge
          ? _value.averageAge
          : averageAge // ignore: cast_nullable_to_non_nullable
              as int?,
      groupCount: freezed == groupCount
          ? _value.groupCount
          : groupCount // ignore: cast_nullable_to_non_nullable
              as int?,
      participationCount: freezed == participationCount
          ? _value.participationCount
          : participationCount // ignore: cast_nullable_to_non_nullable
              as int?,
      womanPercentage: freezed == womanPercentage
          ? _value.womanPercentage
          : womanPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      manPercentage: freezed == manPercentage
          ? _value.manPercentage
          : manPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventUserImplCopyWith<$Res>
    implements $EventUserCopyWith<$Res> {
  factory _$$EventUserImplCopyWith(
          _$EventUserImpl value, $Res Function(_$EventUserImpl) then) =
      __$$EventUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String providerId,
      String? userCardProviderId,
      String? name,
      String? surname,
      String? cf,
      String? email,
      String? privateId,
      bool fromExternalOrganization,
      bool isGroup,
      bool isAnonymous,
      @MyDateTimeConverter() DateTime? checkInAt,
      @MyDateTimeConverter() DateTime? checkOutAt,
      String? groupName,
      int? averageAge,
      int? groupCount,
      int? participationCount,
      double? womanPercentage,
      double? manPercentage,
      @GeoPointConverter() GeoPoint? position});
}

/// @nodoc
class __$$EventUserImplCopyWithImpl<$Res>
    extends _$EventUserCopyWithImpl<$Res, _$EventUserImpl>
    implements _$$EventUserImplCopyWith<$Res> {
  __$$EventUserImplCopyWithImpl(
      _$EventUserImpl _value, $Res Function(_$EventUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? providerId = null,
    Object? userCardProviderId = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? cf = freezed,
    Object? email = freezed,
    Object? privateId = freezed,
    Object? fromExternalOrganization = null,
    Object? isGroup = null,
    Object? isAnonymous = null,
    Object? checkInAt = freezed,
    Object? checkOutAt = freezed,
    Object? groupName = freezed,
    Object? averageAge = freezed,
    Object? groupCount = freezed,
    Object? participationCount = freezed,
    Object? womanPercentage = freezed,
    Object? manPercentage = freezed,
    Object? position = freezed,
  }) {
    return _then(_$EventUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      userCardProviderId: freezed == userCardProviderId
          ? _value.userCardProviderId
          : userCardProviderId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      cf: freezed == cf
          ? _value.cf
          : cf // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      privateId: freezed == privateId
          ? _value.privateId
          : privateId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromExternalOrganization: null == fromExternalOrganization
          ? _value.fromExternalOrganization
          : fromExternalOrganization // ignore: cast_nullable_to_non_nullable
              as bool,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      checkInAt: freezed == checkInAt
          ? _value.checkInAt
          : checkInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkOutAt: freezed == checkOutAt
          ? _value.checkOutAt
          : checkOutAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      averageAge: freezed == averageAge
          ? _value.averageAge
          : averageAge // ignore: cast_nullable_to_non_nullable
              as int?,
      groupCount: freezed == groupCount
          ? _value.groupCount
          : groupCount // ignore: cast_nullable_to_non_nullable
              as int?,
      participationCount: freezed == participationCount
          ? _value.participationCount
          : participationCount // ignore: cast_nullable_to_non_nullable
              as int?,
      womanPercentage: freezed == womanPercentage
          ? _value.womanPercentage
          : womanPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      manPercentage: freezed == manPercentage
          ? _value.manPercentage
          : manPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventUserImpl implements _EventUser {
  const _$EventUserImpl(
      {required this.id,
      required this.providerId,
      this.userCardProviderId,
      this.name,
      this.surname,
      this.cf,
      this.email,
      this.privateId,
      required this.fromExternalOrganization,
      required this.isGroup,
      required this.isAnonymous,
      @MyDateTimeConverter() this.checkInAt,
      @MyDateTimeConverter() this.checkOutAt,
      this.groupName,
      this.averageAge,
      this.groupCount,
      this.participationCount,
      this.womanPercentage,
      this.manPercentage,
      @GeoPointConverter() this.position});

  factory _$EventUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventUserImplFromJson(json);

  @override
  final String id;
  @override
  final String providerId;
  @override
  final String? userCardProviderId;
  @override
  final String? name;
  @override
  final String? surname;
  @override
  final String? cf;
  @override
  final String? email;
  @override
  final String? privateId;
  @override
  final bool fromExternalOrganization;
  @override
  final bool isGroup;
  @override
  final bool isAnonymous;
  @override
  @MyDateTimeConverter()
  final DateTime? checkInAt;
  @override
  @MyDateTimeConverter()
  final DateTime? checkOutAt;
  @override
  final String? groupName;
  @override
  final int? averageAge;
  @override
  final int? groupCount;
  @override
  final int? participationCount;
  @override
  final double? womanPercentage;
  @override
  final double? manPercentage;
  @override
  @GeoPointConverter()
  final GeoPoint? position;

  @override
  String toString() {
    return 'EventUser(id: $id, providerId: $providerId, userCardProviderId: $userCardProviderId, name: $name, surname: $surname, cf: $cf, email: $email, privateId: $privateId, fromExternalOrganization: $fromExternalOrganization, isGroup: $isGroup, isAnonymous: $isAnonymous, checkInAt: $checkInAt, checkOutAt: $checkOutAt, groupName: $groupName, averageAge: $averageAge, groupCount: $groupCount, participationCount: $participationCount, womanPercentage: $womanPercentage, manPercentage: $manPercentage, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.userCardProviderId, userCardProviderId) ||
                other.userCardProviderId == userCardProviderId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.cf, cf) || other.cf == cf) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.privateId, privateId) ||
                other.privateId == privateId) &&
            (identical(
                    other.fromExternalOrganization, fromExternalOrganization) ||
                other.fromExternalOrganization == fromExternalOrganization) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.checkInAt, checkInAt) ||
                other.checkInAt == checkInAt) &&
            (identical(other.checkOutAt, checkOutAt) ||
                other.checkOutAt == checkOutAt) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.averageAge, averageAge) ||
                other.averageAge == averageAge) &&
            (identical(other.groupCount, groupCount) ||
                other.groupCount == groupCount) &&
            (identical(other.participationCount, participationCount) ||
                other.participationCount == participationCount) &&
            (identical(other.womanPercentage, womanPercentage) ||
                other.womanPercentage == womanPercentage) &&
            (identical(other.manPercentage, manPercentage) ||
                other.manPercentage == manPercentage) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        providerId,
        userCardProviderId,
        name,
        surname,
        cf,
        email,
        privateId,
        fromExternalOrganization,
        isGroup,
        isAnonymous,
        checkInAt,
        checkOutAt,
        groupName,
        averageAge,
        groupCount,
        participationCount,
        womanPercentage,
        manPercentage,
        position
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventUserImplCopyWith<_$EventUserImpl> get copyWith =>
      __$$EventUserImplCopyWithImpl<_$EventUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventUserImplToJson(
      this,
    );
  }
}

abstract class _EventUser implements EventUser {
  const factory _EventUser(
      {required final String id,
      required final String providerId,
      final String? userCardProviderId,
      final String? name,
      final String? surname,
      final String? cf,
      final String? email,
      final String? privateId,
      required final bool fromExternalOrganization,
      required final bool isGroup,
      required final bool isAnonymous,
      @MyDateTimeConverter() final DateTime? checkInAt,
      @MyDateTimeConverter() final DateTime? checkOutAt,
      final String? groupName,
      final int? averageAge,
      final int? groupCount,
      final int? participationCount,
      final double? womanPercentage,
      final double? manPercentage,
      @GeoPointConverter() final GeoPoint? position}) = _$EventUserImpl;

  factory _EventUser.fromJson(Map<String, dynamic> json) =
      _$EventUserImpl.fromJson;

  @override
  String get id;
  @override
  String get providerId;
  @override
  String? get userCardProviderId;
  @override
  String? get name;
  @override
  String? get surname;
  @override
  String? get cf;
  @override
  String? get email;
  @override
  String? get privateId;
  @override
  bool get fromExternalOrganization;
  @override
  bool get isGroup;
  @override
  bool get isAnonymous;
  @override
  @MyDateTimeConverter()
  DateTime? get checkInAt;
  @override
  @MyDateTimeConverter()
  DateTime? get checkOutAt;
  @override
  String? get groupName;
  @override
  int? get averageAge;
  @override
  int? get groupCount;
  @override
  int? get participationCount;
  @override
  double? get womanPercentage;
  @override
  double? get manPercentage;
  @override
  @GeoPointConverter()
  GeoPoint? get position;
  @override
  @JsonKey(ignore: true)
  _$$EventUserImplCopyWith<_$EventUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
