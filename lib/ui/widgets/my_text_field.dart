import 'package:flutter/material.dart';

class CMITextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;

  const CMITextField({
    Key? key,
    this.controller,
    this.hintText,
    this.textStyle,
    this.validator,
    this.keyboardType,
    this.textCapitalization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      controller: controller,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        labelText: hintText,
      ),
    );
  }
}
