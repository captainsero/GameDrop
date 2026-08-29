import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/games/domain/entities/game_entity.dart';
import 'package:gamedrop/features/games/domain/repo/games_repo_contract.dart';
import 'package:gamedrop/features/games/domain/use_cases/search_games_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGamesRepoContract extends Mock implements GamesRepoContract {}

void main() {
  late MockGamesRepoContract mockRepoContract;
  late SearchGamesUseCase useCase;

  setUp(() {
    mockRepoContract = MockGamesRepoContract();
    useCase = SearchGamesUseCase(repoContract: mockRepoContract);
  });

  const tQuery = 'Zelda';
  const tGameList = [
    GameEntity(
      id: 202,
      name: 'The Legend of Zelda',
      coverUrl: null,
      releaseDate: null,
      tba: false,
      platforms: ['Nintendo Switch'],
    ),
  ];

  group('SearchGamesUseCase', () {
    test(
      'should forward query to GamesRepoContract and return matching games',
      () async {
        when(
          () => mockRepoContract.searchGames(query: any(named: 'query')),
        ).thenAnswer((_) async => const SuccessBaseResponse(data: tGameList));

        final result = await useCase(query: tQuery);

        expect(result, isA<SuccessBaseResponse<List<GameEntity>>>());
        expect(
          (result as SuccessBaseResponse<List<GameEntity>>).data,
          tGameList,
        );
        verify(() => mockRepoContract.searchGames(query: tQuery)).called(1);
        verifyNoMoreInteractions(mockRepoContract);
      },
    );

    test(
      'should return ErrorBaseResponse when repository fails or cache is empty',
      () async {
        const tError = LocalStorageError();
        when(
          () => mockRepoContract.searchGames(query: any(named: 'query')),
        ).thenAnswer((_) async => const ErrorBaseResponse(error: tError));

        final result = await useCase(query: tQuery);

        expect(result, isA<ErrorBaseResponse<List<GameEntity>>>());
        expect((result as ErrorBaseResponse<List<GameEntity>>).error, tError);
        verify(() => mockRepoContract.searchGames(query: tQuery)).called(1);
        verifyNoMoreInteractions(mockRepoContract);
      },
    );
  });
}
