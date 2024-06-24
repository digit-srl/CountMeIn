import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Object? exception;

  const ErrorScreen({super.key, this.exception});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: kDebugMode
            ? Text('Si è verificato un errore\n'
                '$exception')
            : Container(),
      ),
    );
  }
}
