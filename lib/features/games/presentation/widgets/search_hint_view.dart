import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

/// Shown when the user opens search but has not submitted a query yet.
class SearchHintView extends StatelessWidget {
  const SearchHintView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search,
            size: AppSize.s60,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          ),
          const SizedBox(height: AppSize.s12),
          Text(
            'Type a game name and press search',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
