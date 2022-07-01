// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Activity _$$_ActivityFromJson(Map<String, dynamic> json) => _$_Activity(
      id: json['id'] as String,
      name: json['name'] as String,
      domainRequirement: json['domainRequirement'] as String?,
      acceptPassepartout: json['acceptPassepartout'] as bool? ?? false,
      releaseWom: json['releaseWom'] as bool? ?? false,
      status: $enumDecodeNullable(_$ActivityStatusEnumMap, json['status']),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
      requestedOn: const MyDateTimeConverter()
          .fromJson(json['requestedOn'] as Timestamp),
    );

Map<String, dynamic> _$$_ActivityToJson(_$_Activity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domainRequirement': instance.domainRequirement,
      'acceptPassepartout': instance.acceptPassepartout,
      'releaseWom': instance.releaseWom,
      'status': _$ActivityStatusEnumMap[instance.status],
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
      'requestedOn': const MyDateTimeConverter().toJson(instance.requestedOn),
    };

const _$ActivityStatusEnumMap = {
  ActivityStatus.unknown: 'unknown',
  ActivityStatus.pending: 'pending',
  ActivityStatus.live: 'live',
  ActivityStatus.archived: 'archived',
};
