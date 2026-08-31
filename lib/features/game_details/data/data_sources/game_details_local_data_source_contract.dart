import '../../../../config/base_response/base_response.dart';
import '../models/game_detail_model.dart';

abstract class GameDetailsLocalDataSourceContract {
  Future<BaseResponse<GameDetailModel>> getCachedGameDetail({required int id});

  Future<void> cacheGameDetail(GameDetailModel gameDetail);
}
