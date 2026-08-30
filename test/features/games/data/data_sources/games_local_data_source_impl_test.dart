import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/constants/app_keys/hive_keys.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/games/api/data_sources/games_local_data_source_impl.dart';
import 'package:gamedrop/features/games/data/models/game_model.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  late MockBox mockBox;
  late GamesLocalDataSourceImpl localDataSource;

  setUp(() {
    mockBox = MockBox();
    localDataSource = GamesLocalDataSourceImpl(mockBox);
  });

  const tGamesList = [
    GameModel(
      id: 1,
      name: 'Grand Theft Auto VI',
      coverUrl: null,
      releaseDate: '2026-11-20',
      tba: false,
      platforms: ['PS5', 'Xbox Series X'],
    ),
    GameModel(
      id: 2,
      name: 'Half-Life 3',
      coverUrl: null,
      releaseDate: null,
      tba: true,
      platforms: ['PC'],
    ),
  ];

  group('GamesLocalDataSourceImpl', () {
    group('getCachedUpcomingGames', () {
      test(
        'should return SuccessBaseResponse when games exist in Hive box',
        () async {
          when(
            () => mockBox.get(HiveKeys.upcomingGames),
          ).thenReturn(tGamesList);

          final result = await localDataSource.getCachedUpcomingGames();

          expect(result, isA<SuccessBaseResponse<List<GameModel>>>());
          expect(
            (result as SuccessBaseResponse<List<GameModel>>).data,
            tGamesList,
          );
          verify(() => mockBox.get(HiveKeys.upcomingGames)).called(1);
        },
      );

      test(
        'should return ErrorBaseResponse with LocalStorageError when box returns null',
        () async {
          when(() => mockBox.get(HiveKeys.upcomingGames)).thenReturn(null);

          final result = await localDataSource.getCachedUpcomingGames();

          expect(result, isA<ErrorBaseResponse<List<GameModel>>>());
          expect(
            (result as ErrorBaseResponse<List<GameModel>>).error,
            isA<LocalStorageError>(),
          );
        },
      );

      test(
        'should return ErrorBaseResponse when an exception is thrown',
        () async {
          when(
            () => mockBox.get(HiveKeys.upcomingGames),
          ).thenThrow(Exception('Hive read error'));

          final result = await localDataSource.getCachedUpcomingGames();

          expect(result, isA<ErrorBaseResponse<List<GameModel>>>());
        },
      );
    });

    group('cacheUpcomingGames', () {
      test('should put games into box with HiveKeys.upcomingGames', () async {
        when(
          () => mockBox.put(HiveKeys.upcomingGames, tGamesList),
        ).thenAnswer((_) async {});

        await localDataSource.cacheUpcomingGames(tGamesList);

        verify(() => mockBox.put(HiveKeys.upcomingGames, tGamesList)).called(1);
      });
    });

    group('searchCachedGames', () {
      test(
        'should filter games in memory matching query case-insensitively',
        () async {
          when(
            () => mockBox.get(HiveKeys.upcomingGames),
          ).thenReturn(tGamesList);

          final result = await localDataSource.searchCachedGames(
            query: 'theft',
          );

          expect(result, isA<SuccessBaseResponse<List<GameModel>>>());
          final data = (result as SuccessBaseResponse<List<GameModel>>).data;
          expect(data.length, 1);
          expect(data.first.name, 'Grand Theft Auto VI');
        },
      );

      test('should return empty list when no game matches query', () async {
        when(() => mockBox.get(HiveKeys.upcomingGames)).thenReturn(tGamesList);

        final result = await localDataSource.searchCachedGames(
          query: 'NonExistentGame',
        );

        expect(result, isA<SuccessBaseResponse<List<GameModel>>>());
        final data = (result as SuccessBaseResponse<List<GameModel>>).data;
        expect(data, isEmpty);
      });

      test(
        'should return ErrorBaseResponse with LocalStorageError when cache is empty/null',
        () async {
          when(() => mockBox.get(HiveKeys.upcomingGames)).thenReturn(null);

          final result = await localDataSource.searchCachedGames(query: 'GTA');

          expect(result, isA<ErrorBaseResponse<List<GameModel>>>());
          expect(
            (result as ErrorBaseResponse<List<GameModel>>).error,
            isA<LocalStorageError>(),
          );
        },
      );
    });
  });
}
