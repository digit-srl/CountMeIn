import 'package:flutter/material.dart';

class CMIChip extends StatelessWidget {
  final String text;
  final Color? color;

  const CMIChip({super.key, required this.text, this.color = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
