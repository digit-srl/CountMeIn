import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/domain/entities/date_time_converter.dart';
import 'package:countmein/domain/entities/geopoint_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'embedded_data.freezed.dart';

part 'embedded_data.g.dart';

@freezed
class EmbeddedData with _$EmbeddedData {
  const factory EmbeddedData({
    required String name,
    required String id,
    required String requestId,
    required int radius,
    @Default(0) int count,
    @MyDateTimeConverter() required DateTime updatedOn,
    @GeoPointConverter() required GeoPoint position,
  }) = _EmbeddedData;

  factory EmbeddedData.fromJson(Map<String, dynamic> json) =>
      _$EmbeddedDataFromJson(json);
}
