import 'package:flutter/material.dart';

import 'dark_theme.dart' as dark;
import 'light_theme.dart' as light;

abstract class AppTheme {
  static ThemeData get lightTheme => light.lightTheme;
  static ThemeData get darkTheme => dark.darkTheme;
}
