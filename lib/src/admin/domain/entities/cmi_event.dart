import 'package:cloud_firestore/cloud_firestore.dart' show GeoPoint, Timestamp;
import 'package:countmein/domain/entities/date_time_converter.dart';
import 'package:countmein/domain/entities/geopoint_converter.dart';
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

enum AcceptedCardType {
  mine,
  passpartoutAndMine,
  all;

  String get text {
    switch (this) {
      case AcceptedCardType.mine:
        return 'Solo miei';
      case AcceptedCardType.passpartoutAndMine:
        return 'Count Me In e miei';
      case AcceptedCardType.all:
        return 'Tutti';
    }
  }
}

enum FrequencyType {
  daily,
  weekly;
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
      case FrequencyType.weekly:
        return 'Settimanale';
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
      case FrequencyType.weekly:
        return 7;
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
    @EventAccessTypeConverter() required EventAccessType accessType, required int maxWomCount, @EventTypeConverter() required EventType type, @MyDateTimeConverter() required DateTime createdOn, @MyDateTimeConverter() required DateTime startAt, @Default(true) bool acceptPassepartout,
    @Default(true) bool anonymous,
    @Default(true) bool recurring,
    @Default(false) bool emailShowed,
    @FrequencyTypeConverter() FrequencyType? frequency,
    int? recurrence,
    int? remaining,
    @Default(0) num? totalUsers,
    GenderCount? genderCount,
    String? activeSessionId,
    String? aim,
    @Default(<String,String>{}) Map<String,String>? managers,
    @EventStatusConverter() EventStatus? status,
    @Default(AcceptedCardType.passpartoutAndMine)
    @AcceptedCardTypeConverted()
    AcceptedCardType acceptedCardType,
    @MyDateTimeConverter() DateTime? subEventDeadline,
    @GeoPointConverter() GeoPoint? position,
  }) = _CMIEvent;

  factory CMIEvent.fromJson(Map<String, Object?> json) =>
      _$CMIEventFromJson(json);
}

extension CMIEventX on CMIEvent {
  bool get isActive => status == EventStatus.live;

  bool get isClosed =>
      status == EventStatus.closed || status == EventStatus.archived;

  bool get isPeriodic => type == EventType.periodic;

  bool get isManual => type == EventType.manual;
}

@freezed
class CMISubEvent with _$CMISubEvent {
  const factory CMISubEvent({
    required String id,
    @MyDateTimeConverter() required DateTime startAt, String? name,
    GenderCount? genderCount,
    @Default(0) num totalUsers,
    @MyDateTimeConverter() DateTime? endAt,
  }) = _CMISubEvent;

  factory CMISubEvent.fromJson(Map<String, Object?> json) =>
      _$CMISubEventFromJson(json);
}

@freezed
class GenderCount with _$GenderCount {
  const factory GenderCount({
    required num male,
    required num female,
    required num notBinary,
    @Default(0) num notAvailable,
  }) = _GenderCount;

  factory GenderCount.fromJson(Map<String, Object?> json) =>
      _$GenderCountFromJson(json);
}

extension GenderCountX on GenderCount {
  int get total => (male + female + notBinary + notAvailable).toInt();
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

class AcceptedCardTypeConverted
    implements JsonConverter<AcceptedCardType, String?> {
  const AcceptedCardTypeConverted();

  @override
  AcceptedCardType fromJson(String? value) {
    if (value == null) {
      return AcceptedCardType.mine;
    }
    return AcceptedCardType.values.byName(value);
  }

  @override
  String toJson(AcceptedCardType type) => type.name;
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
