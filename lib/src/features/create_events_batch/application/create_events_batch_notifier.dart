import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:countmein/utils.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'create_events_batch_notifier.freezed.dart';

part 'create_events_batch_notifier.g.dart';

@freezed
class CreateEventsBatchState with _$CreateEventsBatchState {
  const factory CreateEventsBatchState.data(
    List<String> items,
    int totalItemsCount, {
    @Default(true) bool hasReachedMax,
  }) = CreateEventsBatchStateData;

  const factory CreateEventsBatchState.initial() =
      CreateEventsBatchStateInitial;

  const factory CreateEventsBatchState.completed() =
      CreateEventsBatchStateCompleted;

  const factory CreateEventsBatchState.csvEventsLoaded({
    required String eventsFileName,
    required List<List<dynamic>> eventsCsv,
    String? sessionsFileName,
    List<List<dynamic>>? sessionsCsv,
  }) = CreateEventsBatchStateCsvEventsLoaded;

  const factory CreateEventsBatchState.loading() =
      CreateEventsBatchStateLoading;

  const factory CreateEventsBatchState.generated({
    required List<EventAndSessions> list,
    @Default(false) bool uploadInProgress,
  }) = CreateEventsBatchStateGenerated;

  const factory CreateEventsBatchState.error(Object error, StackTrace st) =
      CreateEventsBatchStateError;
}

@riverpod
class CreateEventsBatchNotifier extends _$CreateEventsBatchNotifier {
  @override
  CreateEventsBatchState build() {
    return const CreateEventsBatchState.initial();
  }

