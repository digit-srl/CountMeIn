import 'package:countmein/src/common/ui/cmi_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartEndDateForm extends HookConsumerWidget {
  final DateTime? startAt;
  final DateTime? endAt;
  final Function(DateTime?, DateTime?)? onChanged;

  const StartEndDateForm({
    super.key,
    this.startAt,
    this.endAt,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = useState<DateTime?>(startAt);
    final startTime = useState<TimeOfDay?>(
        startAt != null ? TimeOfDay.fromDateTime(startAt!) : null,);
    final endDate = useState<DateTime?>(endAt);
    final endTime = useState<TimeOfDay?>(
        endAt != null ? TimeOfDay.fromDateTime(endAt!) : null,);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Inizio sessione'),
        Text(startDate.value.toString()),
        Row(
          children: [
            CMIDatePicker(
                initialDate: startAt,
                onChanged: (value) {
                  startDate.value = DateTime(
                    value.year,
                    value.month,
                    value.day,
                    startTime.value?.hour ?? 0,
                    startTime.value?.minute ?? 0,
                  );
                  startTime.value = TimeOfDay(
                    hour: startDate.value?.hour ?? 0,
                    minute: startDate.value?.minute ?? 0,
                  );
                  onChanged?.call(startDate.value, endDate.value);
                },),
            const SizedBox(width: 16),
            CMITimePicker(
              initialValue: startDate.value,
              enabled: startDate.value != null,
              onChanged: (TimeOfDay value) {
                startTime.value = value;

                if (startDate.value == null) return;
                startDate.value = DateTime(
                  startDate.value!.year,
                  startDate.value!.month,
                  startDate.value!.day,
                  value.hour,
                  value.minute,
                );

                onChanged?.call(startDate.value, endDate.value);
              },
            ),
          ],
        ),
        const Text('Fine sessione'),
        Text(endDate.value.toString()),
        Row(
          children: [
            CMIDatePicker(
                firstDate: startDate.value,
                initialDate: endDate.value,
                onChanged: (value) {
                  endDate.value = DateTime(
                    value.year,
                    value.month,
                    value.day,
                    endTime.value?.hour ?? 0,
                    endTime.value?.minute ?? 0,
                  );
                  endTime.value = TimeOfDay(
                    hour: endDate.value?.hour ?? 0,
                    minute: endDate.value?.minute ?? 0,
                  );
                  onChanged?.call(startDate.value, endDate.value);
                },),
            const SizedBox(width: 16),
            CMITimePicker(
              initialValue: endDate.value,
              enabled: endDate.value != null,
              onChanged: (TimeOfDay value) {
                endTime.value = value;
                if (endDate.value == null) return;

                endDate.value = DateTime(
                  endDate.value!.year,
                  endDate.value!.month,
                  endDate.value!.day,
                  value.hour,
                  value.minute,
                );
                onChanged?.call(startDate.value, endDate.value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
