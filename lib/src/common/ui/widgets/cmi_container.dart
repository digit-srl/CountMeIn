import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CMICard extends StatefulWidget {
  final Widget child;
  final Widget? collapsedWidget;
  final IconData? iconBadge;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool inverseColor;
  final BoxConstraints? constraints;
  final bool center;
  final bool animated;
  final Widget? flag;

  const CMICard({
    Key? key,
    required this.child,
    this.iconBadge,
    this.onTap,
    this.margin,
    this.constraints,
    this.inverseColor = false,
    this.center = false,
    this.animated = false,
    this.collapsedWidget,
    this.flag,
  }) : super(key: key);

  @override
  State<CMICard> createState() => _CMICardState();
}

class _CMICardState extends State<CMICard> {
  bool opened = true;

  @override
  void initState() {
    super.initState();
    opened = widget.collapsedWidget != null ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeColor: Colors.orange,
      showBadge: widget.iconBadge != null,
      badgeContent: widget.iconBadge != null
          ? Icon(
              widget.iconBadge,
              color: Colors.white,
            )
          : null,
      child: InkWell(
        onTap: opened
            ? widget.onTap
            : () {
                setState(() {
                  opened = !opened;
                });
              },
        child: Card(
          color: widget.inverseColor
              ? Theme.of(context).colorScheme.inversePrimary
              : null,
          margin: widget.margin,
          child: AnimatedContainer(
            duration: widget.animated
                ? const Duration(milliseconds: 500)
                : Duration.zero,
            constraints: widget.constraints,
            padding: const EdgeInsets.all(16),
            // alignment: widget.center ? Alignment.center : null,
            child: Stack(
              // fit: StackFit.expand,
              children: [
                if (widget.collapsedWidget == null || opened)
                  if (widget.center)
                    Center(child: widget.child)
                  else
                    widget.child
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      widget.collapsedWidget!,
                    ],
                  ),
                if (widget.collapsedWidget != null || widget.flag != null)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: widget.flag != null
                        ? widget.flag!
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                opened = !opened;
                              });
                            },
                            icon: Icon(opened
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down),
                          ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
