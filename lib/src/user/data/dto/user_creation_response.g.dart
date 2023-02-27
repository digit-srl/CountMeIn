// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserCreationResponse _$$_UserCreationResponseFromJson(
        Map<String, dynamic> json) =>
    _$_UserCreationResponse(
      status: json['status'] as String,
      cf: json['cf'] as String,
      userId: json['userId'] as String?,
      emailVerified: json['emailVerified'] as bool?,
    );

Map<String, dynamic> _$$_UserCreationResponseToJson(
        _$_UserCreationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'cf': instance.cf,
      'userId': instance.userId,
      'emailVerified': instance.emailVerified,
    };
