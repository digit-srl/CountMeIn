// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cmi_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CMIProvider _$$_CMIProviderFromJson(Map<String, dynamic> json) =>
    _$_CMIProvider(
      id: json['id'] as String,
      name: json['name'] as String,
      adminName: json['adminName'] as String,
      adminSurname: json['adminSurname'] as String,
      adminEmail: json['adminEmail'] as String,
      managers: (json['managers'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, ProviderManagerDTO.fromJson(e as Map<String, dynamic>)),
      ),
      apiKey: json['apiKey'] as String?,
      aims: (json['aims'] as List<dynamic>?)?.map((e) => e as String).toList(),
      domainRequirement: json['domainRequirement'] as String?,
      releaseWom: json['releaseWom'] as bool? ?? false,
      status: _$JsonConverterFromJson<String, CMIProviderStatus>(
          json['status'], const CMIProviderStatusConverter().fromJson),
      createdOn: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdOn'], const MyDateTimeConverter().fromJson),
      requestedOn: const MyDateTimeConverter()
          .fromJson(json['requestedOn'] as Timestamp),
    );

Map<String, dynamic> _$$_CMIProviderToJson(_$_CMIProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adminName': instance.adminName,
      'adminSurname': instance.adminSurname,
      'adminEmail': instance.adminEmail,
      'managers': instance.managers,
      'apiKey': instance.apiKey,
      'aims': instance.aims,
      'domainRequirement': instance.domainRequirement,
      'releaseWom': instance.releaseWom,
      'status': _$JsonConverterToJson<String, CMIProviderStatus>(
          instance.status, const CMIProviderStatusConverter().toJson),
      'createdOn': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdOn, const MyDateTimeConverter().toJson),
      'requestedOn': const MyDateTimeConverter().toJson(instance.requestedOn),
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

_$_ProviderManagerDTO _$$_ProviderManagerDTOFromJson(
        Map<String, dynamic> json) =>
    _$_ProviderManagerDTO(
      name: json['name'] as String,
      invitedOn: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['invitedOn'], const MyDateTimeConverter().fromJson),
      status: const ManagerStatusConverter().fromJson(json['status'] as String),
    );

Map<String, dynamic> _$$_ProviderManagerDTOToJson(
        _$_ProviderManagerDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'invitedOn': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.invitedOn, const MyDateTimeConverter().toJson),
      'status': const ManagerStatusConverter().toJson(instance.status),
    };
