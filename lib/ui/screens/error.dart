import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? exception;

  const ErrorScreen({Key? key, this.exception}) : super(key: key);

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
