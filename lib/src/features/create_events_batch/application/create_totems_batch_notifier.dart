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

part 'create_totems_batch_notifier.freezed.dart';

part 'create_totems_batch_notifier.g.dart';

@freezed
class CreateTotemsBatchState with _$CreateTotemsBatchState {
  const factory CreateTotemsBatchState.initial() =
      CreateTotemsBatchStateInitial;

  const factory CreateTotemsBatchState.completed() =
      CreateTotemsBatchStateCompleted;

  const factory CreateTotemsBatchState.csvTotemsLoaded({
    required String totemsFileName,
    required List<List<dynamic>> totemsCsv,
    required String eventId,
    required String providerId,
  }) = CreateTotemsBatchStateCsvTotemsLoaded;

  const factory CreateTotemsBatchState.loading() =
      CreateTotemsBatchStateLoading;

  const factory CreateTotemsBatchState.generated({
    required List<EmbeddedData> list,
    required String eventId,
    required String providerId,
    @Default(false) bool uploadInProgress,
  }) = CreateTotemsBatchStateGenerated;

  const factory CreateTotemsBatchState.error(Object error, StackTrace st) =
      CreateTotemsBatchStateError;
}

@riverpod
class CreateTotemsBatchNotifier extends _$CreateTotemsBatchNotifier {
  late CMIEvent _event;

  @override
  CreateTotemsBatchState build(
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
      return const CreateTotemsBatchState.loading();
    }
    _event = event;
    return const CreateTotemsBatchState.initial();
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

  Future<void> importCSVTotems() async {
    final f = await _pickFile();

    if (f == null) {
      return;
    }

    final s = utf8.decode(f.$2).trim();
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(s);
    if (validateCSVSessions(rowsAsListOfValues)) {
      state = CreateTotemsBatchStateCsvTotemsLoaded(
        eventId: eventId,
        providerId: providerId,
        totemsFileName: f.$1,
        totemsCsv:
            rowsAsListOfValues.getRange(1, rowsAsListOfValues.length).toList(),
      );
    } else {
      logger.w('il formato del csv non è validos');
    }
  }

  bool validateCSVSessions(List<List<dynamic>> csv) {
    final header = csv[0];
    var i = 0;
    if (header[i] != 'name') {
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
    if (header[i] != 'radius') {
      return false;
    }
    i++;
    if (header[i] != 'email') {
      return false;
    }
    i++;
    if (header[i] != 'phoneNumber') {
      return false;
    }
    i++;
    if (header[i] != 'url') {
      return false;
    }
    return true;
  }

  EmbeddedData buildTotem(List<dynamic> list) {
    final name = list[0].toString();
    final latitude = double.tryParse(list[1].toString());
    final longitude = double.tryParse(list[2].toString());
    final radius = int.tryParse(list[3].toString()) ?? 100;
    final email = list[4].toString();
    final phoneNumber = list[5].toString();
    final url = list[6].toString();

    EmbeddedMetaData? metadata;
    if (email.isNotEmpty || phoneNumber.isNotEmpty || url.isNotEmpty) {
      metadata = EmbeddedMetaData(
        email: email.isEmpty ? null : email,
        phoneNumber: phoneNumber.isEmpty ? null : phoneNumber,
        url: url.isEmpty ? null : url,
      );
    }

    final position = latitude != null && longitude != null
        ? GeoPoint(
            latitude,
            longitude,
          )
        : null;

    // Per i totem dedicati non ha senso inserire la sessionId
    // in quanto il totem si adatta alle sessioni attive dell'
    // evento
    // I totem che non sono dedicati devo avere la sessionId sincronizzata con
    // quella attiva nell evento
    return EmbeddedData(
      name: name,
      id: const Uuid().v4(),
      isStatic: true,
      requestId: null,
      position: position,
      createdAt: DateTime.now(),
      updatedOn: DateTime.now(),
      radius: radius,
      dedicated: true,
      eventId: _event.id,
      sessionId: null,
      metadata: metadata,
    );
  }

  void generate() {
    final currentState = state;
    if (currentState is! CreateTotemsBatchStateCsvTotemsLoaded) {
      return;
    }

    final id = _event.id;
    final totems = currentState.totemsCsv.map((e) => buildTotem(e)).toList();
    print('for eventId: $id there are ${totems.length} totems');

    state = CreateTotemsBatchState.generated(
      list: totems,
      providerId: providerId,
      eventId: eventId,
    );
  }

  void reset() {
    state = const CreateTotemsBatchStateInitial();
  }

  Future<void> upload() async {
    try {
      final currentState = state;
      if (currentState is! CreateTotemsBatchStateGenerated) {
        return;
      }

      state = currentState.copyWith(uploadInProgress: true);
      final providerId = currentState.providerId;
      final totems = currentState.list;
      final batch = FirebaseFirestore.instance.batch();

      for (int i = 0; i < totems.length; i++) {
        final totem = totems[i];
        batch.set(
          Cloud.totemCollection(providerId).doc(totem.id),
          totem.toJson(),
        );
      }

      await batch.commit();
      state = const CreateTotemsBatchStateCompleted();
    } catch (ex, st) {
      logger.e(ex);
      state = CreateTotemsBatchStateError(ex, st);
    }
  }
}
