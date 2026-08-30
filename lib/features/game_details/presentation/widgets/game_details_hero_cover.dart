import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

class GameDetailsHeroCover extends StatelessWidget {
  const GameDetailsHeroCover({
    this.coverUrl,
    super.key,
  });

  final String? coverUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final coverHeight = screenHeight * 0.38;

    return SizedBox(
      height: coverHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Cover Image ──────────────────────────────────────────────────
          if (coverUrl != null && coverUrl!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: coverUrl!,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              placeholder: (context, url) =>
                  _CoverPlaceholder(colorScheme: colorScheme),
              errorWidget: (context, url, error) =>
                  _CoverPlaceholder(colorScheme: colorScheme),
            )
          else
            _CoverPlaceholder(colorScheme: colorScheme),

          // ── Gradient Overlay for smooth blending ─────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.3, 0.65, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
                    theme.scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colorScheme.surfaceContainerLow,
      child: Center(
        child: Icon(
          Icons.sports_esports_outlined,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
          size: AppSize.s60,
        ),
      ),
    );
  }
}
