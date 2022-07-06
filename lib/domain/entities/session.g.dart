// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'] as String,
      name: json['name'] as String,
      womCount: json['womCount'] as int?,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'womCount': instance.womCount,
      'status': _$EventStatusEnumMap[instance.status],
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
    };

const _$EventStatusEnumMap = {
  EventStatus.unknown: 'unknown',
  EventStatus.live: 'live',
  EventStatus.archived: 'archived',
};
