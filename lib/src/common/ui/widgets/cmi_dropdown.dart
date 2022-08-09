import 'package:flutter/material.dart';

class CMIDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;

  const CMIDropdownButton(
      {Key? key, required this.items, this.onChanged, this.value,  this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: DropdownButton<T>(
          isDense: true,
            isExpanded:true,
          underline: Container(),
          value: value,
          items: items,
          onChanged: onChanged,
        ));
  }
}
