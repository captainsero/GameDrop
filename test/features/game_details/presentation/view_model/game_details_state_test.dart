import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_state/base_state.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';
import 'package:gamedrop/features/game_details/presentation/view_model/game_details_state.dart';

void main() {
  group('GameDetailsState', () {
    const tEntity = GameDetailEntity(
      id: 1,
      name: 'Game Detail',
      coverUrl: null,
      releaseDate: null,
      tba: false,
      platforms: ['PC'],
      summary: 'Summary text',
    );

    test('initial state has default values', () {
      const state = GameDetailsState();

      expect(state.getGameDetailState, const BaseState<GameDetailEntity>());
    });

    test('copyWith updates specified fields', () {
      const initialState = GameDetailsState();

      final updated = initialState.copyWith(
        getGameDetailState: const BaseState(data: tEntity),
      );

      expect(updated.getGameDetailState.data, tEntity);
    });

    test('props support value equality', () {
      const state1 = GameDetailsState(
        getGameDetailState: BaseState(data: tEntity),
      );
      const state2 = GameDetailsState(
        getGameDetailState: BaseState(data: tEntity),
      );

      expect(state1, equals(state2));
    });
  });
}
