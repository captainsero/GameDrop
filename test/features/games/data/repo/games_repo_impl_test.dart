import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/games/data/data_sources/games_local_data_source_contract.dart';
import 'package:gamedrop/features/games/data/data_sources/games_remote_data_source_contract.dart';
import 'package:gamedrop/features/games/data/models/game_model.dart';
import 'package:gamedrop/features/games/data/repo/games_repo_impl.dart';
import 'package:gamedrop/features/games/domain/entities/game_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockGamesRemoteDataSourceContract extends Mock
    implements GamesRemoteDataSourceContract {}

class MockGamesLocalDataSourceContract extends Mock
    implements GamesLocalDataSourceContract {}

void main() {
  late MockGamesRemoteDataSourceContract mockRemoteDataSource;
  late MockGamesLocalDataSourceContract mockLocalDataSource;
  late GamesRepoImpl repo;

  setUp(() {
    mockRemoteDataSource = MockGamesRemoteDataSourceContract();
    mockLocalDataSource = MockGamesLocalDataSourceContract();
    repo = GamesRepoImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tGameModels = [
    GameModel(
      id: 1,
      name: 'Doom: The Dark Ages',
      coverUrl: 'https://example.com/doom.png',
      releaseDate: '2026-10-01',
      tba: false,
      platforms: ['PC', 'PS5', 'Xbox Series X'],
    ),
  ];

  group('GamesRepoImpl', () {
    group('getUpcomingGames', () {
      test(
        'should return cached games when localDataSource has data (cache hit)',
        () async {
          when(() => mockLocalDataSource.getCachedUpcomingGames()).thenAnswer(
            (_) async => const SuccessBaseResponse(data: tGameModels),
          );

          final result = await repo.getUpcomingGames(page: 1);

          expect(result, isA<SuccessBaseResponse<List<GameEntity>>>());
          final entities =
              (result as SuccessBaseResponse<List<GameEntity>>).data;
          expect(entities.length, 1);
          expect(entities.first.name, 'Doom: The Dark Ages');

          verify(() => mockLocalDataSource.getCachedUpcomingGames()).called(1);
          verifyZeroInteractions(mockRemoteDataSource);
        },
      );

      test(
        'should fetch from remote and cache locally when localDataSource fails (cache miss)',
        () async {
          when(() => mockLocalDataSource.getCachedUpcomingGames()).thenAnswer(
            (_) async => const ErrorBaseResponse(error: LocalStorageError()),
          );
          when(() => mockRemoteDataSource.getUpcomingGames(page: 1)).thenAnswer(
            (_) async => const SuccessBaseResponse(data: tGameModels),
          );
          when(
            () => mockLocalDataSource.cacheUpcomingGames(tGameModels),
          ).thenAnswer((_) async {});

          final result = await repo.getUpcomingGames(page: 1);

          expect(result, isA<SuccessBaseResponse<List<GameEntity>>>());
          final entities =
              (result as SuccessBaseResponse<List<GameEntity>>).data;
          expect(entities.length, 1);
          expect(entities.first.name, 'Doom: The Dark Ages');

          verify(() => mockLocalDataSource.getCachedUpcomingGames()).called(1);
          verify(
            () => mockRemoteDataSource.getUpcomingGames(page: 1),
          ).called(1);
          verify(
            () => mockLocalDataSource.cacheUpcomingGames(tGameModels),
          ).called(1);
        },
      );

      test(
        'should return remote error when local fails and remote also fails',
        () async {
          const tError = NetworkError();
          when(() => mockLocalDataSource.getCachedUpcomingGames()).thenAnswer(
            (_) async => const ErrorBaseResponse(error: LocalStorageError()),
          );
          when(() => mockRemoteDataSource.getUpcomingGames(page: 1)).thenAnswer(
            (_) async => const ErrorBaseResponse(error: tError),
          );

          final result = await repo.getUpcomingGames(page: 1);

          expect(result, isA<ErrorBaseResponse<List<GameEntity>>>());
          expect((result as ErrorBaseResponse<List<GameEntity>>).error, tError);

          verify(() => mockLocalDataSource.getCachedUpcomingGames()).called(1);
          verify(
            () => mockRemoteDataSource.getUpcomingGames(page: 1),
          ).called(1);
          verifyNever(() => mockLocalDataSource.cacheUpcomingGames(any()));
        },
      );
    });

    group('searchGames', () {
      test(
        'should return mapped entities when localDataSource.searchCachedGames succeeds',
        () async {
          when(
            () => mockLocalDataSource.searchCachedGames(query: 'Doom'),
          ).thenAnswer(
            (_) async => const SuccessBaseResponse(data: tGameModels),
          );

          final result = await repo.searchGames(query: 'Doom');

          expect(result, isA<SuccessBaseResponse<List<GameEntity>>>());
          final entities =
              (result as SuccessBaseResponse<List<GameEntity>>).data;
          expect(entities.length, 1);
          expect(entities.first.name, 'Doom: The Dark Ages');

          verify(
            () => mockLocalDataSource.searchCachedGames(query: 'Doom'),
          ).called(1);
        },
      );

      test(
        'should return error when localDataSource.searchCachedGames returns error',
        () async {
          const tError = LocalStorageError();
          when(
            () => mockLocalDataSource.searchCachedGames(query: 'Doom'),
          ).thenAnswer((_) async => const ErrorBaseResponse(error: tError));

          final result = await repo.searchGames(query: 'Doom');

          expect(result, isA<ErrorBaseResponse<List<GameEntity>>>());
          expect((result as ErrorBaseResponse<List<GameEntity>>).error, tError);
          verify(
            () => mockLocalDataSource.searchCachedGames(query: 'Doom'),
          ).called(1);
        },
      );
    });
  });
}
