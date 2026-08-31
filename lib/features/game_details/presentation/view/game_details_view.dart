import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/values_manager.dart';
import '../../../games/presentation/widgets/empty_view.dart';
import '../../../games/presentation/widgets/error_view.dart';
import '../view_model/game_details_event.dart';
import '../view_model/game_details_state.dart';
import '../view_model/game_details_view_model.dart';
import '../widgets/game_details_about_section.dart';
import '../widgets/game_details_countdown_section.dart';
import '../widgets/game_details_header_bar.dart';
import '../widgets/game_details_hero_cover.dart';
import '../widgets/game_details_info_section.dart';
import '../widgets/game_details_loading_view.dart';

class GameDetailsView extends StatelessWidget {
  const GameDetailsView({
    required this.gameId,
    super.key,
  });

  final int gameId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<GameDetailsViewModel, GameDetailsState>(
        builder: (context, state) {
          final s = state.getGameDetailState;

          if (s.isLoading == true) {
            return const GameDetailsLoadingView();
          }

          if (s.errorMessage != null) {
            return ErrorView(
              message: s.errorMessage!,
              onRetry: () => unawaited(
                context.read<GameDetailsViewModel>().onEvent(
                  GetGameDetailEvent(id: gameId),
                ),
              ),
            );
          }

          final game = s.data;
          if (game == null) {
            return const EmptyView();
          }

          final category = game.platforms.isNotEmpty
              ? '${game.platforms.first} EXCLUSIVE'
              : 'FEATURED';

          return Stack(
            children: [
              // ── Scrollable Body ──────────────────────────────────────────
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Hero Cover Art ─────────────────────────────────────
                    GameDetailsHeroCover(coverUrl: game.coverUrl),

                    // ── Content Sections ──────────────────────────────────
                    Transform.translate(
                      offset: const Offset(0, -AppSize.s30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Game Metadata Info ───────────────────────────
                          GameDetailsInfoSection(game: game),
                          const SizedBox(height: AppSize.s24),

                          // ── Countdown Timer & Release Date ───────────────
                          GameDetailsCountdownSection(game: game),
                          const SizedBox(height: AppSize.s16),

                          // ── Divider ──────────────────────────────────────
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.p20,
                              vertical: AppPadding.p12,
                            ),
                            child: Divider(
                              thickness: AppSize.s1,
                            ),
                          ),

                          // ── About Section ────────────────────────────────
                          GameDetailsAboutSection(summary: game.summary),
                          const SizedBox(height: AppSize.s40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Top Navigation & Genre Overlay ───────────────────────────
              SafeArea(
                child: GameDetailsHeaderBar(category: category),
              ),
            ],
          );
        },
      ),
    );
  }
}
