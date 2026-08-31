import 'package:flutter/material.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';
import '../../../../core/constants/values_manager.dart';
import '../../domain/entities/game_detail_entity.dart';

class GameDetailsInfoSection extends StatelessWidget {
  const GameDetailsInfoSection({
    required this.game,
    super.key,
  });

  final GameDetailEntity game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Game Title ───────────────────────────────────────────────────
          Text(
            game.name,
            style: getBoldStyle(
              fontFamily: FontConstants.outfit,
              color: colorScheme.onSurface,
              fontSize: FontSize.s25,
            ),
          ),
          const SizedBox(height: AppSize.s6),

          // ── Subtitle / Platform Summary ──────────────────────────────────
          if (game.platforms.isNotEmpty)
            Text(
              game.platforms.join(' \u00B7 '),
              style: getRegularStyle(
                fontFamily: FontConstants.outfit,
                color: colorScheme.onSurfaceVariant,
                fontSize: FontSize.s14,
              ),
            ),
          const SizedBox(height: AppSize.s16),

          // ── Platform Badges ──────────────────────────────────────────────
          if (game.platforms.isNotEmpty)
            Wrap(
              spacing: AppSize.s8,
              runSpacing: AppSize.s8,
              children: game.platforms.map((platform) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                    vertical: AppPadding.p4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow.withValues(
                      alpha: 0.6,
                    ),
                    borderRadius: BorderRadius.circular(RadiusSize.r20),
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    platform,
                    style: getMediumStyle(
                      fontFamily: FontConstants.outfit,
                      color: colorScheme.primary,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
