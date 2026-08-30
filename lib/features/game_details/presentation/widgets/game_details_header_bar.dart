import 'package:flutter/material.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';
import '../../../../core/constants/values_manager.dart';

class GameDetailsHeaderBar extends StatelessWidget {
  const GameDetailsHeaderBar({
    this.category = 'ACTION RPG',
    this.onBack,
    super.key,
  });

  final String category;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ── Back Button ──────────────────────────────────────────────────
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(RadiusSize.r20),
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12,
                  vertical: AppPadding.p8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow.withValues(
                    alpha: 0.85,
                  ),
                  borderRadius: BorderRadius.circular(RadiusSize.r20),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: AppSize.s14,
                      color: colorScheme.onSurface,
                    ),
                    const SizedBox(width: AppSize.s6),
                    Text(
                      'Back',
                      style: getMediumStyle(
                        fontFamily: FontConstants.outfit,
                        color: colorScheme.onSurface,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Genre / Category Badge ───────────────────────────────────────
          if (category.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p12,
                vertical: AppPadding.p8,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(RadiusSize.r20),
                border: Border.all(
                  color: colorScheme.secondary.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                category.toUpperCase(),
                style: getBoldStyle(
                  fontFamily: FontConstants.outfit,
                  color: colorScheme.secondary,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
