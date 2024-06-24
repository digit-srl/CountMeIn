import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CMITextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const CMITextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.textStyle,
    this.validator,
    this.keyboardType,
    this.textCapitalization,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: textStyle,
      inputFormatters: inputFormatters,
      controller: controller,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
