import 'package:flutter/material.dart';

class CMIChip extends StatelessWidget {
  final String text;

  const CMIChip({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.green,
      label: Text(text),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
    );
  }
}
