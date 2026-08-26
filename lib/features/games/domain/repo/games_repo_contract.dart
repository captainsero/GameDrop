import '../../../../config/base_response/base_response.dart';
import '../entities/game_entity.dart';

//
// ignore: one_member_abstracts
abstract class GamesRepoContract {
  Future<BaseResponse<List<GameEntity>>> getUpcomingGames({required int page});
}
