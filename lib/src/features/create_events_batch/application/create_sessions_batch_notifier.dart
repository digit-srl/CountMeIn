import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/totem/data/embedded_data.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'create_sessions_batch_notifier.freezed.dart';

part 'create_sessions_batch_notifier.g.dart';

@freezed
class CreateSessionsBatchState with _$CreateSessionsBatchState {
  const factory CreateSessionsBatchState.initial() =
      CreateSessionsBatchStateInitial;

  const factory CreateSessionsBatchState.completed() =
      CreateSessionsBatchStateCompleted;

  const factory CreateSessionsBatchState.csvSessionsLoaded({
    required String sessionsFileName,
    required List<List<dynamic>> sessionsCsv,
    required String eventId,
    required String providerId,
  }) = CreateSessionsBatchStateCsvSessionsLoaded;

  const factory CreateSessionsBatchState.loading() =
      CreateSessionsBatchStateLoading;

  const factory CreateSessionsBatchState.generated({
    required List<CMISubEvent> list,
    required String eventId,
    required String providerId,
    @Default(false) bool uploadInProgress,
  }) = CreateSessionsBatchStateGenerated;

  const factory CreateSessionsBatchState.error(Object error, StackTrace st) =
      CreateSessionsBatchStateError;
}

@riverpod
class CreateSessionsBatchNotifier extends _$CreateSessionsBatchNotifier {
  late CMIEvent _event;

  @override
  CreateSessionsBatchState build(
    final String providerId,
    final String eventId,
  ) {
    final eventState = ref.watch(
      eventProvider(
        EventIds(
          providerId: providerId,
          eventId: eventId,
        ),
      ),
    );
    final event = eventState.valueOrNull;
    if (event == null) {
      return const CreateSessionsBatchState.loading();
    }
    _event = event;
    return const CreateSessionsBatchState.initial();
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

  Future<void> importCSVSessions() async {
    final f = await _pickFile();

    if (f == null) {
      return;
    }

    final s = utf8.decode(f.$2).trim();
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(s);
    if (validateCSVSessions(rowsAsListOfValues)) {
      state = CreateSessionsBatchStateCsvSessionsLoaded(
        eventId: eventId,
        providerId: providerId,
        sessionsFileName: f.$1,
        sessionsCsv:
            rowsAsListOfValues.getRange(1, rowsAsListOfValues.length).toList(),
      );
    }
  }

  bool validateCSVSessions(List<List<dynamic>> csv) {
    final header = csv[0];
    var i = 0;
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

  CMISubEvent buildSession(List<dynamic> list) {
    final name = list[0].toString();
    final sessionStartAt = DateTime.parse(list[1].toString());
    final sessionEndAt = DateTime.tryParse(list[2].toString());
    // final womCount = int.tryParse(list[4].toString());
    return CMISubEvent(
      id: const Uuid().v4(),
      name: name,
      startAt: sessionStartAt,
      endAt: sessionEndAt,
      // womCount: womCount,
    );
  }

  void generate() {
    final currentState = state;
    if (currentState is! CreateSessionsBatchStateCsvSessionsLoaded) {
      return;
    }

    final id = _event.id;
    final sessions =
        currentState.sessionsCsv.map((e) => buildSession(e)).toList();
    sessions.sort((a, b) => a.startAt.compareTo(b.startAt));
    print('for eventId: $id there are ${sessions.length} sessions');

    state = CreateSessionsBatchState.generated(
      list: sessions,
      providerId: providerId,
      eventId: eventId,
    );
  }

  void reset() {
    state = const CreateSessionsBatchStateInitial();
  }

  Future<void> upload() async {
    try {
      final currentState = state;
      if (currentState is! CreateSessionsBatchStateGenerated) {
        return;
      }

      state = currentState.copyWith(uploadInProgress: true);
      final providerId = currentState.providerId;
      final sessions = currentState.list;
      final batch = FirebaseFirestore.instance.batch();

      final event = _event;
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
          session.toJson(),
        );
      }

      await batch.commit();
      state = const CreateSessionsBatchStateCompleted();
    } catch (ex, st) {
      logger.e(ex);
      state = CreateSessionsBatchStateError(ex, st);
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
