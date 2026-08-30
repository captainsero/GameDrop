import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/game_details/api/data_sources/game_details_local_data_source_impl.dart';
import 'package:gamedrop/features/game_details/data/models/game_detail_model.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  late MockBox mockBox;
  late GameDetailsLocalDataSourceImpl localDataSource;

  setUp(() {
    mockBox = MockBox();
    localDataSource = GameDetailsLocalDataSourceImpl(mockBox);
  });

  const tModel = GameDetailModel(
    id: 12,
    name: 'Dragon Age: The Veilguard',
    coverUrl: null,
    releaseDate: '2026-09-01',
    tba: false,
    platforms: ['PC', 'PS5'],
    summary: 'Enter the world of Thedas.',
  );

  group('GameDetailsLocalDataSourceImpl', () {
    group('getCachedGameDetail', () {
      test(
        'returns SuccessBaseResponse when game detail exists in box',
        () async {
          when(() => mockBox.get('game_detail_12')).thenReturn(tModel);

          final result = await localDataSource.getCachedGameDetail(id: 12);

          expect(result, isA<SuccessBaseResponse<GameDetailModel>>());
          expect((result as SuccessBaseResponse<GameDetailModel>).data, tModel);
          verify(() => mockBox.get('game_detail_12')).called(1);
        },
      );

      test(
        'returns ErrorBaseResponse with LocalStorageError when box returns null',
        () async {
          when(() => mockBox.get('game_detail_12')).thenReturn(null);

          final result = await localDataSource.getCachedGameDetail(id: 12);

          expect(result, isA<ErrorBaseResponse<GameDetailModel>>());
          expect(
            (result as ErrorBaseResponse<GameDetailModel>).error,
            isA<LocalStorageError>(),
          );
        },
      );

      test('returns ErrorBaseResponse when box throws an exception', () async {
        when(
          () => mockBox.get('game_detail_12'),
        ).thenThrow(Exception('Hive read error'));

        final result = await localDataSource.getCachedGameDetail(id: 12);

        expect(result, isA<ErrorBaseResponse<GameDetailModel>>());
      });
    });

    group('cacheGameDetail', () {
      test('puts model in box with game_detail_id key', () async {
        when(
          () => mockBox.put('game_detail_12', tModel),
        ).thenAnswer((_) async {});

        await localDataSource.cacheGameDetail(tModel);

        verify(() => mockBox.put('game_detail_12', tModel)).called(1);
      });
    });
  });
}
