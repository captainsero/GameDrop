import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

class GameCover extends StatelessWidget {
  const GameCover({required this.coverUrl, super.key});

  final String? coverUrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final size = MediaQuery.sizeOf(context).width * 0.18;
    final clampedSize = size.clamp(64.0, 96.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(RadiusSize.r10),
      child: SizedBox(
        width: clampedSize,
        height: clampedSize * 1.3,
        child: coverUrl != null && coverUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: coverUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => _CoverPlaceholder(
                  color: colorScheme.surfaceContainerLow,
                ),
                errorWidget: (context, url, error) => _CoverError(
                  color: colorScheme.surfaceContainerLow,
                  iconColor: colorScheme.onSurfaceVariant,
                ),
              )
            : _CoverPlaceholder(color: colorScheme.surfaceContainerLow),
      ),
    );
  }
}

// ─── Internal helpers ────────────────────────────────────────────────────────

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Center(
        child: Icon(
          Icons.videogame_asset_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: AppSize.s30,
        ),
      ),
    );
  }
}

class _CoverError extends StatelessWidget {
  const _CoverError({required this.color, required this.iconColor});
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: iconColor,
          size: AppSize.s30,
        ),
      ),
    );
  }
}
