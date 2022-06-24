import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'date_time_converter.dart';

part 'session.freezed.dart';

part 'session.g.dart';

enum EventStatus { unknown, live, archived }

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String name,
    @EventStatusConverter() EventStatus? status,
    @MyDateTimeConverter() required DateTime createdOn,
  }) = _Event;

  factory Event.fromJson(Map<String, Object?> json) =>
      _$EventFromJson(json);
}



class EventStatusConverter implements JsonConverter<EventStatus, String> {
  const EventStatusConverter();

  @override
  EventStatus fromJson(String? status) {
    if(status == null){
      return EventStatus.unknown;
    }
    return enumFromString(status, EventStatus.values);
  }

  @override
  String toJson(EventStatus status) => enumToString(status);
}
