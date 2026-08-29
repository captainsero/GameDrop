import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videogame_asset_off_outlined,
              size: AppSize.s60,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              'No upcoming games found',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
