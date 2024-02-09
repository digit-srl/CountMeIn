// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedDataImpl _$$EmbeddedDataImplFromJson(Map<String, dynamic> json) =>
    _$EmbeddedDataImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      requestId: json['requestId'] as String?,
      eventId: json['eventId'] as String?,
      sessionId: json['sessionId'] as String?,
      radius: json['radius'] as int,
      isStatic: json['isStatic'] as bool? ?? false,
      count: json['count'] as int? ?? 0,
      totalCount: json['totalCount'] as int? ?? 0,
      updatedOn:
          const MyDateTimeConverter().fromJson(json['updatedOn'] as Timestamp),
      position: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['position'], const GeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$EmbeddedDataImplToJson(_$EmbeddedDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'requestId': instance.requestId,
      'eventId': instance.eventId,
      'sessionId': instance.sessionId,
      'radius': instance.radius,
      'isStatic': instance.isStatic,
      'count': instance.count,
      'totalCount': instance.totalCount,
      'updatedOn': const MyDateTimeConverter().toJson(instance.updatedOn),
      'position': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.position, const GeoPointConverter().toJson),
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
