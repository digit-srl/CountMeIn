import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/domain/entities/date_time_converter.dart';
import 'package:countmein/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cmi_event.freezed.dart';

part 'cmi_event.g.dart';

enum EventAccessType { single, inOut }

enum FrequencyType { daily, monthly, yearly }

enum EventStatus { unknown, live, archived, closed}

enum CMIEventType { standard, mailingList, counter, recurring }

extension FrequencyTypeX on FrequencyType {
  int get multiplier {
    switch (this) {
      case FrequencyType.daily:
        return 1;
      case FrequencyType.monthly:
        return 31;
      case FrequencyType.yearly:
        return 365;
    }
  }
}

@freezed
class CMIEvent with _$CMIEvent {
  const factory CMIEvent({
    required String id,
    required String name,
    @Default(true) bool acceptPassepartout,
    @Default(true) bool anonymous,
    @Default(true) bool recurring,
    @Default(true) bool isOpen,
    @FrequencyTypeConverter() FrequencyType? frequency,
    int? recurrence,
    int? remaining,
    String? currentSubEvent,
    @EventAccessTypeConverter() required EventAccessType accessType,
    required int maxWomCount,
    @EventStatusConverter() EventStatus? status,
    @MyDateTimeConverter() required DateTime createdOn,
    @MyDateTimeConverter() DateTime? subEventDeadline,
    @MyDateTimeConverter() required DateTime startAt,
  }) = _CMIEvent;

  factory CMIEvent.fromJson(Map<String, Object?> json) =>
      _$CMIEventFromJson(json);
}

@freezed
class CMISubEvent with _$CMISubEvent {
  const factory CMISubEvent({
    required String id,
    @MyDateTimeConverter() required DateTime startAt,
    @MyDateTimeConverter() required DateTime endAt,
  }) = _CMISubEvent;

  factory CMISubEvent.fromJson(Map<String, Object?> json) =>
      _$CMISubEventFromJson(json);
}

@freezed
class CMIQuerySubEvent with _$CMIQuerySubEvent {
  const factory CMIQuerySubEvent({
    required String providerId,
    required String eventId,
  }) = _CMIQuerySubEvent;
}

class EventAccessTypeConverter
    implements JsonConverter<EventAccessType?, String> {
  const EventAccessTypeConverter();

  @override
  EventAccessType? fromJson(String? status) {
    if (status == null) {
      return null;
    }
    return enumFromString(status, EventAccessType.values);
  }

  @override
  String toJson(EventAccessType? type) => enumToString(type) ?? 'single';
}

class FrequencyTypeConverter implements JsonConverter<FrequencyType?, String?> {
  const FrequencyTypeConverter();

  @override
  FrequencyType? fromJson(String? status) {
    if (status == null) {
      return null;
    }
    return enumFromString(status, FrequencyType.values);
  }

  @override
  String? toJson(FrequencyType? type) => enumToString(type);
}

class EventStatusConverter implements JsonConverter<EventStatus, String> {
  const EventStatusConverter();

  @override
  EventStatus fromJson(String? status) {
    if (status == null) {
      return EventStatus.unknown;
    }
    return enumFromString(status, EventStatus.values);
  }

  @override
  String toJson(EventStatus status) => enumToString(status) ?? 'unknown';
}

