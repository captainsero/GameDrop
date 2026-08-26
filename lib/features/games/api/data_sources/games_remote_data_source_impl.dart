import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/errors/app_error.dart';
import '../../data/data_sources/games_remote_data_source_contract.dart';
import '../../data/models/game_model.dart';
import '../api_client/games_api_client.dart';

@Injectable(as: GamesRemoteDataSourceContract)
class GamesRemoteDataSourceImpl implements GamesRemoteDataSourceContract {
  GamesRemoteDataSourceImpl({required GamesApiClient apiClient})
    : _apiClient = apiClient;

  final GamesApiClient _apiClient;
  @override
  Future<BaseResponse<List<GameModel>>> getUpcomingGames({
    required int page,
  }) async {
    try {
      final response = await _apiClient.getUpcomingGames(page);
      return SuccessBaseResponse<List<GameModel>>(data: response.results);
    } catch (e) {
      return ErrorBaseResponse<List<GameModel>>(error: AppError.from(e));
    }
  }
}
