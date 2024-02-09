import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoText extends StatelessWidget {
  final String label;
  final String? value;
  final bool copyable;
  final Widget? iconButton;

  const InfoText({
    super.key,
    required this.label,
    required this.value,
    this.copyable = false,
    this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  value ?? '-',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              if (iconButton != null) iconButton!,
              if (copyable && value != null) ...[
                const SizedBox(width: 4),
                IconButton(
                    icon: const Icon(Icons.copy),
                    color: Colors.grey,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: value!));
                    }),
              ]
            ],
          ),
        ],
      ),
    );
  }
}

class InfoText2 extends StatelessWidget {
  final String label;
  final Widget value;
  final bool copyable;
  final Widget? iconButton;
  final Widget? labelWidget;

  const InfoText2({
    super.key,
    required this.label,
    required this.value,
    this.copyable = false,
    this.iconButton,
    this.labelWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.grey),
                ),
              ),
              if (labelWidget != null) labelWidget!
            ],
          ),
          const SizedBox(height: 4),
          value,
          /*   Row(
            children: [
              Text(
                value ?? '-',
                style: Theme.of(context).textTheme.headline6,
              ),
              if (iconButton != null) iconButton!,
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
          ),*/
        ],
      ),
    );
  }
}
