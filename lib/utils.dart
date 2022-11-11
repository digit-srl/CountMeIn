import 'package:countmein/domain/entities/qcode_data.dart';
import 'package:countmein/my_logger.dart';
import 'package:flutter/material.dart';

extension DateTimeX on DateTime {
  DateTime get midnight => DateTime(this.year, this.month, this.day);

  DateTime get midnightUTC => DateTime.utc(this.year, this.month, this.day);
}

int calculateCrossAxisCount(double maxWidth) =>
    maxWidth < 415
        ? 1
        : maxWidth < 500
        ? 2
        : maxWidth < 900
        ? 3
        : 4;

String? enumToString(Object? o) =>
    o
        ?.toString()
        .split('.')
        .last;

T enumFromString<T extends Object>(String key, List<T> values) =>
    values
        .firstWhere((v) => key.toLowerCase() == enumToString(v)?.toLowerCase());

Future<bool?> ask(BuildContext context, String question) async {
  return await showDialog(
    context: context,
    builder: (c) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                question,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).pop(false);
                      },
                      child: const Text('Annulla')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(c).pop(true);
                      },
                      child: const Text('Sì'))
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

const Pattern _emailPattern =
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
const fiscalCode =
    r'^[A-Z]{6}[0-9LMNPQRSTUV]{2}[ABCDEHLMPRST]{1}[0-9LMNPQRSTUV]{2}[A-Z]{1}[0-9LMNPQRSTUV]{3}[A-Z]{1}$';
// Example: UNIURB;ALICE;BORGHESI;BRGLCA02R63A944C;313424;a.borghesi;367730
// Example: UNIURB;Marco;Cappellacci;CPPMRC00H10L500A;62013;m.cappellacci4@campus.uniurb.it
// Example: UNIURB;CHRISTEL;SIROCCHI;SRCCRS90T59D542S;315959;c.sirocchi2;361717
// Example: UNIURB;GIAN MARCO;DI FRANCESCO;DFRGMR89M02I348U;309791;g.difrancesco1;312975
// Example: UNIURB;AURORA;DELL'ISOLA;DLLRRA03D70G751Q;319671;a.dellisola;364959
QrCodeData? validateCustomQrCode(String qrCode) {
  const emailPattern = r"(((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))";
  const regex =
      r"^(.*);(.*);([a-zA-Z\s']*);([A-Z]{6}[0-9LMNPQRSTUV]{2}[ABCDEHLMPRST]{1}[0-9LMNPQRSTUV]{2}[A-Z]{1}[0-9LMNPQRSTUV]{3}[A-Z]{1});(.*);(.*);(.*)$";
  final regexp = RegExp(regex);

  if (regexp.hasMatch(qrCode)) {
    final match = regexp.firstMatch(qrCode);
    final matchedText = match?.group(0);

    logger.i('0: $matchedText');
    logger.i('1: ${match?.group(1)}');
    logger.i('2: ${match?.group(2)}');
    logger.i('3: ${match?.group(3)}');
    logger.i('4: ${match?.group(4)}');
    logger.i('5: ${match?.group(5)}');
    logger.i('6: ${match?.group(6)}');
    logger.i('6: ${match?.group(7)}');

    final providerId = match?.group(1);
    final name = match?.group(2);
    final surname = match?.group(3);
    final cf = match?.group(4);
    final id = match?.group(5);
    final email = match?.group(6);
    final extra = match?.group(7);
    if (providerId == null ||
        name == null ||
        surname == null ||
        email == null ||
        cf == null ||
        id == null || extra ==null) {
      return null;
    }
    return QrCodeData(
      providerId: providerId,
      name: name,
      surname: surname,
      email: email,
      cf: cf,
      id: '${providerId}_$id',
    );
  }
  return null;
}
