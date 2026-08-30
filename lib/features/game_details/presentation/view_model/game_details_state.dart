import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/game_detail_entity.dart';

class GameDetailsState extends Equatable {
  const GameDetailsState({
    this.getGameDetailState = const BaseState<GameDetailEntity>(),
  });

  final BaseState<GameDetailEntity> getGameDetailState;

  GameDetailsState copyWith({
    BaseState<GameDetailEntity>? getGameDetailState,
  }) => GameDetailsState(
    getGameDetailState: getGameDetailState ?? this.getGameDetailState,
  );

  @override
  List<Object?> get props => [getGameDetailState];
}