  Future<(String, Uint8List)?> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );

    if (result != null) {
      final fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      if (fileBytes == null) {
        return null;
      }
      return (fileName, fileBytes);
    }
    return null;
  }

  Future<void> importCSVEvents() async {
    final f = await _pickFile();

    if (f == null) {
      return;
    }

    // extract csv
    final csv = csvFromBytes(f.$2);
    // update state with first file loaded
    state = CreateEventsBatchStateCsvEventsLoaded(
      eventsFileName: f.$1,
      eventsCsv: csv,
    );
  }

  Future<void> importCSVSessions() async {
    final currentState = state;
    if (currentState is! CreateEventsBatchStateCsvEventsLoaded) {
      return;
    }
    final f = await _pickFile();

    if (f == null) {
      return;
    }

    final s = utf8.decode(f.$2).trim();
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(s);
    if (validateCSVSessions(rowsAsListOfValues)) {
      state = currentState.copyWith(
        sessionsFileName: f.$1,
        sessionsCsv:
            rowsAsListOfValues.getRange(1, rowsAsListOfValues.length).toList(),
      );
    }
  }

  List<List<dynamic>> csvFromBytes(Uint8List bytes) {
    final s = utf8.decode(bytes).trim();
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(s);
    if (validateCSVEvents(rowsAsListOfValues)) {
      return rowsAsListOfValues.getRange(1, rowsAsListOfValues.length).toList();
    } else {
      throw Exception('CSV is not valid');
    }
  }

  bool validateCSVEvents(List<List<dynamic>> csv) {
    final header = csv[0];
    var i = 0;
    if (header[i] != 'id') {
      return false;
    }
    i++;
    if (header[i] != 'name') {
      return false;
    }
    i++;
    if (header[i] != 'wom') {
      return false;
    }
    i++;
    if (header[i] != 'aim') {
      return false;
    }
    i++;
    if (header[i] != 'latitude') {
      return false;
    }
    i++;
    if (header[i] != 'longitude') {
      return false;
    }
    i++;
    if (header[i] != 'startAt') {
      return false;
    }
    return true;
  }

  bool validateCSVSessions(List<List<dynamic>> csv) {
    final header = csv[0];
    var i = 0;
    if (header[i] != 'eventId') {
      return false;
    }
    i++;
    if (header[i] != 'name') {
      return false;
    }
    i++;
    if (header[i] != 'startDate') {
      return false;
    }
    i++;
    if (header[i] != 'endDate') {
      return false;
    }

    return true;
  }

  (String, CMIEvent) buildEvent(List<dynamic> list) {
    final key = list[0].toString();
    final name = list[1] as String;
    final womCount = int.parse(list[2].toString());
    final aim = list[3] as String;
    final position = GeoPoint(
      double.parse(list[4].toString()),
      double.parse(list[5].toString()),
    );
    final startAt = DateTime.parse(list[6].toString()).midnight;

    final newEvent = CMIEvent(
      id: const Uuid().v4(),
      type: EventType.manual,
      activeSessionId: null,
      subEventDeadline: null,
      startAt: startAt,
      name: name,
      acceptPassepartout: true,
      anonymous: false,
      emailShowed: true,
      recurring: false,
      recurrence: 1,
      remaining: 0,
      frequency: null,
      accessType: EventAccessType.single,
      maxWomCount: womCount,
      status: EventStatus.live,
      createdOn: DateTime.now(),
      acceptedCardType: AcceptedCardType.passpartoutAndMine,
      position: position,
      aim: aim,
    );

    return (key, newEvent);
  }

  (String, CMISubEvent) buildSession(List<dynamic> list) {
    final eventId = list[0].toString();
    final name = list[1].toString();
    final sessionStartAt = DateTime.parse(list[2].toString());
    final sessionEndAt = DateTime.tryParse(list[3].toString());
    final womCount = int.tryParse(list[4].toString());
    return (
      eventId,
      CMISubEvent(
        id: const Uuid().v4(),
        name: name,
        startAt: sessionStartAt,
        endAt: sessionEndAt,
        // womCount: womCount,
      ),
    );
  }

  void generate() {
    final currentState = state;
    if (currentState is! CreateEventsBatchStateCsvEventsLoaded) {
      return;
    }

    if (currentState.sessionsCsv == null) {
      return;
    }

    final map = <String, List<CMISubEvent>>{};
    for (int i = 0; i < currentState.sessionsCsv!.length; i++) {
      final s = buildSession(currentState.sessionsCsv![i]);
      map[s.$1] = [...map[s.$1] ?? [], s.$2];
    }

    final events = currentState.eventsCsv.map((e) => buildEvent(e)).toList();

    final list = <EventAndSessions>[];
    for (int i = 0; i < events.length; i++) {
      final id = events[i].$1;
      final sessions = map[id] ??
          [
            CMISubEvent(
              id: const Uuid().v4(),
              startAt: events[i].$2.startAt,
              name: DateFormat('y-MM-dd').format(events[i].$2.startAt),
            ),
          ];
      sessions.sort((a, b) => a.startAt.compareTo(b.startAt));

      final e = events[i].$2.copyWith(
            activeSessionId: sessions.first.id,
            startAt: sessions.first.startAt,
          );
      print('for eventId: $id there are ${sessions.length} sessions');

      final totem = EmbeddedData(
        name: 'Totem',
        id: const Uuid().v4(),
        isStatic: true,
        requestId: null,
        position: e.position,
        createdAt: DateTime.now(),
        updatedOn: DateTime.now(),
        radius: 100,
        dedicated: true,
        eventId: e.id,
        sessionId: sessions.first.id,
      );

      list.add(
        EventAndSessions(
          sessions: sessions,
          event: e,
          totem: totem,
        ),
      );
    }

    state = CreateEventsBatchState.generated(list: list);
  }

  void reset() {
    state = const CreateEventsBatchStateInitial();
  }

  Future<void> upload(String providerId) async {
    try {
      final currentState = state;
      if (currentState is! CreateEventsBatchStateGenerated) {
        return;
      }

      state = currentState.copyWith(uploadInProgress: true);
      final eventAndSessions = currentState.list;
      final batch = FirebaseFirestore.instance.batch();

      for (int z = 0; z < eventAndSessions.length; z++) {
        final event = eventAndSessions[z].event;
        final sessions = eventAndSessions[z].sessions;
        final totem = eventAndSessions[z].totem;
        batch.set(
          Cloud.eventDoc(providerId, event.id),
          event.toJson(),
        );
        for (int i = 0; i < sessions.length; i++) {
          final session = sessions[i];
          batch.set(
              Cloud.sessionDoc(
                EventIds(
                  providerId: providerId,
                  eventId: event.id,
                  sessionId: session.id,
                ),
              ),
              session.toJson(),);
        }

        batch.set(
          Cloud.totemDoc(
            providerId,
            totem.id,
          ),
          totem.toJson(),
        );
      }
      await batch.commit();
      state = const CreateEventsBatchStateCompleted();
    } catch (ex, st) {
      logger.e(ex);
      state = CreateEventsBatchStateError(ex, st);
    }
  }
}

class EventAndSessions {
  final List<CMISubEvent> sessions;
  final CMIEvent event;
  final EmbeddedData totem;

  EventAndSessions({
    required this.sessions,
    required this.event,
    required this.totem,
  });
}
