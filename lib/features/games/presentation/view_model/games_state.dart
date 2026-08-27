import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/game_entity.dart';

class GamesState extends Equatable {
  const GamesState({
    this.getUpcomingGamesState = const BaseState<List<GameEntity>>(),
    this.searchGamesState = const BaseState<List<GameEntity>>(),
    this.isSearchActive = false,
  });

  GamesState copyWith({
    BaseState<List<GameEntity>>? getUpcomingGamesState,
    BaseState<List<GameEntity>>? searchGamesState,
    bool? isSearchActive,
  }) => GamesState(
    getUpcomingGamesState:
        getUpcomingGamesState ?? this.getUpcomingGamesState,
    searchGamesState: searchGamesState ?? this.searchGamesState,
    isSearchActive: isSearchActive ?? this.isSearchActive,
  );

  final BaseState<List<GameEntity>> getUpcomingGamesState;
  final BaseState<List<GameEntity>> searchGamesState;
  final bool isSearchActive;

  @override
  List<Object?> get props =>
      [getUpcomingGamesState, searchGamesState, isSearchActive];
}
