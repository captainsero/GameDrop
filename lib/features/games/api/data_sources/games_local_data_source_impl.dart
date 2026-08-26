import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/constants/app_keys/hive_keys.dart';
import '../../../../core/errors/app_error.dart';
import '../../data/data_sources/games_local_data_source_contract.dart';
import '../../data/models/game_model.dart';

@Injectable(as: GamesLocalDataSourceContract)
class GamesLocalDataSourceImpl implements GamesLocalDataSourceContract {
  GamesLocalDataSourceImpl(@Named(HiveKeys.gamesBox) this._box);

  final Box<dynamic> _box;

  @override
  Future<BaseResponse<List<GameModel>>> getCachedUpcomingGames() async {
    try {
      final raw = _box.get(HiveKeys.upcomingGames);
      if (raw == null) {
        return const ErrorBaseResponse<List<GameModel>>(
          error: LocalStorageError(),
        );
      }
      return SuccessBaseResponse<List<GameModel>>(
        data: (raw as List<dynamic>).cast<GameModel>(),
      );
    } catch (e) {
      return ErrorBaseResponse<List<GameModel>>(error: AppError.from(e));
    }
  }

  @override
  Future<void> cacheUpcomingGames(List<GameModel> games) async {
    await _box.put(HiveKeys.upcomingGames, games);
  }
}
