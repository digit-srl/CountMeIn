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
      emailVerified: json['emailVerified'] as bool,
      providersRole: (json['providersRole'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
    );

Map<String, dynamic> _$$_AuthUserDTOToJson(_$_AuthUserDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'providersRole': instance.providersRole,
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
    };
