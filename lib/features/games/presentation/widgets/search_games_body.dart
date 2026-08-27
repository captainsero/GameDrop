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
import 'search_hint_view.dart';

/// Displays search results, loading, error, empty, or an idle hint.
/// Rebuilds only when [GamesState.searchGamesState] changes.
///
/// [searchController] is used only to re-read the last typed query on Retry.
class SearchGamesBody extends StatelessWidget {
  const SearchGamesBody({required this.searchController, super.key});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesViewModel, GamesState>(
      buildWhen: (prev, curr) =>
          prev.searchGamesState != curr.searchGamesState,
      builder: (context, state) {
        final s = state.searchGamesState;

        // Idle: search is open but no keystroke yet
        if (s.isLoading != true && s.data == null && s.errorMessage == null) {
          return const SearchHintView();
        }

        if (s.isLoading == true) return const LoadingView();

        if (s.errorMessage != null) {
          return ErrorView(
            message: s.errorMessage!,
            onRetry: () {
              final query = searchController.text.trim();
              if (query.isNotEmpty) {
                unawaited(
                  context
                      .read<GamesViewModel>()
                      .onEvent(SearchGamesEvent(query: query)),
                );
              }
            },
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
