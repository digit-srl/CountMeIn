import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MUTextField extends HookConsumerWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? enabled;
  final int? maxLines;
  final int? minLines;
  final double? paddingTop;
  final TextInputType? keyboardType;
  final bool obscureText;

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
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = useState(!obscureText);
    return Padding(
      padding: EdgeInsets.only(top: paddingTop ?? 16.0),
      child: TextFormField(
        autofillHints: const [AutofillHints.email],
        controller: controller,
        validator: validator,
        enabled: enabled,
        maxLines: obscureText ? 1 : maxLines,
        minLines: minLines,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyText2,
        obscureText: !showPassword.value,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          suffixIcon: obscureText ? IconButton(
            icon: showPassword.value
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            color: Colors.white,
            onPressed: () {
              showPassword.value = !showPassword.value;
            },
          ) : null,
          //   floatingLabelBehavior: FloatingLabelBehavior.always,
          //   floatingLabelAlignment: FloatingLabelAlignment.start,
        ),
      ),
    );
  }
}
