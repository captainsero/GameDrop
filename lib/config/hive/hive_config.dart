import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters here, e.g:
    // Hive.registerAdapter(UserAdapter());

    // Open boxes here, e.g:
    // await Hive.openBox<User>(HiveKeys.userBox);
  }
}
