// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedDataImpl _$$EmbeddedDataImplFromJson(Map<String, dynamic> json) =>
    _$EmbeddedDataImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      radius: (json['radius'] as num).toInt(),
      updatedOn:
          const MyDateTimeConverter().fromJson(json['updatedOn'] as Timestamp),
      requestId: json['requestId'] as String?,
      eventName: json['eventName'] as String?,
      eventId: json['eventId'] as String?,
      sessionId: json['sessionId'] as String?,
      sessionName: json['sessionName'] as String?,
      isStatic: json['isStatic'] as bool? ?? false,
      dedicated: json['dedicated'] as bool? ?? false,
      count: (json['count'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const MyDateTimeConverter().fromJson),
      position: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['position'], const GeoPointConverter().fromJson),
      metadata: json['metadata'] == null
          ? null
          : EmbeddedMetaData.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmbeddedDataImplToJson(_$EmbeddedDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'radius': instance.radius,
      'updatedOn': const MyDateTimeConverter().toJson(instance.updatedOn),
      'requestId': instance.requestId,
      'eventName': instance.eventName,
      'eventId': instance.eventId,
      'sessionId': instance.sessionId,
      'sessionName': instance.sessionName,
      'isStatic': instance.isStatic,
      'dedicated': instance.dedicated,
      'count': instance.count,
      'totalCount': instance.totalCount,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const MyDateTimeConverter().toJson),
      'position': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.position, const GeoPointConverter().toJson),
      'metadata': instance.metadata?.toJson(),
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

_$EmbeddedMetaDataImpl _$$EmbeddedMetaDataImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedMetaDataImpl(
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$$EmbeddedMetaDataImplToJson(
        _$EmbeddedMetaDataImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
