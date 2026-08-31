import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/app_keys/hive_keys.dart';

@module
abstract class HiveModule {
  /// Exposes the already-opened games box so injectable can inject it
  /// into GamesLocalDataSourceImpl using @Named(HiveKeys.gamesBox).
  ///
  /// The box must be opened in HiveConfig.init() BEFORE configureDependencies()
  /// is called (see main.dart).
  @singleton
  @Named(HiveKeys.gamesBox)
  Box<dynamic> gamesBox() => Hive.box<dynamic>(HiveKeys.gamesBox);
}
