import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../core/constants/app_keys/hive_keys.dart';
import '../../features/game_details/data/models/game_detail_model_adapter.dart';
import '../../features/games/data/models/game_model_adapter.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive
      ..registerAdapter(GameModelAdapter())
      ..registerAdapter(GameDetailModelAdapter());

    // Open boxes — one box per feature/domain
    await Hive.openBox<dynamic>(HiveKeys.gamesBox);
  }
}
