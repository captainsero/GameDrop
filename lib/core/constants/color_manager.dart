import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Core Colors
  static const Color primary = Color(0xFF118AB2); // Vibrant Cyan-Blue
  static const Color secondary = Color(0xFF7CD5C7); // Neon Teal
  static const Color background = Color(0xFF464B71); // Deep Slate Blue
  static const Color textPrimary = Color(0xFFF2F2ED); // Crisp Off-White

  // Primary Shades - Cyan-Blue (#118AB2)
  static const Color primaryLight1 = Color(0xFF2897BC);
  static const Color primaryLight2 = Color(0xFF40A5C6);
  static const Color primaryLight3 = Color(0xFF58B2D0);
  static const Color primaryLight4 = Color(0xFF70C0DA);
  static const Color primaryLight5 = Color(0xFF88CDE4);
  static const Color primaryLight6 = Color(0xFFA0DBEE);
  static const Color primaryLight7 = Color(0xFFB8E8F8);
  static const Color primaryLight8 = Color(0xFFD0F6FF);
  static const Color primaryLight9 = Color(0xFFE8FBFF);

  static const Color primaryDark1 = Color(0xFF0F7C9F);
  static const Color primaryDark2 = Color(0xFF0D6E8C);
  static const Color primaryDark3 = Color(0xFF0B607A);
  static const Color primaryDark4 = Color(0xFF095267);
  static const Color primaryDark5 = Color(0xFF074354);
  static const Color primaryDark6 = Color(0xFF053542);
  static const Color primaryDark7 = Color(0xFF042730);
  static const Color primaryDark8 = Color(0xFF02191E);
  static const Color primaryDark9 = Color(0xFF010B0D);

  // Secondary Shades - Neon Teal (#7CD5C7)
  static const Color secondaryLight = Color(0xFF9DE0D5);
  static const Color secondaryLighter = Color(0xFFBEECE4);
  static const Color secondaryLightest = Color(0xFFE0F7F3);
  static const Color secondaryDark = Color(0xFF5EBFB0);
  static const Color secondaryDarker = Color(0xFF42A696);
  static const Color secondaryDarkest = Color(0xFF2A8B7C);

  // Background & Slate Surface Shades (#464B71)
  static const Color backgroundLight1 = Color(0xFF555B86);
  static const Color backgroundLight2 = Color(0xFF656C9C);
  static const Color backgroundLight3 = Color(0xFF767EB2);
  static const Color backgroundDark1 = Color(0xFF383C5C);
  static const Color backgroundDark2 = Color(0xFF2C2F48);
  static const Color backgroundDark3 = Color(0xFF202235);
  static const Color backgroundDark4 = Color(0xFF151623);
  static const Color backgroundDark5 = Color(0xFF0B0C12);

  // Neutrals - Tuned to Slate & Crisp Off-White (#F2F2ED)
  static const Color white = Color(0xFFF2F2ED); // Base Off-White
  static const Color neutral50 = Color(0xFFE4E4DE);
  static const Color neutral100 = Color(0xFFD6D7CF);
  static const Color neutral200 = Color(0xFFB9BAB0);
  static const Color neutral300 = Color(0xFF9C9E91);
  static const Color neutral400 = Color(0xFF7F8175);
  static const Color neutral500 = Color(0xFF64665C);
  static const Color neutral600 = Color(0xFF4C4D4A);
  static const Color neutral700 = Color(0xFF36394A);
  static const Color neutral800 = Color(0xFF222430);
  static const Color neutral900 = Color(0xFF13141C);
  static const Color black = Color(0xFF000000);

  // Semantic Colors
  static const Color success = Color(0xFF06D6A0);
  static const Color error = Color(0xFFEF476F);
  static const Color warning = Color(0xFFFFD166);
  static const Color info = Color(0xFF118AB2);

  // App-Specific Aliases
  static const Color scaffoldBackground = backgroundDark2;
  static const Color cardSurface = background;
  static const Color cardSurfaceElevated = backgroundLight1;
  static const Color cardBorder = Color(0x337CD5C7); // 20% opacity teal glow
  static const Color divider = Color(0x1AF2F2ED); // 10% off-white
  static const Color hintColor = neutral300;
  static const Color placeholder = neutral400;
  static const Color grey = neutral500;
  static const Color lightGrey = neutral200;
  static const Color unSelectedIconColor = neutral300;
  static const Color glowCyan = Color(0x66118AB2);
  static const Color glowTeal = Color(0x667CD5C7);
  static const Color transparent = Colors.transparent;
}
