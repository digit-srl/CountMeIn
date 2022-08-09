import 'package:flutter/material.dart';


extension DateTimeX on DateTime{

  DateTime get midnight => DateTime(this.year,this.month,this.day);
  DateTime get midnightUTC => DateTime.utc(this.year,this.month,this.day);
}
int childAspectRatio(double maxWidth) => maxWidth < 400
    ? 1
    : maxWidth < 500
    ? 2
    : maxWidth < 900
    ? 3
    : 4;


String? enumToString(Object? o) => o?.toString().split('.').last;

T enumFromString<T extends Object>(String key, List<T> values) => values
    .firstWhere((v) => key.toLowerCase() == enumToString(v)?.toLowerCase());

ask(BuildContext context, String question) async {
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
                        Navigator.of(c).pop();
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
