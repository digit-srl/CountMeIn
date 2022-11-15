import 'package:countmein/src/common/upper_case_formatter.dart';
import 'package:countmein/ui/validators.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class CFTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  const CFTextField({Key? key, required this.controller, this.labelText, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CMITextField(
      controller: controller,
      hintText: hintText ?? 'Codice Fiscale',
      labelText: labelText ?? 'Digita il codice fiscale',
      inputFormatters: [
        UpperCaseTextFormatter()
      ],
      textCapitalization: TextCapitalization.characters,
      validator: CFValidator(),
    );
  }
}
