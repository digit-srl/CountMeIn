// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MUUserDTO _$$_MUUserDTOFromJson(Map<String, dynamic> json) => _$_MUUserDTO(
      uid: json['uid'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_MUUserDTOToJson(_$_MUUserDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'createdAt': instance.createdAt.toIso8601String(),
    };
