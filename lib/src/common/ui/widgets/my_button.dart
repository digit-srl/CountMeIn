import 'package:flutter/material.dart';

class MUButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const MUButton({required this.text, super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
