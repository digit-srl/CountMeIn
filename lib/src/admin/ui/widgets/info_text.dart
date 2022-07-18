import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoText extends StatelessWidget {
  final String label;
  final String? value;
  final bool copyable;

  const InfoText(
      {Key? key,
        required this.label,
        required this.value,
        this.copyable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value ?? '-',
                style: Theme.of(context).textTheme.headline6,
              ),
              if (copyable && value != null) ...[
                const SizedBox(width: 4),
                IconButton(
                    icon: const Icon(Icons.copy),
                    color: Colors.grey,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: value));
                    }),
              ]
            ],
          ),
        ],
      ),
    );
  }
}