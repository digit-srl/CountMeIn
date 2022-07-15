import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CMIContainer extends StatelessWidget {
  final Widget child;
  final IconData? iconBadge;
  final Function()? onTap;

  const CMIContainer(
      {Key? key, required this.child, this.iconBadge, this.onTap})
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
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[850], borderRadius: BorderRadius.circular(16)),
          child: Center(child: child),
        ),
      ),
    );
  }
}
