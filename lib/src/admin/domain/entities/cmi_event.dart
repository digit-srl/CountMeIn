import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/domain/entities/date_time_converter.dart';
import 'package:countmein/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cmi_event.freezed.dart';

part 'cmi_event.g.dart';

// enum EventAccessType { single, inOut }

// enhanced enum is more like a constant class
enum EventAccessType {
  single,
  inOut;

  String get text {
    switch (this) {
      case EventAccessType.single:
        return 'Check In';
      case EventAccessType.inOut:
        return 'Check In/Out';
    }
  }
}

// enum FrequencyType { daily, monthly, yearly }

enum EventType {
  manual,
  periodic;

  String get text {
    switch (this) {
      case EventType.manual:
        return 'Manuale';
      case EventType.periodic:
        return 'Periodico';
    }
  }
}

enum FrequencyType {
  daily;
  // monthly,
  // yearly;

  String get text {
    switch (this) {
      case FrequencyType.daily:
        return 'Giornaliero';
      // case FrequencyType.monthly:
      //   return 'Settimanale';
      // case FrequencyType.yearly:
      //   return 'Annuale';
    }
  }

  int get multiplier {
    switch (this) {
      case FrequencyType.daily:
        return 1;
      // case FrequencyType.monthly:
      //   return 31;
      // case FrequencyType.yearly:
      //   return 365;
    }
  }
}

// enum EventStatus { unknown, live, archived, closed }

enum EventStatus {
  unknown,
  live,
  archived,
  closed;

  String get text {
    switch (this) {
      case EventStatus.unknown:
        return 'Sconosciuto';
      case EventStatus.live:
        return 'Attivo';
      case EventStatus.archived:
        return 'Archiviato';
      case EventStatus.closed:
        return 'Chiuso';
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
    @Default(false) bool emailShowed,
    @FrequencyTypeConverter() FrequencyType? frequency,
    int? recurrence,
    int? remaining,
    @Default(0) int? totalUsers,
    GenderCount? genderCount,
    String? activeSessionId,
    @EventAccessTypeConverter() required EventAccessType accessType,
    required int maxWomCount,
    @EventStatusConverter() EventStatus? status,
    @EventTypeConverter() required EventType type,
    @MyDateTimeConverter() required DateTime createdOn,
    @MyDateTimeConverter() DateTime? subEventDeadline,
    @MyDateTimeConverter() required DateTime startAt,
  }) = _CMIEvent;

  factory CMIEvent.fromJson(Map<String, Object?> json) =>
      _$CMIEventFromJson(json);
}

extension CMIEventX on CMIEvent {
  bool get isActive => status == EventStatus.live;
  bool get isPeriodic => type == EventType.periodic;
  bool get isManual => type == EventType.manual;
}

@freezed
class CMISubEvent with _$CMISubEvent {
  const factory CMISubEvent({
    required String id,
    String? name,
    GenderCount? genderCount,
    @Default(0) int totalUsers,
    @MyDateTimeConverter() required DateTime startAt,
    @MyDateTimeConverter() DateTime? endAt,
  }) = _CMISubEvent;

  factory CMISubEvent.fromJson(Map<String, Object?> json) =>
      _$CMISubEventFromJson(json);
}

@freezed
class GenderCount with _$GenderCount {
  const factory GenderCount({
    required int male,
    required int female,
    required int notBinary,
    @Default(0) int notAvailable,
  }) = _GenderCount;

  factory GenderCount.fromJson(Map<String, Object?> json) =>
      _$GenderCountFromJson(json);
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

class EventTypeConverter implements JsonConverter<EventType?, String> {
  const EventTypeConverter();

  @override
  EventType? fromJson(String? status) {
    if (status == null) {
      return null;
    }
    return enumFromString(status, EventType.values);
  }

  @override
  String toJson(EventType? type) => enumToString(type) ?? 'single';
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
