// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedDataImpl _$$EmbeddedDataImplFromJson(Map<String, dynamic> json) =>
    _$EmbeddedDataImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      requestId: json['requestId'] as String,
      radius: json['radius'] as int,
      count: json['count'] as int? ?? 0,
      updatedOn:
          const MyDateTimeConverter().fromJson(json['updatedOn'] as Timestamp),
      position:
          const GeoPointConverter().fromJson(json['position'] as GeoPoint),
    );

Map<String, dynamic> _$$EmbeddedDataImplToJson(_$EmbeddedDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'requestId': instance.requestId,
      'radius': instance.radius,
      'count': instance.count,
      'updatedOn': const MyDateTimeConverter().toJson(instance.updatedOn),
      'position': const GeoPointConverter().toJson(instance.position),
    };
