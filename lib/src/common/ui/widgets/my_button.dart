import 'package:flutter/material.dart';

class MUButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const MUButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
