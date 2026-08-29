import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/games/api/api_client/games_api_client.dart';
import 'package:gamedrop/features/games/api/data_sources/games_remote_data_source_impl.dart';
import 'package:gamedrop/features/games/data/models/game_model.dart';
import 'package:gamedrop/features/games/data/models/games_response_model.dart';
import 'package:mocktail/mocktail.dart';

class MockGamesApiClient extends Mock implements GamesApiClient {}

void main() {
  late MockGamesApiClient mockApiClient;
  late GamesRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockApiClient = MockGamesApiClient();
    remoteDataSource = GamesRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  const tGameList = [
    GameModel(
      id: 1,
      name: 'Mario Odyssey 2',
      coverUrl: 'https://example.com/cover.png',
      releaseDate: '2027-01-01',
      tba: false,
      platforms: ['Switch 2'],
    ),
  ];

  const tResponse = GamesResponseModel(
    count: 1,
    next: false,
    results: tGameList,
  );

  group('GamesRemoteDataSourceImpl.getUpcomingGames', () {
    test(
      'should return SuccessBaseResponse with GameModel list when API call succeeds',
      () async {
        when(
          () => mockApiClient.getUpcomingGames(any()),
        ).thenAnswer((_) async => tResponse);

        final result = await remoteDataSource.getUpcomingGames(page: 1);

        expect(result, isA<SuccessBaseResponse<List<GameModel>>>());
        expect(
          (result as SuccessBaseResponse<List<GameModel>>).data,
          tGameList,
        );
        verify(() => mockApiClient.getUpcomingGames(1)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse with ConnectionTimeoutError when Dio connection timeout occurs',
      () async {
        when(() => mockApiClient.getUpcomingGames(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        final result = await remoteDataSource.getUpcomingGames(page: 1);

        expect(result, isA<ErrorBaseResponse<List<GameModel>>>());
        expect(
          (result as ErrorBaseResponse<List<GameModel>>).error,
          isA<ConnectionTimeoutError>(),
        );
        verify(() => mockApiClient.getUpcomingGames(1)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse with ServerError when Dio bad response is 500',
      () async {
        when(() => mockApiClient.getUpcomingGames(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        final result = await remoteDataSource.getUpcomingGames(page: 1);

        expect(result, isA<ErrorBaseResponse<List<GameModel>>>());
        final error = (result as ErrorBaseResponse<List<GameModel>>).error;
        expect(error, isA<ServerError>());
        expect((error! as ServerError).statusCode, 500);
        verify(() => mockApiClient.getUpcomingGames(1)).called(1);
      },
    );
  });
}
