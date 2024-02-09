import 'package:flutter/material.dart';

import '../../../../utils.dart';

class GenericGridViewBuilder extends StatelessWidget {
  final int itemCount;
  final bool scroolEnabled;
  final EdgeInsets? padding;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const GenericGridViewBuilder({
    super.key,
    required this.itemCount,
    this.padding,
    required this.itemBuilder,
    this.scroolEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = calculateCrossAxisCount(constraints.maxWidth);
      return GridView.builder(
        shrinkWrap: true,
        physics: scroolEnabled ? null : const NeverScrollableScrollPhysics(),
        padding: padding,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: crossAxisCount == 1 ? 3 : 2 / 1,
        ),
        itemBuilder: itemBuilder,
      );
    });
  }
}

class GenericGridView extends StatelessWidget {
  final bool scroolEnabled;
  final List<Widget> children;

  const GenericGridView(
      {Key? key, required this.children, this.scroolEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = calculateCrossAxisCount(constraints.maxWidth);
      return GridView.count(
        shrinkWrap: true,
        physics: scroolEnabled ? null : const NeverScrollableScrollPhysics(),
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: crossAxisCount,
        childAspectRatio: crossAxisCount == 1 ? 3 : 4 / 3,
        children: children,
      );
    });
  }
}
