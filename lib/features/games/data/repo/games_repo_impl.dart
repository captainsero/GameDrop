import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/game_entity.dart';
import '../../domain/repo/games_repo_contract.dart';
import '../data_sources/games_local_data_source_contract.dart';
import '../data_sources/games_remote_data_source_contract.dart';
import '../models/game_model.dart';

@Injectable(as: GamesRepoContract)
class GamesRepoImpl implements GamesRepoContract {
  GamesRepoImpl({
    required GamesRemoteDataSourceContract remoteDataSource,
    required GamesLocalDataSourceContract localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final GamesRemoteDataSourceContract _remoteDataSource;
  final GamesLocalDataSourceContract _localDataSource;

  @override
  Future<BaseResponse<List<GameEntity>>> getUpcomingGames({
    required int page,
  }) async {
    final localResponse = await _localDataSource.getCachedUpcomingGames();

    switch (localResponse) {
      case SuccessBaseResponse<List<GameModel>>():
        return SuccessBaseResponse<List<GameEntity>>(
          data: localResponse.data.map((e) => e.toEntity()).toList(),
        );

      case ErrorBaseResponse<List<GameModel>>():
        final remoteResponse =
            await _remoteDataSource.getUpcomingGames(page: page);

        switch (remoteResponse) {
          case SuccessBaseResponse<List<GameModel>>():
            await _localDataSource.cacheUpcomingGames(remoteResponse.data);
            return SuccessBaseResponse<List<GameEntity>>(
              data: remoteResponse.data.map((e) => e.toEntity()).toList(),
            );

          case ErrorBaseResponse<List<GameModel>>():
            return ErrorBaseResponse<List<GameEntity>>(
              error: remoteResponse.error,
            );
        }
    }
  }
}
