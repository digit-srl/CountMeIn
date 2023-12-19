// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserDTOImpl _$$AuthUserDTOImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserDTOImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      temporaryPassword: json['temporaryPassword'] as bool? ?? true,
      role: const CMIRoleConverter().fromJson(json['role'] as String?),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
    );

Map<String, dynamic> _$$AuthUserDTOImplToJson(_$AuthUserDTOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'temporaryPassword': instance.temporaryPassword,
      'role': const CMIRoleConverter().toJson(instance.role),
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
    };
