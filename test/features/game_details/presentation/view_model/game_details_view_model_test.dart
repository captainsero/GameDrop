import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/config/base_state/base_state.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';
import 'package:gamedrop/features/game_details/domain/use_cases/get_game_detail_use_case.dart';
import 'package:gamedrop/features/game_details/presentation/view_model/game_details_event.dart';
import 'package:gamedrop/features/game_details/presentation/view_model/game_details_state.dart';
import 'package:gamedrop/features/game_details/presentation/view_model/game_details_view_model.dart';
import 'package:gamedrop/generated/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockGetGameDetailUseCase extends Mock implements GetGameDetailUseCase {}

void main() {
  late MockGetGameDetailUseCase mockGetGameDetailUseCase;

  setUpAll(() async {
    await S.load(const Locale('en'));
  });

  setUp(() {
    mockGetGameDetailUseCase = MockGetGameDetailUseCase();
  });

  const tEntity = GameDetailEntity(
    id: 1,
    name: 'Metroid Prime 4: Beyond',
    coverUrl: null,
    releaseDate: null,
    tba: false,
    platforms: ['Nintendo Switch'],
    summary: 'The galaxy is in peril.',
  );

  GameDetailsViewModel createViewModel() => GameDetailsViewModel(
    getGameDetailUseCase: mockGetGameDetailUseCase,
  );

  group('GameDetailsViewModel', () {
    test('initial state is GameDetailsState()', () {
      final viewModel = createViewModel();
      expect(viewModel.state, const GameDetailsState());
    });

    group('GetGameDetailEvent', () {
      blocTest<GameDetailsViewModel, GameDetailsState>(
        'emits loading then success state when getGameDetailUseCase succeeds',
        build: () {
          when(() => mockGetGameDetailUseCase(id: 1)).thenAnswer(
            (_) async => const SuccessBaseResponse(data: tEntity),
          );
          return createViewModel();
        },
        act: (cubit) => cubit.onEvent(GetGameDetailEvent(id: 1)),
        expect: () => [
          const GameDetailsState(
            getGameDetailState: BaseState(isLoading: true),
          ),
          const GameDetailsState(
            getGameDetailState: BaseState(data: tEntity),
          ),
        ],
        verify: (_) {
          verify(() => mockGetGameDetailUseCase(id: 1)).called(1);
        },
      );

      blocTest<GameDetailsViewModel, GameDetailsState>(
        'emits loading then error state when getGameDetailUseCase fails',
        build: () {
          when(() => mockGetGameDetailUseCase(id: 1)).thenAnswer(
            (_) async => const ErrorBaseResponse(error: NetworkError()),
          );
          return createViewModel();
        },
        act: (cubit) => cubit.onEvent(GetGameDetailEvent(id: 1)),
        expect: () => [
          const GameDetailsState(
            getGameDetailState: BaseState(isLoading: true),
          ),
          isA<GameDetailsState>().having(
            (s) => s.getGameDetailState.errorMessage,
            'errorMessage',
            isNotNull,
          ),
        ],
      );
    });
  });
}
