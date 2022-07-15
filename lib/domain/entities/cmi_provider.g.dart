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
      womApiKey: json['womApiKey'] as String?,
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
      'womApiKey': instance.womApiKey,
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
