import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';
import 'shimmer_line.dart';

class ShimmerCard extends StatefulWidget {
  const ShimmerCard({required this.color, super.key});
  final Color color;

  @override
  State<ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<ShimmerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        final shimmer = Color.lerp(
          widget.color,
          colorScheme.surfaceContainerHigh,
          _anim.value,
        )!;

        return Container(
          height: AppSize.s100,
          decoration: BoxDecoration(
            color: shimmer,
            borderRadius: BorderRadius.circular(RadiusSize.r16),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              // Cover placeholder
              Container(
                width: AppSize.s80,
                margin: const EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(RadiusSize.r10),
                ),
              ),
              // Text lines placeholder
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShimmerLine(
                        color: colorScheme.surfaceContainerHighest,
                        width: AppSize.s80,
                        height: AppSize.s8,
                      ),
                      ShimmerLine(
                        color: colorScheme.surfaceContainerHighest,
                        width: double.infinity,
                        height: AppSize.s14,
                      ),
                      ShimmerLine(
                        color: colorScheme.surfaceContainerHighest,
                        width: AppSize.s100,
                        height: AppSize.s8,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s8),
              // Badge placeholder
              Container(
                width: AppSize.s60,
                height: AppSize.s40,
                margin: const EdgeInsets.only(right: AppPadding.p12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(RadiusSize.r12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
