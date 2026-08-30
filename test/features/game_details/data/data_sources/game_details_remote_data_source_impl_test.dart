import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/game_details/api/api_client/game_details_api_client.dart';
import 'package:gamedrop/features/game_details/api/data_sources/game_details_remote_data_source_impl.dart';
import 'package:gamedrop/features/game_details/data/models/game_detail_model.dart';
import 'package:mocktail/mocktail.dart';

class MockGameDetailsApiClient extends Mock implements GameDetailsApiClient {}

void main() {
  late MockGameDetailsApiClient mockApiClient;
  late GameDetailsRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockApiClient = MockGameDetailsApiClient();
    remoteDataSource = GameDetailsRemoteDataSourceImpl(
      apiClient: mockApiClient,
    );
  });

  const tModel = GameDetailModel(
    id: 5,
    name: 'Wolverine',
    coverUrl: null,
    releaseDate: '2026-10-15',
    tba: false,
    platforms: ['PS5'],
    summary: 'An intense action adventure starring Wolverine.',
  );

  group('GameDetailsRemoteDataSourceImpl', () {
    test('returns SuccessBaseResponse when API succeeds', () async {
      when(
        () => mockApiClient.getGameDetail(5),
      ).thenAnswer((_) async => tModel);

      final result = await remoteDataSource.getGameDetail(id: 5);

      expect(result, isA<SuccessBaseResponse<GameDetailModel>>());
      expect((result as SuccessBaseResponse<GameDetailModel>).data, tModel);
      verify(() => mockApiClient.getGameDetail(5)).called(1);
    });

    test(
      'returns ErrorBaseResponse with ConnectionTimeoutError when Dio connection times out',
      () async {
        when(() => mockApiClient.getGameDetail(5)).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        final result = await remoteDataSource.getGameDetail(id: 5);

        expect(result, isA<ErrorBaseResponse<GameDetailModel>>());
        expect(
          (result as ErrorBaseResponse<GameDetailModel>).error,
          isA<ConnectionTimeoutError>(),
        );
        verify(() => mockApiClient.getGameDetail(5)).called(1);
      },
    );
  });
}
