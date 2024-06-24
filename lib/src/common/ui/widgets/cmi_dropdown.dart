import 'package:flutter/material.dart';

class CMIDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;
  final FormFieldValidator<T>? validator;

  const CMIDropdownButton({
    required this.items, super.key,
    this.onChanged,
    this.value,
    this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          // enabledBorder: InputBorder.none,
          labelText: label,
          hintText: label,
        ),
        validator: validator,
        isDense: true,
        isExpanded: true,
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
