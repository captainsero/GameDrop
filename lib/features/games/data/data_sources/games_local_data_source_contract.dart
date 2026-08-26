import '../../../../config/base_response/base_response.dart';
import '../models/game_model.dart';

abstract class GamesLocalDataSourceContract {
  Future<BaseResponse<List<GameModel>>> getCachedUpcomingGames();

  Future<void> cacheUpcomingGames(List<GameModel> games);
}
