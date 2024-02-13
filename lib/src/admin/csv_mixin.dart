import 'dart:convert';

import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';

mixin CSVMixin {
  Future<void> downloadCSV(CMIEvent? event, List<EventUser> list) async {
    final fileName = event?.name ?? 'event_csv';
    if (kIsWeb) {
      final bytes = getCsvBytes(list, fileName);
      final path = await FileSaver.instance.saveFile(
          name: fileName, bytes: bytes, mimeType: MimeType.csv, ext: 'csv');
      logger.i(path);
    } else {
      final file = await getCsv(list, fileName);
      if (file != null) {
        if (Platform.isMacOS) {
          final path = await FileSaver.instance.saveFile(
              name: fileName, file: file, mimeType: MimeType.csv, ext: 'csv');
          logger.i(path);
        } else {
          Share.shareFiles([file.path]);
        }
      }
    }
  }

  String _buildCsv(List<EventUser> users) {
    final data = users.map((e) => e.toCsvList()).toList();
    final csv = const ListToCsvConverter().convert([
      ['Id', 'Name', 'Surname', 'CF'],
      ...data
    ]);
    return csv;
  }

  Uint8List getCsvBytes(List<EventUser> users, String eventName) {
    final csv = _buildCsv(users);
    final bytes = Uint8List.fromList(utf8.encode(csv));
    return bytes;
  }

  Future<File?> getCsv(List<EventUser> users, String eventName) async {
    try {
      final filename = eventName.replaceAll(' ', '_').toLowerCase();
      final csv = _buildCsv(users);

      if (kIsWeb) {
        return null;
      } else {
        final statuses = await [
          Permission.storage,
        ].request();
        if (await Permission.storage.request().isGranted) {
          final dir =
              "${(await getExternalStorageDirectory())!.path}/$filename.csv";

          final f = File(dir);

          await f.writeAsString(csv);
          return f;
        }
        return null;
      }
    } catch (ex) {
      logger.e(ex);
      return null;
    }
  }
}
