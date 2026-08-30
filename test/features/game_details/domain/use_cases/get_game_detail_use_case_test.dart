import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_response/base_response.dart';
import 'package:gamedrop/core/errors/app_error.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';
import 'package:gamedrop/features/game_details/domain/repo/game_details_repo_contract.dart';
import 'package:gamedrop/features/game_details/domain/use_cases/get_game_detail_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGameDetailsRepoContract extends Mock
    implements GameDetailsRepoContract {}

void main() {
  late MockGameDetailsRepoContract mockRepoContract;
  late GetGameDetailUseCase useCase;

  setUp(() {
    mockRepoContract = MockGameDetailsRepoContract();
    useCase = GetGameDetailUseCase(repoContract: mockRepoContract);
  });

  const tEntity = GameDetailEntity(
    id: 10,
    name: 'Death Stranding 2',
    coverUrl: null,
    releaseDate: null,
    tba: true,
    platforms: ['PS5'],
    summary: 'On a journey to save humanity once again.',
  );

  group('GetGameDetailUseCase', () {
    test(
      'forwards call to GameDetailsRepoContract and returns SuccessBaseResponse',
      () async {
        when(
          () => mockRepoContract.getGameDetail(id: 10),
        ).thenAnswer((_) async => const SuccessBaseResponse(data: tEntity));

        final result = await useCase(id: 10);

        expect(result, isA<SuccessBaseResponse<GameDetailEntity>>());
        expect((result as SuccessBaseResponse<GameDetailEntity>).data, tEntity);
        verify(() => mockRepoContract.getGameDetail(id: 10)).called(1);
        verifyNoMoreInteractions(mockRepoContract);
      },
    );

    test('returns ErrorBaseResponse when repository fails', () async {
      const tError = NetworkError();
      when(
        () => mockRepoContract.getGameDetail(id: 10),
      ).thenAnswer((_) async => const ErrorBaseResponse(error: tError));

      final result = await useCase(id: 10);

      expect(result, isA<ErrorBaseResponse<GameDetailEntity>>());
      expect((result as ErrorBaseResponse<GameDetailEntity>).error, tError);
      verify(() => mockRepoContract.getGameDetail(id: 10)).called(1);
      verifyNoMoreInteractions(mockRepoContract);
    });
  });
}
