// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'] as String,
      name: json['name'] as String,
      acceptPassepartout: json['acceptPassepartout'] as bool? ?? true,
      womCount: json['womCount'] as int?,
      isOpen: json['isOpen'] as bool? ?? true,
      status: _$JsonConverterFromJson<String, EventStatus>(
          json['status'], const EventStatusConverter().fromJson),
      createdOn:
          const MyDateTimeConverter().fromJson(json['createdOn'] as Timestamp),
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'acceptPassepartout': instance.acceptPassepartout,
      'womCount': instance.womCount,
      'isOpen': instance.isOpen,
      'status': _$JsonConverterToJson<String, EventStatus>(
          instance.status, const EventStatusConverter().toJson),
      'createdOn': const MyDateTimeConverter().toJson(instance.createdOn),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
