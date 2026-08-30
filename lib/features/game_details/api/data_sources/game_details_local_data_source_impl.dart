import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/constants/app_keys/hive_keys.dart';
import '../../../../core/errors/app_error.dart';
import '../../data/data_sources/game_details_local_data_source_contract.dart';
import '../../data/models/game_detail_model.dart';

@Injectable(as: GameDetailsLocalDataSourceContract)
class GameDetailsLocalDataSourceImpl
    implements GameDetailsLocalDataSourceContract {
  GameDetailsLocalDataSourceImpl(@Named(HiveKeys.gamesBox) this._box);

  final Box<dynamic> _box;

  static String _key(int id) => 'game_detail_$id';

  @override
  Future<BaseResponse<GameDetailModel>> getCachedGameDetail({
    required int id,
  }) async {
    try {
      final raw = _box.get(_key(id));
      if (raw == null) {
        return ErrorBaseResponse<GameDetailModel>(
          error: LocalStorageError(key: _key(id)),
        );
      }
      return SuccessBaseResponse<GameDetailModel>(data: raw as GameDetailModel);
    } catch (e) {
      return ErrorBaseResponse<GameDetailModel>(error: AppError.from(e));
    }
  }

  @override
  Future<void> cacheGameDetail(GameDetailModel gameDetail) async {
    await _box.put(_key(gameDetail.id), gameDetail);
  }
}
