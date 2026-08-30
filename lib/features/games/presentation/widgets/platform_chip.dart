import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

class PlatformChip extends StatelessWidget {
  const PlatformChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p2,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(RadiusSize.r100),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
