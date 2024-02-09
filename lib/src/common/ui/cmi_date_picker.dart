import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class CMIDatePicker extends HookWidget {
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final String? hintText;
  final String? labelText;

  CMIDatePicker({
    super.key,
    required this.onChanged,
    this.initialDate,
    this.firstDate,
    this.hintText,
    this.labelText,
  });

  _selectDate() {}

  final dateFormat = DateFormat('dd MMMM yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    final dateTimeState = useState<DateTime?>(initialDate);
    final dateTime = dateTimeState.value;
    final controller = useTextEditingController(
        text: dateTime != null ? dateFormat.format(dateTime) : '');
    return Flexible(
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(labelText: labelText, hintText: hintText),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          final newDateTime = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate ?? DateTime(1920),
              lastDate: DateTime.now().add(const Duration(days: 365)));
          if (newDateTime == null) return;
          controller.text = dateFormat.format(newDateTime);
          dateTimeState.value = newDateTime;
          onChanged(newDateTime);
        },
      ),
    );
  }
}

class CMITimePicker extends HookWidget {
  final ValueChanged<TimeOfDay> onChanged;
  final DateTime? initialValue;
  final bool enabled;

  CMITimePicker({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.enabled = true,
  });

  final dateFormat = DateFormat('dd MMMM yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    final timeState = useState<TimeOfDay?>(initialValue != null
        ? TimeOfDay.fromDateTime(initialValue!)
        : const TimeOfDay(hour: 0, minute: 0));
    final time = timeState.value;
    final controller = useTextEditingController(
        text: time?.format(context) ?? 'Imposta orario');
    return Flexible(
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        maxLines: 1,
        decoration: const InputDecoration(labelText: 'Ora'),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          final newTime = await showTimePicker(
            context: context,
            initialTime: time ?? const TimeOfDay(hour: 00, minute: 00),
          );
          if (newTime == null) return;
          if (!context.mounted) return;
          controller.text = newTime.format(context);
          timeState.value = newTime;
          onChanged(newTime);
        },
      ),
    );
  }
}
