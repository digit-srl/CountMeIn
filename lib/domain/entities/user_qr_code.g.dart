// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserQrCodeImpl _$$UserQrCodeImplFromJson(Map<String, dynamic> json) =>
    _$UserQrCodeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      cf: json['cf'] as String,
      activityId: json['activityId'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$UserQrCodeImplToJson(_$UserQrCodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'cf': instance.cf,
      'activityId': instance.activityId,
      'email': instance.email,
    };
