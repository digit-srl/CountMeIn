import 'package:flutter/material.dart';

class ExportTotemsScreen extends StatelessWidget {
  static const String routeName = 'totems-export';

  const ExportTotemsScreen({
    super.key,
    required String providerId,
    required String eventId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Esporta i totems in un CSV'),
        actions: [

        ],
      ),
    );
  }
}
