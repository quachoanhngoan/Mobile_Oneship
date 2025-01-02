import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double dashWidth;
  final double dashHeight;
  final double space;
  final Color color;

  const DashedDivider({
    super.key,
    this.dashWidth = 5.0,
    this.dashHeight = 1.0,
    this.space = 3.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / (dashWidth + space)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}