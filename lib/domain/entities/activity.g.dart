// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Activity _$$_ActivityFromJson(Map<String, dynamic> json) => _$_Activity(
      id: json['id'] as String,
      name: json['name'] as String,
      status: $enumDecodeNullable(_$ActivityStatusEnumMap, json['status']),
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      requestedOn: const MyDateTimeConverter()
          .fromJson(json['requestedOn'] as Timestamp),
    );

Map<String, dynamic> _$$_ActivityToJson(_$_Activity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$ActivityStatusEnumMap[instance.status],
      'createdOn': instance.createdOn?.toIso8601String(),
      'requestedOn': const MyDateTimeConverter().toJson(instance.requestedOn),
    };

const _$ActivityStatusEnumMap = {
  ActivityStatus.unknown: 'unknown',
  ActivityStatus.pending: 'pending',
  ActivityStatus.live: 'live',
  ActivityStatus.archived: 'archived',
};
