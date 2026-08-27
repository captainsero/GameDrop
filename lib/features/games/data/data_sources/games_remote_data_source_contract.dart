import '../../../../config/base_response/base_response.dart';
import '../models/game_model.dart';

// Single-method contract is intentional — easier to mock in tests.
// ignore: one_member_abstracts
abstract class GamesRemoteDataSourceContract {
  Future<BaseResponse<List<GameModel>>> getUpcomingGames({required int page});
}
