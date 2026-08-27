import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/values_manager.dart';
import '../view_model/games_event.dart';
import '../view_model/games_state.dart';
import '../view_model/games_view_model.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/game_card.dart';
import '../widgets/loading_view.dart';

class GamesView extends StatelessWidget {
  const GamesView({super.key});

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
            return const LoadingView();
          }

          // ── Error ─────────────────────────────────────────────────────
          if (upcomingState.errorMessage != null) {
            return ErrorView(
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
          return const EmptyView();
        },
      ),
    );
  }
}
