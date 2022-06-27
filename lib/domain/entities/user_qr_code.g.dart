// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserQrCode _$$_UserQrCodeFromJson(Map<String, dynamic> json) =>
    _$_UserQrCode(
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      cf: json['cf'] as String,
      activityId: json['activityId'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_UserQrCodeToJson(_$_UserQrCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'cf': instance.cf,
      'activityId': instance.activityId,
      'email': instance.email,
    };
