// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedDataImpl _$$EmbeddedDataImplFromJson(Map<String, dynamic> json) =>
    _$EmbeddedDataImpl(
      id: json['id'] as String,
      requestId: json['requestId'] as String,
      count: json['count'] as int? ?? 0,
      updatedOn:
          const MyDateTimeConverter().fromJson(json['updatedOn'] as Timestamp),
    );

Map<String, dynamic> _$$EmbeddedDataImplToJson(_$EmbeddedDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestId': instance.requestId,
      'count': instance.count,
      'updatedOn': const MyDateTimeConverter().toJson(instance.updatedOn),
    };
