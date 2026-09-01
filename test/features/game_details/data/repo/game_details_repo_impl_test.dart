import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/game_details/data/data_sources/game_details_local_data_source_contract.dart';
import 'package:gamedrop/features/game_details/data/data_sources/game_details_remote_data_source_contract.dart';
import 'package:gamedrop/features/game_details/data/models/game_detail_model.dart';
import 'package:gamedrop/features/game_details/data/repo/game_details_repo_impl.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock
    implements GameDetailsRemoteDataSourceContract {}

class MockLocalDataSource extends Mock
    implements GameDetailsLocalDataSourceContract {}

class FakeGameDetailModel extends Fake implements GameDetailModel {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late GameDetailsRepoImpl repo;

  setUpAll(() {
    registerFallbackValue(FakeGameDetailModel());
  });

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repo = GameDetailsRepoImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tModel = GameDetailModel(
    id: 15,
    name: 'Kingdom Come: Deliverance II',
    coverUrl: null,
    releaseDate: '2026-10-15',
    tba: false,
    platforms: ['PC', 'PS5'],
    summary: 'A thrilling story-driven action RPG.',
  );

  group('GameDetailsRepoImpl.getGameDetail', () {
    test(
      'fetches from remote, saves to cache, and returns entity on remote success',
      () async {
        when(() => mockRemoteDataSource.getGameDetail(id: 15)).thenAnswer(
          (_) async => const SuccessBaseResponse(data: tModel),
        );
        when(
          () => mockLocalDataSource.cacheGameDetail(tModel),
        ).thenAnswer((_) async {});

        final result = await repo.getGameDetail(id: 15);

        expect(result, isA<SuccessBaseResponse<GameDetailEntity>>());
        final entity = (result as SuccessBaseResponse<GameDetailEntity>).data;
        expect(entity.id, 15);
        expect(entity.name, 'Kingdom Come: Deliverance II');

        verify(() => mockRemoteDataSource.getGameDetail(id: 15)).called(1);
        verify(() => mockLocalDataSource.cacheGameDetail(tModel)).called(1);
        verifyNever(
          () => mockLocalDataSource.getCachedGameDetail(id: any(named: 'id')),
        );
      },
    );

    test(
      'returns cached game detail when remote fails and local has cached data',
      () async {
        const tError = NetworkError();
        when(() => mockRemoteDataSource.getGameDetail(id: 15)).thenAnswer(
          (_) async => const ErrorBaseResponse(error: tError),
        );
        when(() => mockLocalDataSource.getCachedGameDetail(id: 15)).thenAnswer(
          (_) async => const SuccessBaseResponse(data: tModel),
        );

        final result = await repo.getGameDetail(id: 15);

        expect(result, isA<SuccessBaseResponse<GameDetailEntity>>());
        final entity = (result as SuccessBaseResponse<GameDetailEntity>).data;
        expect(entity.id, 15);
        expect(entity.name, 'Kingdom Come: Deliverance II');

        verify(() => mockRemoteDataSource.getGameDetail(id: 15)).called(1);
        verify(() => mockLocalDataSource.getCachedGameDetail(id: 15)).called(1);
        verifyNever(() => mockLocalDataSource.cacheGameDetail(any()));
      },
    );

    test(
      'returns remote error when remote fails and local also fails',
      () async {
        const tError = NetworkError();
        when(() => mockRemoteDataSource.getGameDetail(id: 15)).thenAnswer(
          (_) async => const ErrorBaseResponse(error: tError),
        );
        when(() => mockLocalDataSource.getCachedGameDetail(id: 15)).thenAnswer(
          (_) async => const ErrorBaseResponse(error: LocalStorageError()),
        );

        final result = await repo.getGameDetail(id: 15);

        expect(result, isA<ErrorBaseResponse<GameDetailEntity>>());
        expect((result as ErrorBaseResponse<GameDetailEntity>).error, tError);

        verify(() => mockRemoteDataSource.getGameDetail(id: 15)).called(1);
        verify(() => mockLocalDataSource.getCachedGameDetail(id: 15)).called(1);
        verifyNever(() => mockLocalDataSource.cacheGameDetail(any()));
      },
    );
  });
}
