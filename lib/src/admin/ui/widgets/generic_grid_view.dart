import 'package:countmein/my_logger.dart';
import 'package:flutter/material.dart';

import '../../../../utils.dart';

class GenericGridView extends StatelessWidget {
  final int itemCount;
  final bool scroolEnabled;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const GenericGridView(
      {Key? key,
      required this.itemCount,
      required this.itemBuilder,
      this.scroolEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = calculateCrossAxisCount(constraints.maxWidth);
      return GridView.builder(
        shrinkWrap: true,
        physics: scroolEnabled ? null : const NeverScrollableScrollPhysics(),
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: crossAxisCount == 1 ? 3 : 4 / 3,
        ),
        itemBuilder: itemBuilder,
      );
    });
  }
}
