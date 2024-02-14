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
    String? requestId,
    String? eventId,
    String? sessionId,
    required int radius,
    @Default(false) bool isStatic,
    @Default(false) bool dedicated,
    @Default(0) int count,
    @Default(0) int totalCount,
    @MyDateTimeConverter() required DateTime updatedOn,
    @GeoPointConverter() GeoPoint? position,
  }) = _EmbeddedData;

  factory EmbeddedData.fromJson(Map<String, dynamic> json) =>
      _$EmbeddedDataFromJson(json);
}
