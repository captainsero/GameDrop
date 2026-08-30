import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/errors/app_error.dart';
import '../../data/data_sources/game_details_remote_data_source_contract.dart';
import '../../data/models/game_detail_model.dart';
import '../api_client/game_details_api_client.dart';

@Injectable(as: GameDetailsRemoteDataSourceContract)
class GameDetailsRemoteDataSourceImpl
    implements GameDetailsRemoteDataSourceContract {
  GameDetailsRemoteDataSourceImpl({
    required GameDetailsApiClient apiClient,
  }) : _apiClient = apiClient;

  final GameDetailsApiClient _apiClient;

  @override
  Future<BaseResponse<GameDetailModel>> getGameDetail({
    required int id,
  }) async {
    try {
      final response = await _apiClient.getGameDetail(id);
      return SuccessBaseResponse<GameDetailModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<GameDetailModel>(error: AppError.from(e));
    }
  }
}
