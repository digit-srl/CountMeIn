// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCardImpl _$$UserCardImplFromJson(Map<String, dynamic> json) =>
    _$UserCardImpl(
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

Map<String, dynamic> _$$UserCardImplToJson(_$UserCardImpl instance) =>
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

_$EventUserImpl _$$EventUserImplFromJson(Map<String, dynamic> json) =>
    _$EventUserImpl(
      id: json['id'] as String,
      providerId: json['providerId'] as String,
      userCardProviderId: json['userCardProviderId'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      cf: json['cf'] as String?,
      email: json['email'] as String?,
      privateId: json['privateId'] as String?,
      fromExternalOrganization: json['fromExternalOrganization'] as bool,
      isGroup: json['isGroup'] as bool,
      isAnonymous: json['isAnonymous'] as bool,
      checkInAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['checkInAt'], const MyDateTimeConverter().fromJson),
      checkOutAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['checkOutAt'], const MyDateTimeConverter().fromJson),
      groupName: json['groupName'] as String?,
      averageAge: json['averageAge'] as int?,
      groupCount: json['groupCount'] as int?,
      participationCount: json['participationCount'] as int?,
      womanPercentage: (json['womanPercentage'] as num?)?.toDouble(),
      manPercentage: (json['manPercentage'] as num?)?.toDouble(),
      position: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['position'], const GeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$EventUserImplToJson(_$EventUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'providerId': instance.providerId,
      'userCardProviderId': instance.userCardProviderId,
      'name': instance.name,
      'surname': instance.surname,
      'cf': instance.cf,
      'email': instance.email,
      'privateId': instance.privateId,
      'fromExternalOrganization': instance.fromExternalOrganization,
      'isGroup': instance.isGroup,
      'isAnonymous': instance.isAnonymous,
      'checkInAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.checkInAt, const MyDateTimeConverter().toJson),
      'checkOutAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.checkOutAt, const MyDateTimeConverter().toJson),
      'groupName': instance.groupName,
      'averageAge': instance.averageAge,
      'groupCount': instance.groupCount,
      'participationCount': instance.participationCount,
      'womanPercentage': instance.womanPercentage,
      'manPercentage': instance.manPercentage,
      'position': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.position, const GeoPointConverter().toJson),
    };
