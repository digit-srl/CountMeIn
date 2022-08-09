import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CMIDatePicker extends HookWidget {
  final ValueChanged<DateTime> onChanged;

  CMIDatePicker({Key? key, required this.onChanged}) : super(key: key);

  _selectDate() {}

  final dateFormat = DateFormat('dd MMMM yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    final dateTimeState = useState<DateTime>(DateTime.now());
    final dateTime = dateTimeState.value;
    final controller = useTextEditingController(text: dateFormat.format(dateTime));
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(labelText: 'Data'),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        final newDateTime = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)));
        if (newDateTime == null) return;
        controller.text = dateFormat.format(newDateTime);
        dateTimeState.value = newDateTime;
        onChanged(newDateTime);
      },
    );
  }
}

class CMITimePicker extends HookWidget {
  final ValueChanged<DateTime> onChanged;

  CMITimePicker({Key? key, required this.onChanged}) : super(key: key);

  _selectDate() {}

  final dateFormat = DateFormat('dd MMMM yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    final timeState = useState<TimeOfDay>(TimeOfDay.fromDateTime(DateTime.now()));
    final time = timeState.value;
    final controller = useTextEditingController(text: time.format(context));
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(labelText: 'Ora'),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        final newTime = await showTimePicker(
            context: context, initialTime: time,);
        if (newTime == null) return;
        controller.text = newTime.format(context);
        timeState.value = newTime;
      },
    );
  }
}