// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserCard _$$_UserCardFromJson(Map<String, dynamic> json) => _$_UserCard(
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      cf: json['cf'] as String,
      email: json['email'] as String?,
      addedOn: json['addedOn'] == null
          ? null
          : DateTime.parse(json['addedOn'] as String),
    );

Map<String, dynamic> _$$_UserCardToJson(_$_UserCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'cf': instance.cf,
      'email': instance.email,
      'addedOn': instance.addedOn?.toIso8601String(),
    };
