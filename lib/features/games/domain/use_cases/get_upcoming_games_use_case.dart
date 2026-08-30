import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/game_entity.dart';
import '../repo/games_repo_contract.dart';

@injectable
class GetUpcomingGamesUseCase {
  GetUpcomingGamesUseCase({required GamesRepoContract repoContract})
    : _repoContract = repoContract;

  final GamesRepoContract _repoContract;

  Future<BaseResponse<List<GameEntity>>> call({required int page}) =>
      _repoContract.getUpcomingGames(page: page);
}
