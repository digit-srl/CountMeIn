// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserCard _$$_UserCardFromJson(Map<String, dynamic> json) => _$_UserCard(
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      cf: json['cf'] as String,
      email: json['email'] as String?,
      secret: json['secret'] as String?,
      gender: json['gender'] as String?,
      addedOn: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['addedOn'], const MyDateTimeConverter().fromJson),
      emailVerified: json['emailVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserCardToJson(_$_UserCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'cf': instance.cf,
      'email': instance.email,
      'secret': instance.secret,
      'gender': instance.gender,
      'addedOn': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.addedOn, const MyDateTimeConverter().toJson),
      'emailVerified': instance.emailVerified,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$_EventUser _$$_EventUserFromJson(Map<String, dynamic> json) => _$_EventUser(
      id: json['id'] as String,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      cf: json['cf'] as String?,
      email: json['email'] as String?,
      checkInAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['checkInAt'], const MyDateTimeConverter().fromJson),
      checkOutAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['checkOutAt'], const MyDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$_EventUserToJson(_$_EventUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'cf': instance.cf,
      'email': instance.email,
      'checkInAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.checkInAt, const MyDateTimeConverter().toJson),
      'checkOutAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.checkOutAt, const MyDateTimeConverter().toJson),
    };
