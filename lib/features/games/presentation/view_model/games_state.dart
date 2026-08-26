import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/game_entity.dart';

class GamesState extends Equatable {
  const GamesState({
    this.getUpcomingGamesState = const BaseState<List<GameEntity>>(),
  });

  GamesState copyWith({BaseState<List<GameEntity>>? getUpcomingGamesState}) =>
      GamesState(
        getUpcomingGamesState:
            getUpcomingGamesState ?? this.getUpcomingGamesState,
      );

  final BaseState<List<GameEntity>> getUpcomingGamesState;

  @override
  List<Object?> get props => [getUpcomingGamesState];
}
