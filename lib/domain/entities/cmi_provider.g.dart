// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cmi_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CMIProvider _$$_CMIProviderFromJson(Map<String, dynamic> json) =>
    _$_CMIProvider(
      id: json['id'] as String,
      name: json['name'] as String,
      domainRequirement: json['domainRequirement'] as String?,
      acceptPassepartout: json['acceptPassepartout'] as bool? ?? false,
      releaseWom: json['releaseWom'] as bool? ?? false,
      status: $enumDecodeNullable(_$CMIProviderStatusEnumMap, json['status']),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
      requestedOn: const MyDateTimeConverter()
          .fromJson(json['requestedOn'] as Timestamp),
    );

Map<String, dynamic> _$$_CMIProviderToJson(_$_CMIProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domainRequirement': instance.domainRequirement,
      'acceptPassepartout': instance.acceptPassepartout,
      'releaseWom': instance.releaseWom,
      'status': _$CMIProviderStatusEnumMap[instance.status],
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
      'requestedOn': const MyDateTimeConverter().toJson(instance.requestedOn),
    };

const _$CMIProviderStatusEnumMap = {
  CMIProviderStatus.unknown: 'unknown',
  CMIProviderStatus.pending: 'pending',
  CMIProviderStatus.live: 'live',
  CMIProviderStatus.archived: 'archived',
};
