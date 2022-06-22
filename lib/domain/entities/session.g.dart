// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Session _$$_SessionFromJson(Map<String, dynamic> json) => _$_Session(
      id: json['id'] as String,
      name: json['name'] as String,
      status: $enumDecodeNullable(_$SessionsStatusEnumMap, json['status']),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
    );

Map<String, dynamic> _$$_SessionToJson(_$_Session instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$SessionsStatusEnumMap[instance.status],
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
    };

const _$SessionsStatusEnumMap = {
  SessionsStatus.unknown: 'unknown',
  SessionsStatus.live: 'live',
  SessionsStatus.archived: 'archived',
};
