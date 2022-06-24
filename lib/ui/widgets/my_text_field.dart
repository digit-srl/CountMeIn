import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;

  const MyTextField(
      {Key? key,
        this.controller,
        this.hintText,
        this.validator,
        this.textCapitalization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
          hintText: hintText, border: const OutlineInputBorder()),
    );
  }
}