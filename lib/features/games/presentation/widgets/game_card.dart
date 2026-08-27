import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';
import '../../domain/entities/game_entity.dart';
import 'game_cover.dart';
import 'platform_chip.dart';
import 'release_badge.dart';

class GameCard extends StatelessWidget {
  const GameCard({required this.game, super.key});

  final GameEntity game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(RadiusSize.r16),
        onTap: () {
          // Navigate to game details — route will be wired up when the
          // GameDetails feature is ready.
          // context.push('${RoutePath.gameDetailsRoute}/${game.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Cover art ──────────────────────────────────────────────
              GameCover(coverUrl: game.coverUrl),

              const SizedBox(width: AppSize.s12),

              // ── Info column ────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (game.platforms.isNotEmpty)
                      Text(
                        game.platforms.take(2).join(' / ').toUpperCase(),
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.secondary,
                          letterSpacing: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: AppSize.s4),

                    Text(
                      game.name,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: AppSize.s4),

                    Wrap(
                      spacing: AppSize.s6,
                      runSpacing: AppSize.s4,
                      children: game.platforms
                          .map((p) => PlatformChip(label: p))
                          .toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSize.s8),

              // ── Days-until-release badge ──────────────────────────────
              ReleaseBadge(game: game),
            ],
          ),
        ),
      ),
    );
  }
}
