import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CMIErrorWidget extends StatelessWidget {
  final String? message;
  final StackTrace? stacktrace;
  final Function()? tryAgain;

  const CMIErrorWidget({Key? key, this.message, this.stacktrace, this.tryAgain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Si è verificato un errrore!',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (message != null) Padding(
              padding: const EdgeInsets.only(top:24.0),
              child: Text(message!),
            ),
            if (kDebugMode && stacktrace != null)
              Text(
                stacktrace!.toString(),
                maxLines: 10,
              ),
            if (tryAgain != null) ...[
              ElevatedButton(
                  onPressed: () {
                    tryAgain?.call();
                  },
                  child: Text('Riprova')),
            ]
          ],
        ),
      ),
    );
  }
}

class CMIWarningWidget extends StatelessWidget {
  final String message;
  final Function()? tryAgain;

  const CMIWarningWidget({Key? key, required this.message, this.tryAgain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
      BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.5),
      child: SingleChildScrollView(
        child: Column(
          children: [Padding(
              padding: const EdgeInsets.only(top:24.0),
              child: Text(message),
            ),
            if (tryAgain != null) ...[
              ElevatedButton(
                  onPressed: () {
                    tryAgain?.call();
                  },
                  child: Text('Riprova')),
            ]
          ],
        ),
      ),
    );
  }
}
