import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

class ShimmerLine extends StatelessWidget {
  const ShimmerLine({
    required this.color,
    required this.width,
    required this.height,
    super.key,
  });

  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(RadiusSize.r4),
      ),
    );
  }
}
