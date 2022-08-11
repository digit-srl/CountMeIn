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
      isOpen: json['isOpen'] as bool? ?? true,
      frequency:
          const FrequencyTypeConverter().fromJson(json['frequency'] as String?),
      recurrence: json['recurrence'] as int?,
      remaining: json['remaining'] as int?,
      currentSubEvent: json['currentSubEvent'] as String?,
      accessType: $enumDecode(_$EventAccessTypeEnumMap, json['accessType']),
      maxWomCount: json['maxWomCount'] as int,
      status: _$JsonConverterFromJson<String, EventStatus>(
          json['status'], const EventStatusConverter().fromJson),
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
      'isOpen': instance.isOpen,
      'frequency': const FrequencyTypeConverter().toJson(instance.frequency),
      'recurrence': instance.recurrence,
      'remaining': instance.remaining,
      'currentSubEvent': instance.currentSubEvent,
      'accessType': _$EventAccessTypeEnumMap[instance.accessType]!,
      'maxWomCount': instance.maxWomCount,
      'status': _$JsonConverterToJson<String, EventStatus>(
          instance.status, const EventStatusConverter().toJson),
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

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$_CMISubEvent _$$_CMISubEventFromJson(Map<String, dynamic> json) =>
    _$_CMISubEvent(
      id: json['id'] as String,
      startAt:
          const MyDateTimeConverter().fromJson(json['startAt'] as Timestamp),
      endAt: const MyDateTimeConverter().fromJson(json['endAt'] as Timestamp),
    );

Map<String, dynamic> _$$_CMISubEventToJson(_$_CMISubEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startAt': const MyDateTimeConverter().toJson(instance.startAt),
      'endAt': const MyDateTimeConverter().toJson(instance.endAt),
    };
