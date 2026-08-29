import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/config/base_state/base_state.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/games/domain/entities/game_entity.dart';
import 'package:gamedrop/features/games/domain/use_cases/get_upcoming_games_use_case.dart';
import 'package:gamedrop/features/games/domain/use_cases/search_games_use_case.dart';
import 'package:gamedrop/features/games/presentation/view_model/games_event.dart';
import 'package:gamedrop/features/games/presentation/view_model/games_state.dart';
import 'package:gamedrop/features/games/presentation/view_model/games_view_model.dart';
import 'package:gamedrop/generated/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUpcomingGamesUseCase extends Mock
    implements GetUpcomingGamesUseCase {}

class MockSearchGamesUseCase extends Mock implements SearchGamesUseCase {}

void main() {
  late MockGetUpcomingGamesUseCase mockGetUpcomingGamesUseCase;
  late MockSearchGamesUseCase mockSearchGamesUseCase;

  setUpAll(() async {
    await S.load(const Locale('en'));
  });

  setUp(() {
    mockGetUpcomingGamesUseCase = MockGetUpcomingGamesUseCase();
    mockSearchGamesUseCase = MockSearchGamesUseCase();
  });

  const tGamesList = [
    GameEntity(
      id: 1,
      name: 'Cyberpunk 2077 Orion',
      coverUrl: 'https://example.com/cover.png',
      releaseDate: null,
      tba: true,
      platforms: ['PC', 'PS5'],
    ),
  ];

  GamesViewModel createViewModel() {
    return GamesViewModel(
      getUpcomingGamesUseCase: mockGetUpcomingGamesUseCase,
      searchGamesUseCase: mockSearchGamesUseCase,
    );
  }

  group('GamesViewModel', () {
    test('initial state is GamesState()', () {
      final viewModel = createViewModel();
      expect(viewModel.state, const GamesState());
    });

    group('GetUpcomingGamesEvent', () {
      blocTest<GamesViewModel, GamesState>(
        'emits loading then success state when getUpcomingGames succeeds',
        build: () {
          when(() => mockGetUpcomingGamesUseCase(page: 1)).thenAnswer(
            (_) async => const SuccessBaseResponse(data: tGamesList),
          );
          return createViewModel();
        },
        act: (cubit) => cubit.onEvent(GetUpcomingGamesEvent(page: 1)),
        expect: () => [
          const GamesState(
            getUpcomingGamesState: BaseState(isLoading: true),
          ),
          const GamesState(
            getUpcomingGamesState: BaseState(data: tGamesList),
          ),
        ],
        verify: (_) {
          verify(() => mockGetUpcomingGamesUseCase(page: 1)).called(1);
        },
      );

      blocTest<GamesViewModel, GamesState>(
        'emits loading then error state when getUpcomingGames fails',
        build: () {
          when(() => mockGetUpcomingGamesUseCase(page: 1)).thenAnswer(
            (_) async => const ErrorBaseResponse(
              error: NetworkError(),
            ),
          );
          return createViewModel();
        },
        act: (cubit) => cubit.onEvent(GetUpcomingGamesEvent(page: 1)),
        expect: () => [
          const GamesState(
            getUpcomingGamesState: BaseState(isLoading: true),
          ),
          isA<GamesState>().having(
            (s) => s.getUpcomingGamesState.errorMessage,
            'errorMessage',
            isNotNull,
          ),
        ],
      );
    });

    group('Search UI Events', () {
      blocTest<GamesViewModel, GamesState>(
        'OpenSearchEvent emits isSearchActive = true',
        build: createViewModel,
        act: (cubit) => cubit.onEvent(OpenSearchEvent()),
        expect: () => [
          const GamesState(isSearchActive: true),
        ],
      );

      blocTest<GamesViewModel, GamesState>(
        'CloseSearchEvent emits isSearchActive = false and resets searchGamesState',
        build: createViewModel,
        seed: () => const GamesState(
          isSearchActive: true,
          searchGamesState: BaseState(data: tGamesList),
        ),
        act: (cubit) => cubit.onEvent(CloseSearchEvent()),
        expect: () => [
          const GamesState(),
        ],
      );

      blocTest<GamesViewModel, GamesState>(
        'ClearSearchEvent resets searchGamesState to empty BaseState',
        build: createViewModel,
        seed: () => const GamesState(
          isSearchActive: true,
          searchGamesState: BaseState(data: tGamesList),
        ),
        act: (cubit) => cubit.onEvent(ClearSearchEvent()),
        expect: () => [
          const GamesState(isSearchActive: true),
        ],
      );
    });

    group('SearchGamesEvent', () {
      blocTest<GamesViewModel, GamesState>(
        'emits loading then success state when search succeeds',
        build: () {
          when(() => mockSearchGamesUseCase(query: 'Cyberpunk')).thenAnswer(
            (_) async => const SuccessBaseResponse(data: tGamesList),
          );
          return createViewModel();
        },
        act: (cubit) => cubit.onEvent(SearchGamesEvent(query: 'Cyberpunk')),
        expect: () => [
          const GamesState(
            searchGamesState: BaseState(isLoading: true),
          ),
          const GamesState(
            searchGamesState: BaseState(data: tGamesList),
          ),
        ],
        verify: (_) {
          verify(() => mockSearchGamesUseCase(query: 'Cyberpunk')).called(1);
        },
      );

      blocTest<GamesViewModel, GamesState>(
        'emits loading then error state when search fails',
        build: () {
          when(() => mockSearchGamesUseCase(query: 'Missing')).thenAnswer(
            (_) async => const ErrorBaseResponse(
              error: LocalStorageError(),
            ),
          );
          return createViewModel();
        },
        act: (cubit) => cubit.onEvent(SearchGamesEvent(query: 'Missing')),
        expect: () => [
          const GamesState(
            searchGamesState: BaseState(isLoading: true),
          ),
          isA<GamesState>().having(
            (s) => s.searchGamesState.errorMessage,
            'errorMessage',
            isNotNull,
          ),
        ],
      );
    });
  });
}
