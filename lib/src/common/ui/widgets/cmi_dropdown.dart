import 'package:flutter/material.dart';

class CMIDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;
  final FormFieldValidator<T>? validator;

  const CMIDropdownButton({
    Key? key,
    required this.items,
    this.onChanged,
    this.value,
    this.label,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
      ),
      validator: validator,
      isDense: true,
      isExpanded: true,
      // underline: Container(),
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
