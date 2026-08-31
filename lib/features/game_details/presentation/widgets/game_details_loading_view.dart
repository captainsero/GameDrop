import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

class GameDetailsLoadingView extends StatefulWidget {
  const GameDetailsLoadingView({super.key});

  @override
  State<GameDetailsLoadingView> createState() => _GameDetailsLoadingViewState();
}

class _GameDetailsLoadingViewState extends State<GameDetailsLoadingView>
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        final shimmer = Color.lerp(
          colorScheme.surfaceContainerLow,
          colorScheme.surfaceContainerHigh,
          _anim.value,
        )!;

        final shimmerElement = Color.lerp(
          colorScheme.surfaceContainerHigh,
          colorScheme.surfaceContainerHighest,
          _anim.value,
        )!;

        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hero Cover Skeleton ──────────────────────────────────────
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.38,
                    width: double.infinity,
                    color: shimmer,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.5, 1.0],
                          colors: [
                            colorScheme.surfaceContainerLowest.withValues(
                              alpha: 0.3,
                            ),
                            Colors.transparent,
                            theme.scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p16,
                        vertical: AppPadding.p8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: AppSize.s70,
                            height: AppSize.s35,
                            decoration: BoxDecoration(
                              color: shimmerElement,
                              borderRadius: BorderRadius.circular(
                                RadiusSize.r20,
                              ),
                            ),
                          ),
                          Container(
                            width: AppSize.s100,
                            height: AppSize.s35,
                            decoration: BoxDecoration(
                              color: shimmerElement,
                              borderRadius: BorderRadius.circular(
                                RadiusSize.r20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ── Title & Info Skeleton ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSize.s200,
                      height: AppSize.s25,
                      decoration: BoxDecoration(
                        color: shimmerElement,
                        borderRadius: BorderRadius.circular(RadiusSize.r4),
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    Container(
                      width: AppSize.s130,
                      height: AppSize.s14,
                      decoration: BoxDecoration(
                        color: shimmerElement,
                        borderRadius: BorderRadius.circular(RadiusSize.r4),
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Container(
                          width: AppSize.s60,
                          height: AppSize.s24,
                          decoration: BoxDecoration(
                            color: shimmerElement,
                            borderRadius: BorderRadius.circular(RadiusSize.r20),
                          ),
                        ),
                        const SizedBox(width: AppSize.s8),
                        Container(
                          width: AppSize.s60,
                          height: AppSize.s24,
                          decoration: BoxDecoration(
                            color: shimmerElement,
                            borderRadius: BorderRadius.circular(RadiusSize.r20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSize.s24),

              // ── Countdown Skeleton ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSize.s100,
                      height: AppSize.s12,
                      decoration: BoxDecoration(
                        color: shimmerElement,
                        borderRadius: BorderRadius.circular(RadiusSize.r4),
                      ),
                    ),
                    const SizedBox(height: AppSize.s14),
                    Row(
                      children: [
                        Container(
                          width: AppSize.s48,
                          height: AppSize.s48,
                          decoration: BoxDecoration(
                            color: shimmer,
                            borderRadius: BorderRadius.circular(RadiusSize.r12),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s8),
                        Container(
                          width: AppSize.s48,
                          height: AppSize.s48,
                          decoration: BoxDecoration(
                            color: shimmer,
                            borderRadius: BorderRadius.circular(RadiusSize.r12),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s8),
                        Container(
                          width: AppSize.s48,
                          height: AppSize.s48,
                          decoration: BoxDecoration(
                            color: shimmer,
                            borderRadius: BorderRadius.circular(RadiusSize.r12),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s8),
                        Container(
                          width: AppSize.s48,
                          height: AppSize.s48,
                          decoration: BoxDecoration(
                            color: shimmer,
                            borderRadius: BorderRadius.circular(RadiusSize.r12),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                  vertical: AppPadding.p12,
                ),
                child: Divider(),
              ),

              // ── About Skeleton ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSize.s60,
                      height: AppSize.s12,
                      decoration: BoxDecoration(
                        color: shimmerElement,
                        borderRadius: BorderRadius.circular(RadiusSize.r4),
                      ),
                    ),
                    const SizedBox(height: AppSize.s12),
                    Container(
                      width: double.infinity,
                      height: AppSize.s14,
                      decoration: BoxDecoration(
                        color: shimmerElement,
                        borderRadius: BorderRadius.circular(RadiusSize.r4),
                      ),
                    ),
                    const SizedBox(height: AppSize.s8),
                    Container(
                      width: double.infinity,
                      height: AppSize.s14,
                      decoration: BoxDecoration(
                        color: shimmerElement,
                        borderRadius: BorderRadius.circular(RadiusSize.r4),
                      ),
                    ),
                    const SizedBox(height: AppSize.s8),
                    Container(
                      width: AppSize.s200,
                      height: AppSize.s14,
                      decoration: BoxDecoration(
                        color: shimmerElement,
                        borderRadius: BorderRadius.circular(RadiusSize.r4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
