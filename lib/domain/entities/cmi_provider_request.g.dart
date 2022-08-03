// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cmi_provider_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CMIProviderRequest _$$_CMIProviderRequestFromJson(
        Map<String, dynamic> json) =>
    _$_CMIProviderRequest(
      id: json['id'] as String,
      adminName: json['adminName'] as String,
      adminSurname: json['adminSurname'] as String,
      adminEmail: json['adminEmail'] as String,
      adminCF: json['adminCF'] as String,
      name: json['name'] as String,
      releaseWom: json['releaseWom'] as bool,
      pIva: json['pIva'] as String,
      status:
          const CMIProviderStatusConverter().fromJson(json['status'] as String),
      womApiKey: json['womApiKey'] as String?,
      aims: (json['aims'] as List<dynamic>?)?.map((e) => e as String).toList(),
      domainRequirement: json['domainRequirement'] as String?,
      requestedOn: const MyDateTimeConverter()
          .fromJson(json['requestedOn'] as Timestamp),
    );

Map<String, dynamic> _$$_CMIProviderRequestToJson(
        _$_CMIProviderRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adminName': instance.adminName,
      'adminSurname': instance.adminSurname,
      'adminEmail': instance.adminEmail,
      'adminCF': instance.adminCF,
      'name': instance.name,
      'releaseWom': instance.releaseWom,
      'pIva': instance.pIva,
      'status': const CMIProviderStatusConverter().toJson(instance.status),
      'womApiKey': instance.womApiKey,
      'aims': instance.aims,
      'domainRequirement': instance.domainRequirement,
      'requestedOn': const MyDateTimeConverter().toJson(instance.requestedOn),
    };
