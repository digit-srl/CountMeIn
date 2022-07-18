import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CMICard extends StatelessWidget {
  final Widget child;
  final IconData? iconBadge;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool inverseColor;

  const CMICard(
      {Key? key,
      required this.child,
      this.iconBadge,
      this.onTap,
      this.margin,
      this.inverseColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeColor: Colors.orange,
      showBadge: iconBadge != null,
      badgeContent: iconBadge != null
          ? Icon(
              iconBadge,
              color: Colors.white,
            )
          : null,
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: inverseColor
              ? Theme.of(context).colorScheme.inversePrimary
              : null,
          margin: margin,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
//Colors.grey[850]
}
