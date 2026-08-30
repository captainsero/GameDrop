import '../../../../config/base_response/base_response.dart';
import '../entities/game_detail_entity.dart';

// Single-method contract is intentional — easier to mock in tests.
// ignore: one_member_abstracts
abstract class GameDetailsRepoContract {
  Future<BaseResponse<GameDetailEntity>> getGameDetail({required int id});
}
