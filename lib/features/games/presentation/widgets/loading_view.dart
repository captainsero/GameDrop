import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';
import 'shimmer_card.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p8,
        ),
        child: ShimmerCard(color: colorScheme.surfaceContainerLow),
      ),
    );
  }
}
