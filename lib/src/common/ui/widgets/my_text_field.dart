import 'package:flutter/material.dart';

class MUTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? enabled;
  final int? maxLines;
  final int? minLines;
  final double? paddingTop;
  final TextInputType? keyboardType;

  const MUTextField({
    Key? key,
    this.controller,
    this.validator,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.maxLines,
    this.minLines,
    this.paddingTop,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop ?? 16.0),
      child: TextFormField(
        autofillHints: [AutofillHints.email],
        controller: controller,
        validator: validator,
        enabled: enabled,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,

          //   floatingLabelBehavior: FloatingLabelBehavior.always,
          //   floatingLabelAlignment: FloatingLabelAlignment.start,
        ),
      ),
    );
  }
}
