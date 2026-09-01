import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/game_detail_entity.dart';
import '../../domain/repo/game_details_repo_contract.dart';
import '../data_sources/game_details_local_data_source_contract.dart';
import '../data_sources/game_details_remote_data_source_contract.dart';
import '../models/game_detail_model.dart';

@Injectable(as: GameDetailsRepoContract)
class GameDetailsRepoImpl implements GameDetailsRepoContract {
  GameDetailsRepoImpl({
    required GameDetailsRemoteDataSourceContract remoteDataSource,
    required GameDetailsLocalDataSourceContract localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final GameDetailsRemoteDataSourceContract _remoteDataSource;
  final GameDetailsLocalDataSourceContract _localDataSource;

  @override
  Future<BaseResponse<GameDetailEntity>> getGameDetail({
    required int id,
  }) async {
    final remoteResponse = await _remoteDataSource.getGameDetail(id: id);

    switch (remoteResponse) {
      case SuccessBaseResponse<GameDetailModel>():
        await _localDataSource.cacheGameDetail(remoteResponse.data);
        return SuccessBaseResponse<GameDetailEntity>(
          data: remoteResponse.data.toEntity(),
        );

      case ErrorBaseResponse<GameDetailModel>():
        final localResponse = await _localDataSource.getCachedGameDetail(id: id);

        switch (localResponse) {
          case SuccessBaseResponse<GameDetailModel>():
            return SuccessBaseResponse<GameDetailEntity>(
              data: localResponse.data.toEntity(),
            );

          case ErrorBaseResponse<GameDetailModel>():
            return ErrorBaseResponse<GameDetailEntity>(
              error: remoteResponse.error,
              errorMessage: remoteResponse.errorMessage,
            );
        }
    }
  }
}
