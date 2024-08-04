// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cmi_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CMIEventImpl _$$CMIEventImplFromJson(Map<String, dynamic> json) =>
    _$CMIEventImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      accessType: $enumDecode(_$EventAccessTypeEnumMap, json['accessType']),
      maxWomCount: (json['maxWomCount'] as num).toInt(),
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
      startAt:
          const MyDateTimeConverter().fromJson(json['startAt'] as Timestamp),
      acceptPassepartout: json['acceptPassepartout'] as bool? ?? true,
      anonymous: json['anonymous'] as bool? ?? true,
      recurring: json['recurring'] as bool? ?? true,
      mutexTotemsEnabled: json['mutexTotemsEnabled'] as bool? ?? true,
      emailShowed: json['emailShowed'] as bool? ?? false,
      dynamicActivation: json['dynamicActivation'] as bool? ?? false,
      frequency:
          const FrequencyTypeConverter().fromJson(json['frequency'] as String?),
      recurrence: (json['recurrence'] as num?)?.toInt(),
      remaining: (json['remaining'] as num?)?.toInt(),
      totalUsers: json['totalUsers'] as num? ?? 0,
      genderCount: json['genderCount'] == null
          ? null
          : GenderCount.fromJson(json['genderCount'] as Map<String, dynamic>),
      activeSessionId: json['activeSessionId'] as String?,
      aim: json['aim'] as String?,
      managers: (json['managers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      status: _$JsonConverterFromJson<String, EventStatus>(
          json['status'], const EventStatusConverter().fromJson),
      acceptedCardType: json['acceptedCardType'] == null
          ? AcceptedCardType.passpartoutAndMine
          : const AcceptedCardTypeConverted()
              .fromJson(json['acceptedCardType'] as String?),
      subEventDeadline: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['subEventDeadline'], const MyDateTimeConverter().fromJson),
      position: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['position'], const GeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$CMIEventImplToJson(_$CMIEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'accessType': _$EventAccessTypeEnumMap[instance.accessType]!,
      'maxWomCount': instance.maxWomCount,
      'type': _$EventTypeEnumMap[instance.type]!,
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
      'startAt': const MyDateTimeConverter().toJson(instance.startAt),
      'acceptPassepartout': instance.acceptPassepartout,
      'anonymous': instance.anonymous,
      'recurring': instance.recurring,
      'mutexTotemsEnabled': instance.mutexTotemsEnabled,
      'emailShowed': instance.emailShowed,
      'dynamicActivation': instance.dynamicActivation,
      'frequency': const FrequencyTypeConverter().toJson(instance.frequency),
      'recurrence': instance.recurrence,
      'remaining': instance.remaining,
      'totalUsers': instance.totalUsers,
      'genderCount': instance.genderCount,
      'activeSessionId': instance.activeSessionId,
      'aim': instance.aim,
      'managers': instance.managers,
      'status': _$JsonConverterToJson<String, EventStatus>(
          instance.status, const EventStatusConverter().toJson),
      'acceptedCardType':
          const AcceptedCardTypeConverted().toJson(instance.acceptedCardType),
      'subEventDeadline': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.subEventDeadline, const MyDateTimeConverter().toJson),
      'position': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.position, const GeoPointConverter().toJson),
    };

const _$EventAccessTypeEnumMap = {
  EventAccessType.single: 'single',
  EventAccessType.inOut: 'inOut',
};

const _$EventTypeEnumMap = {
  EventType.manual: 'manual',
  EventType.periodic: 'periodic',
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

_$CMISubEventImpl _$$CMISubEventImplFromJson(Map<String, dynamic> json) =>
    _$CMISubEventImpl(
      id: json['id'] as String,
      startAt:
          const MyDateTimeConverter().fromJson(json['startAt'] as Timestamp),
      name: json['name'] as String?,
      genderCount: json['genderCount'] == null
          ? null
          : GenderCount.fromJson(json['genderCount'] as Map<String, dynamic>),
      totalUsers: json['totalUsers'] as num? ?? 0,
      endAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['endAt'], const MyDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$CMISubEventImplToJson(_$CMISubEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startAt': const MyDateTimeConverter().toJson(instance.startAt),
      'name': instance.name,
      'genderCount': instance.genderCount,
      'totalUsers': instance.totalUsers,
      'endAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.endAt, const MyDateTimeConverter().toJson),
    };

_$GenderCountImpl _$$GenderCountImplFromJson(Map<String, dynamic> json) =>
    _$GenderCountImpl(
      male: json['male'] as num,
      female: json['female'] as num,
      notBinary: json['notBinary'] as num,
      notAvailable: json['notAvailable'] as num? ?? 0,
    );

Map<String, dynamic> _$$GenderCountImplToJson(_$GenderCountImpl instance) =>
    <String, dynamic>{
      'male': instance.male,
      'female': instance.female,
      'notBinary': instance.notBinary,
      'notAvailable': instance.notAvailable,
    };
