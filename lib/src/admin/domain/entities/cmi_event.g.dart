// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cmi_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CMIEvent _$$_CMIEventFromJson(Map<String, dynamic> json) => _$_CMIEvent(
      id: json['id'] as String,
      name: json['name'] as String,
      acceptPassepartout: json['acceptPassepartout'] as bool? ?? true,
      anonymous: json['anonymous'] as bool? ?? true,
      recurring: json['recurring'] as bool? ?? true,
      emailShowed: json['emailShowed'] as bool? ?? false,
      frequency:
          const FrequencyTypeConverter().fromJson(json['frequency'] as String?),
      recurrence: json['recurrence'] as int?,
      remaining: json['remaining'] as int?,
      totalUsers: json['totalUsers'] as int? ?? 0,
      genderCount: json['genderCount'] == null
          ? null
          : GenderCount.fromJson(json['genderCount'] as Map<String, dynamic>),
      activeSessionId: json['activeSessionId'] as String?,
      accessType: $enumDecode(_$EventAccessTypeEnumMap, json['accessType']),
      maxWomCount: json['maxWomCount'] as int,
      status: _$JsonConverterFromJson<String, EventStatus>(
          json['status'], const EventStatusConverter().fromJson),
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      acceptedCardType: json['acceptedCardType'] == null
          ? AcceptedCardType.passpartoutAndMine
          : const AcceptedCardTypeConverted()
              .fromJson(json['acceptedCardType'] as String?),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
      subEventDeadline: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['subEventDeadline'], const MyDateTimeConverter().fromJson),
      startAt:
          const MyDateTimeConverter().fromJson(json['startAt'] as Timestamp),
    );

Map<String, dynamic> _$$_CMIEventToJson(_$_CMIEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'acceptPassepartout': instance.acceptPassepartout,
      'anonymous': instance.anonymous,
      'recurring': instance.recurring,
      'emailShowed': instance.emailShowed,
      'frequency': const FrequencyTypeConverter().toJson(instance.frequency),
      'recurrence': instance.recurrence,
      'remaining': instance.remaining,
      'totalUsers': instance.totalUsers,
      'genderCount': instance.genderCount,
      'activeSessionId': instance.activeSessionId,
      'accessType': _$EventAccessTypeEnumMap[instance.accessType]!,
      'maxWomCount': instance.maxWomCount,
      'status': _$JsonConverterToJson<String, EventStatus>(
          instance.status, const EventStatusConverter().toJson),
      'type': _$EventTypeEnumMap[instance.type]!,
      'acceptedCardType':
          const AcceptedCardTypeConverted().toJson(instance.acceptedCardType),
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
      'subEventDeadline': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.subEventDeadline, const MyDateTimeConverter().toJson),
      'startAt': const MyDateTimeConverter().toJson(instance.startAt),
    };

const _$EventAccessTypeEnumMap = {
  EventAccessType.single: 'single',
  EventAccessType.inOut: 'inOut',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$EventTypeEnumMap = {
  EventType.manual: 'manual',
  EventType.periodic: 'periodic',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$_CMISubEvent _$$_CMISubEventFromJson(Map<String, dynamic> json) =>
    _$_CMISubEvent(
      id: json['id'] as String,
      name: json['name'] as String?,
      genderCount: json['genderCount'] == null
          ? null
          : GenderCount.fromJson(json['genderCount'] as Map<String, dynamic>),
      totalUsers: json['totalUsers'] as int? ?? 0,
      startAt:
          const MyDateTimeConverter().fromJson(json['startAt'] as Timestamp),
      endAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['endAt'], const MyDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$_CMISubEventToJson(_$_CMISubEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genderCount': instance.genderCount,
      'totalUsers': instance.totalUsers,
      'startAt': const MyDateTimeConverter().toJson(instance.startAt),
      'endAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.endAt, const MyDateTimeConverter().toJson),
    };

_$_GenderCount _$$_GenderCountFromJson(Map<String, dynamic> json) =>
    _$_GenderCount(
      male: json['male'] as int,
      female: json['female'] as int,
      notBinary: json['notBinary'] as int,
      notAvailable: json['notAvailable'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GenderCountToJson(_$_GenderCount instance) =>
    <String, dynamic>{
      'male': instance.male,
      'female': instance.female,
      'notBinary': instance.notBinary,
      'notAvailable': instance.notAvailable,
    };
