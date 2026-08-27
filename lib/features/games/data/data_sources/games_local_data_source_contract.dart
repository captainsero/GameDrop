import '../../../../config/base_response/base_response.dart';
import '../models/game_model.dart';

abstract class GamesLocalDataSourceContract {
  Future<BaseResponse<List<GameModel>>> getCachedUpcomingGames();

  Future<void> cacheUpcomingGames(List<GameModel> games);

  /// Searches the locally cached upcoming games by [query] (case-insensitive
  /// name match). Returns an error if the cache is empty.
  Future<BaseResponse<List<GameModel>>> searchCachedGames({
    required String query,
  });
}
