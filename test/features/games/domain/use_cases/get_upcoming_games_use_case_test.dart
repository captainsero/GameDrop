import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/games/domain/entities/game_entity.dart';
import 'package:gamedrop/features/games/domain/repo/games_repo_contract.dart';
import 'package:gamedrop/features/games/domain/use_cases/get_upcoming_games_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGamesRepoContract extends Mock implements GamesRepoContract {}

void main() {
  late MockGamesRepoContract mockRepoContract;
  late GetUpcomingGamesUseCase useCase;

  setUp(() {
    mockRepoContract = MockGamesRepoContract();
    useCase = GetUpcomingGamesUseCase(repoContract: mockRepoContract);
  });

  const tGameList = [
    GameEntity(
      id: 101,
      name: 'Elden Ring DLC',
      coverUrl: 'https://example.com/cover.jpg',
      releaseDate: null,
      tba: true,
      platforms: ['PC', 'PS5'],
    ),
  ];

  group('GetUpcomingGamesUseCase', () {
    test(
      'should forward call to GamesRepoContract and return SuccessBaseResponse',
      () async {
        when(
          () => mockRepoContract.getUpcomingGames(page: any(named: 'page')),
        ).thenAnswer((_) async => const SuccessBaseResponse(data: tGameList));

        final result = await useCase(page: 1);

        expect(result, isA<SuccessBaseResponse<List<GameEntity>>>());
        expect(
          (result as SuccessBaseResponse<List<GameEntity>>).data,
          tGameList,
        );
        verify(() => mockRepoContract.getUpcomingGames(page: 1)).called(1);
        verifyNoMoreInteractions(mockRepoContract);
      },
    );

    test(
      'should return ErrorBaseResponse when repository returns an error',
      () async {
        const tError = NetworkError();
        when(
          () => mockRepoContract.getUpcomingGames(page: any(named: 'page')),
        ).thenAnswer((_) async => const ErrorBaseResponse(error: tError));

        final result = await useCase(page: 1);

        expect(result, isA<ErrorBaseResponse<List<GameEntity>>>());
        expect((result as ErrorBaseResponse<List<GameEntity>>).error, tError);
        verify(() => mockRepoContract.getUpcomingGames(page: 1)).called(1);
        verifyNoMoreInteractions(mockRepoContract);
      },
    );
  });
}
