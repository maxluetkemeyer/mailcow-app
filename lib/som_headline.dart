import 'package:flutter/material.dart';

class SomHeadline extends StatelessWidget {
  final Widget child;
  final double lineWidth;
  final Color? color;
  final bool animated;

  const SomHeadline({
    super.key,
    required this.child,
    required this.lineWidth,
    this.color,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!animated) {
      return Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            color: color ?? Colors.amber.shade400,
            height: 10,
            width: lineWidth,
          ),
          child,
        ],
      );
    }

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: lineWidth),
          duration: Duration(milliseconds: (lineWidth * 8).toInt()),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Container(
              color: color ?? Colors.amber.shade400,
              height: 10,
              width: value,
            );
          },
        ),
        child,
      ],
    );
  }
}
