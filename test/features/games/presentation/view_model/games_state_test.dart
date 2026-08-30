import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_state/base_state.dart';
import 'package:gamedrop/features/games/domain/entities/game_entity.dart';
import 'package:gamedrop/features/games/presentation/view_model/games_state.dart';

void main() {
  group('GamesState', () {
    const tEntity = GameEntity(
      id: 1,
      name: 'Game 1',
      coverUrl: null,
      releaseDate: null,
      tba: false,
      platforms: ['PC'],
    );

    test('initial state should have default values', () {
      const state = GamesState();

      expect(state.getUpcomingGamesState, const BaseState<List<GameEntity>>());
      expect(state.searchGamesState, const BaseState<List<GameEntity>>());
      expect(state.isSearchActive, false);
    });

    test('copyWith should update specified fields and preserve others', () {
      const initialState = GamesState();

      final updatedState = initialState.copyWith(
        isSearchActive: true,
        getUpcomingGamesState: const BaseState<List<GameEntity>>(
          data: [tEntity],
        ),
      );

      expect(updatedState.isSearchActive, true);
      expect(updatedState.getUpcomingGamesState.data, [tEntity]);
      expect(
        updatedState.searchGamesState,
        const BaseState<List<GameEntity>>(),
      );
    });

    test('props should support value equality', () {
      const state1 = GamesState(
        isSearchActive: true,
        getUpcomingGamesState: BaseState(data: [tEntity]),
      );
      const state2 = GamesState(
        isSearchActive: true,
        getUpcomingGamesState: BaseState(data: [tEntity]),
      );
      const state3 = GamesState(
        getUpcomingGamesState: BaseState(data: [tEntity]),
      );

      expect(state1, equals(state2));
      expect(state1 == state3, isFalse);
    });
  });
}
