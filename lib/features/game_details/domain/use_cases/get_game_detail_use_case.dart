import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/game_detail_entity.dart';
import '../repo/game_details_repo_contract.dart';

@injectable
class GetGameDetailUseCase {
  GetGameDetailUseCase({required GameDetailsRepoContract repoContract})
    : _repoContract = repoContract;

  final GameDetailsRepoContract _repoContract;

  Future<BaseResponse<GameDetailEntity>> call({required int id}) =>
      _repoContract.getGameDetail(id: id);
}
