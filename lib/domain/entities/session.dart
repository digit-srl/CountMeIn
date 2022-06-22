import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'date_time_converter.dart';

part 'session.freezed.dart';

part 'session.g.dart';

enum SessionsStatus { unknown, live, archived }

@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    required String name,
    @SessionStatusConverter() SessionsStatus? status,
    @MyDateTimeConverter() required DateTime createdOn,
  }) = _Session;

  factory Session.fromJson(Map<String, Object?> json) =>
      _$SessionFromJson(json);
}



class SessionStatusConverter implements JsonConverter<SessionsStatus, String> {
  const SessionStatusConverter();

  @override
  SessionsStatus fromJson(String? status) {
    if(status == null){
      return SessionsStatus.unknown;
    }
    return enumFromString(status, SessionsStatus.values);
  }

  @override
  String toJson(SessionsStatus status) => enumToString(status);
}
