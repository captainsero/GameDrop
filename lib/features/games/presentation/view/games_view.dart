import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/constants/values_manager.dart';
import '../view_model/games_event.dart';
import '../view_model/games_state.dart';
import '../view_model/games_view_model.dart';
import '../widgets/game_card.dart';

class GamesView extends StatelessWidget {
  const GamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final vm = getIt<GamesViewModel>();
        unawaited(vm.onEvent(GetUpcomingGamesEvent(page: 1)));
        return vm;
      },
      child: const _GamesViewBody(),
    );
  }
}

class _GamesViewBody extends StatelessWidget {
  const _GamesViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: AppSize.s50,
        toolbarHeight: AppSize.s50,
        leading: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(RadiusSize.r16),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text('GameDrop'),
        titleSpacing: AppSize.s0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: BlocBuilder<GamesViewModel, GamesState>(
        buildWhen: (prev, curr) =>
            prev.getUpcomingGamesState != curr.getUpcomingGamesState,
        builder: (context, state) {
          final upcomingState = state.getUpcomingGamesState;

          // ── Loading ───────────────────────────────────────────────────
          if (upcomingState.isLoading == true) {
            return const _LoadingView();
          }

          // ── Error ─────────────────────────────────────────────────────
          if (upcomingState.errorMessage != null) {
            return _ErrorView(
              message: upcomingState.errorMessage!,
              onRetry: () => context
                  .read<GamesViewModel>()
                  .onEvent(GetUpcomingGamesEvent(page: 1)),
            );
          }

          // ── Success ───────────────────────────────────────────────────
          final games = upcomingState.data;
          if (games != null && games.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
              itemCount: games.length,
              itemBuilder: (context, index) => GameCard(game: games[index]),
            );
          }

          // ── Empty ─────────────────────────────────────────────────────
          return const _EmptyView();
        },
      ),
    );
  }
}

// ─── Loading ─────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

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
        child: _ShimmerCard(color: colorScheme.surfaceContainerLow),
      ),
    );
  }
}

class _ShimmerCard extends StatefulWidget {
  const _ShimmerCard({required this.color});
  final Color color;

  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard>
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
                      _ShimmerLine(
                        color: colorScheme.surfaceContainerHighest,
                        width: AppSize.s80,
                        height: AppSize.s8,
                      ),
                      _ShimmerLine(
                        color: colorScheme.surfaceContainerHighest,
                        width: double.infinity,
                        height: AppSize.s14,
                      ),
                      _ShimmerLine(
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

class _ShimmerLine extends StatelessWidget {
  const _ShimmerLine({
    required this.color,
    required this.width,
    required this.height,
  });

  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(RadiusSize.r4),
      ),
    );
  }
}

// ─── Error ─────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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
              Icons.wifi_off_rounded,
              size: AppSize.s60,
              color: colorScheme.error,
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              'Something went wrong',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.s8),
            Text(
              message,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSize.s30),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty ─────────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  const _EmptyView();

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
