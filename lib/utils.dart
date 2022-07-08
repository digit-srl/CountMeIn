import 'package:flutter/material.dart';

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T extends Object>(String key, List<T> values) => values
    .firstWhere((v) => key.toLowerCase() == enumToString(v).toLowerCase());

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
