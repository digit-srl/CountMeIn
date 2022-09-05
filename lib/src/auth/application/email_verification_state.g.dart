// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EmailVerificationData _$$_EmailVerificationDataFromJson(
        Map<String, dynamic> json) =>
    _$_EmailVerificationData(
      secret: json['secret'] as String,
      userId: json['userId'] as String,
      providerId: json['providerId'] as String,
    );

Map<String, dynamic> _$$_EmailVerificationDataToJson(
        _$_EmailVerificationData instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'userId': instance.userId,
      'providerId': instance.providerId,
    };
