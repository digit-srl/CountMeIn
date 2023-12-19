// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cmi_provider_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CMIProviderRequestImpl _$$CMIProviderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CMIProviderRequestImpl(
      id: json['id'] as String,
      adminName: json['adminName'] as String,
      adminSurname: json['adminSurname'] as String,
      adminEmail: json['adminEmail'] as String,
      adminCf: json['adminCf'] as String,
      name: json['name'] as String,
      aim: json['aim'] as String,
      releaseWom: json['releaseWom'] as bool,
      pIva: json['pIva'] as String,
      managers: (json['managers'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ProviderManager.fromJson(e as Map<String, dynamic>)),
      ),
      status:
          const CMIProviderStatusConverter().fromJson(json['status'] as String),
      apiKey: json['apiKey'] as String?,
      aims: (json['aims'] as List<dynamic>?)?.map((e) => e as String).toList(),
      domainRequirement: json['domainRequirement'] as String?,
      requestedOn: const MyDateTimeConverter()
          .fromJson(json['requestedOn'] as Timestamp),
    );

Map<String, dynamic> _$$CMIProviderRequestImplToJson(
        _$CMIProviderRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adminName': instance.adminName,
      'adminSurname': instance.adminSurname,
      'adminEmail': instance.adminEmail,
      'adminCf': instance.adminCf,
      'name': instance.name,
      'aim': instance.aim,
      'releaseWom': instance.releaseWom,
      'pIva': instance.pIva,
      'managers': instance.managers,
      'status': const CMIProviderStatusConverter().toJson(instance.status),
      'apiKey': instance.apiKey,
      'aims': instance.aims,
      'domainRequirement': instance.domainRequirement,
      'requestedOn': const MyDateTimeConverter().toJson(instance.requestedOn),
    };
