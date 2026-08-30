import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/values_manager.dart';
import '../view_model/games_event.dart';
import '../view_model/games_state.dart';
import '../view_model/games_view_model.dart';
import 'empty_view.dart';
import 'error_view.dart';
import 'game_card.dart';
import 'loading_view.dart';

/// Displays the list of upcoming games, or loading / error / empty states.
/// Rebuilds only when [GamesState.getUpcomingGamesState] changes.
class UpcomingGamesBody extends StatelessWidget {
  const UpcomingGamesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesViewModel, GamesState>(
      buildWhen: (prev, curr) =>
          prev.getUpcomingGamesState != curr.getUpcomingGamesState,
      builder: (context, state) {
        final s = state.getUpcomingGamesState;

        if (s.isLoading == true) return const LoadingView();

        if (s.errorMessage != null) {
          return ErrorView(
            message: s.errorMessage!,
            onRetry: () => unawaited(
              context.read<GamesViewModel>().onEvent(
                GetUpcomingGamesEvent(page: 1),
              ),
            ),
          );
        }

        final games = s.data;
        if (games != null && games.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
            itemCount: games.length,
            itemBuilder: (context, index) => GameCard(game: games[index]),
          );
        }

        return const EmptyView();
      },
    );
  }
}
