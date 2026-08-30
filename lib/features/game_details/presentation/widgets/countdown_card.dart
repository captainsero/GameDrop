import 'package:flutter/material.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';
import '../../../../core/constants/values_manager.dart';

class CountdownCard extends StatelessWidget {
  const CountdownCard({
    required this.value,
    required this.label,
    super.key,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSize.s48,
          height: AppSize.s48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(RadiusSize.r12),
            border: Border.all(
              color: colorScheme.secondary.withValues(alpha: 0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.secondary.withValues(alpha: 0.12),
                blurRadius: AppSize.s8,
                spreadRadius: AppSize.s1,
              ),
            ],
          ),
          child: Text(
            value,
            style: getBoldStyle(
              fontFamily: FontConstants.outfit,
              color: colorScheme.secondary,
              fontSize: FontSize.s18,
            ),
          ),
        ),
        const SizedBox(height: AppSize.s6),
        Text(
          label,
          style: getSemiBoldStyle(
            fontFamily: FontConstants.outfit,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            fontSize: FontSize.s10,
          ),
        ),
      ],
    );
  }
}
