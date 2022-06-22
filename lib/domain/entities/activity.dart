import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/domain/entities/session.dart';
import 'package:countmein/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'date_time_converter.dart';

part 'activity.freezed.dart';

part 'activity.g.dart';

enum ActivityStatus { unknown, live, archived }

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String name,
    @SessionStatusConverter() ActivityStatus? status,
    @MyDateTimeConverter() required DateTime createdOn,
  }) = _Activity;

  factory Activity.fromJson(Map<String, Object?> json) =>
      _$ActivityFromJson(json);
}

class SessionStatusConverter implements JsonConverter<ActivityStatus, String> {
  const SessionStatusConverter();

  @override
  ActivityStatus fromJson(String? status) {
    if(status == null){
      return ActivityStatus.unknown;
    }
    return enumFromString(status, ActivityStatus.values);
  }

  @override
  String toJson(ActivityStatus status) => enumToString(status);
}
