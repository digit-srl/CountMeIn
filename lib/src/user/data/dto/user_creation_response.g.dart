// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCreationResponseImpl _$$UserCreationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserCreationResponseImpl(
      status: json['status'] as String,
      cf: json['cf'] as String,
      userId: json['userId'] as String?,
      emailVerified: json['emailVerified'] as bool?,
    );

Map<String, dynamic> _$$UserCreationResponseImplToJson(
        _$UserCreationResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'cf': instance.cf,
      'userId': instance.userId,
      'emailVerified': instance.emailVerified,
    };
