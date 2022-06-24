// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthUserDTO _$$_AuthUserDTOFromJson(Map<String, dynamic> json) =>
    _$_AuthUserDTO(
      uid: json['uid'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      activityIds: (json['activityIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      emailVerified: json['emailVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_AuthUserDTOToJson(_$_AuthUserDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'activityIds': instance.activityIds,
      'emailVerified': instance.emailVerified,
      'createdAt': instance.createdAt.toIso8601String(),
    };
