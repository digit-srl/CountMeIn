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
            MapEntry(k, ProviderManager.fromJson(e as Map<String, dynamic>)),
      ),
      apiKey: json['apiKey'] as String?,
      aims: (json['aims'] as List<dynamic>?)?.map((e) => e as String).toList(),
      aim: json['aim'] as String?,
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
      'aim': instance.aim,
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

_$_PendingProviderManager _$$_PendingProviderManagerFromJson(
        Map<String, dynamic> json) =>
    _$_PendingProviderManager(
      id: json['id'] as String,
      role: const UserRoleConverter().fromJson(json['role'] as String?),
      name: json['name'] as String,
      secret: json['secret'] as String,
      providerName: json['providerName'] as String,
      email: json['email'] as String,
      invitedOn:
          const MyDateTimeConverter().fromJson(json['invitedOn'] as Timestamp),
      status: const ManagerStatusConverter().fromJson(json['status'] as String),
    );

Map<String, dynamic> _$$_PendingProviderManagerToJson(
        _$_PendingProviderManager instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': const UserRoleConverter().toJson(instance.role),
      'name': instance.name,
      'secret': instance.secret,
      'providerName': instance.providerName,
      'email': instance.email,
      'invitedOn': const MyDateTimeConverter().toJson(instance.invitedOn),
      'status': const ManagerStatusConverter().toJson(instance.status),
    };

_$_ProviderManager _$$_ProviderManagerFromJson(Map<String, dynamic> json) =>
    _$_ProviderManager(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: const UserRoleConverter().fromJson(json['role'] as String?),
    );

Map<String, dynamic> _$$_ProviderManagerToJson(_$_ProviderManager instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': const UserRoleConverter().toJson(instance.role),
    };
