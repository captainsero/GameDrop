import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';
import '../../domain/entities/game_entity.dart';

class ReleaseBadge extends StatelessWidget {
  const ReleaseBadge({required this.game, super.key});

  final GameEntity game;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final days = game.daysUntilRelease;
    final isTba = game.tba || game.releaseDate == null;

    final String label;
    if (isTba) {
      label = 'TBA';
    } else if (days == 0) {
      label = 'OUT\nNOW';
    } else {
      label = '$days\nDAYS';
    }

    return Container(
      constraints: const BoxConstraints(minWidth: AppSize.s60),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(RadiusSize.r12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.hourglass_bottom_rounded,
            size: AppSize.s14,
            color: colorScheme.secondary,
          ),
          const SizedBox(width: AppSize.s4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
