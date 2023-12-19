// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailVerificationDataImpl _$$EmailVerificationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$EmailVerificationDataImpl(
      secret: json['secret'] as String,
      userId: json['userId'] as String,
      providerId: json['providerId'] as String,
    );

Map<String, dynamic> _$$EmailVerificationDataImplToJson(
        _$EmailVerificationDataImpl instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'userId': instance.userId,
      'providerId': instance.providerId,
    };
