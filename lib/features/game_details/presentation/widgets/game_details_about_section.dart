import 'package:flutter/material.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';
import '../../../../core/constants/values_manager.dart';

class GameDetailsAboutSection extends StatelessWidget {
  const GameDetailsAboutSection({
    required this.summary,
    super.key,
  });

  final String summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Label ────────────────────────────────────────────────
          Text(
            'ABOUT',
            style: getBoldStyle(
              fontFamily: FontConstants.outfit,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ).copyWith(letterSpacing: 1.5),
          ),
          const SizedBox(height: AppSize.s12),

          // ── Summary Body Text ────────────────────────────────────────────
          Text(
            summary.isNotEmpty
                ? summary
                : 'No summary available for this title.',
            style: getRegularStyle(
              fontFamily: FontConstants.outfit,
              color: colorScheme.onSurfaceVariant,
              fontSize: FontSize.s14,
            ).copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
