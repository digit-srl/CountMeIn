import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ids.freezed.dart';

@freezed
class EventIds with _$EventIds {
  const factory EventIds({
    required String activityId,
    required String eventId,
  }) = _EventIds;
}

