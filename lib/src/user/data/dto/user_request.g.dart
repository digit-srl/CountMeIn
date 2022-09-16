// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserRequest _$$_UserRequestFromJson(Map<String, dynamic> json) =>
    _$_UserRequest(
      name: json['name'] as String,
      surname: json['surname'] as String,
      cf: json['cf'] as String,
      email: json['email'] as String,
      providerId: json['providerId'] as String,
      providerName: json['providerName'] as String,
    );

Map<String, dynamic> _$$_UserRequestToJson(_$_UserRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'cf': instance.cf,
      'email': instance.email,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
    };
