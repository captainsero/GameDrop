import '../../../../config/base_response/base_response.dart';
import '../entities/game_entity.dart';

abstract class GamesRepoContract {
  Future<BaseResponse<List<GameEntity>>> getUpcomingGames({required int page});

  Future<BaseResponse<List<GameEntity>>> searchGames({
    required String query,
  });
}
