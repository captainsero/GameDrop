import 'package:flutter/material.dart';

import '../constants/color_manager.dart';
import '../constants/font_manager.dart';
import '../constants/style_manager.dart';
import '../constants/values_manager.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.primary,
  primaryColorDark: AppColors.primaryDark1,
  primaryColorLight: AppColors.primaryLight1,

  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.primaryLight8,
    onPrimaryContainer: AppColors.primaryDark9,
    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.secondaryLightest,
    onSecondaryContainer: AppColors.secondaryDarkest,
    tertiary: AppColors.background,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.backgroundLight3,
    onTertiaryContainer: AppColors.backgroundDark4,
    error: AppColors.error,
    onError: AppColors.white,
    errorContainer: Color(0xFFFFEBEE),
    onErrorContainer: AppColors.error,
    surface: AppColors.white,
    onSurface: AppColors.neutral900,
    surfaceDim: AppColors.neutral100,
    surfaceBright: AppColors.white,
    surfaceContainerLowest: AppColors.white,
    surfaceContainerLow: AppColors.neutral50,
    surfaceContainer: AppColors.neutral100,
    surfaceContainerHigh: AppColors.neutral200,
    surfaceContainerHighest: AppColors.neutral300,
    onSurfaceVariant: AppColors.neutral600,
    outline: AppColors.neutral400,
    outlineVariant: AppColors.neutral200,
    shadow: AppColors.black,
    scrim: AppColors.black,
    inverseSurface: AppColors.neutral900,
    onInverseSurface: AppColors.white,
    inversePrimary: AppColors.primaryLight3,
  ),

  textTheme: TextTheme(
    displayLarge: getBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s40,
    ),
    displayMedium: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s35,
    ),
    displaySmall: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s30,
    ),

    headlineLarge: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s24,
    ),
    headlineMedium: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s22,
    ),
    headlineSmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s18,
    ),

    titleLarge: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s22,
    ),
    titleMedium: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s16,
    ),
    titleSmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s14,
    ),

    bodyLarge: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral700,
      fontSize: FontSize.s16,
    ),
    bodyMedium: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral700,
      fontSize: FontSize.s14,
    ),
    bodySmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral700,
    ),

    labelLarge: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral500,
      fontSize: FontSize.s14,
    ),
    labelMedium: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral500,
    ),
    labelSmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral500,
      fontSize: FontSize.s10,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.neutral900,
    titleTextStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s25,
    ),
    leadingWidth: AppSize.s25,
    actionsPadding: const EdgeInsets.only(right: AppPadding.p20),
    titleSpacing: AppSize.s16,
    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.neutral300,
      disabledForegroundColor: AppColors.neutral500,
      padding: const EdgeInsets.all(AppPadding.p16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusSize.r16),
      ),
      textStyle: getMediumStyle(
        fontFamily: FontConstants.outfit,
        color: AppColors.white,
        fontSize: FontSize.s18,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    hintStyle: const TextStyle(
      color: AppColors.neutral500,
      fontSize: FontSize.s16,
      fontFamily: FontConstants.outfit,
    ),
    labelStyle: const TextStyle(
      color: AppColors.neutral700,
      fontSize: FontSize.s18,
      fontWeight: FontWeight.w500,
      fontFamily: FontConstants.outfit,
    ),
    floatingLabelStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.primary,
      fontSize: FontSize.s18,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.error,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(color: AppColors.neutral300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(color: AppColors.neutral300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(color: AppColors.primary, width: AppSize.s2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(color: AppColors.error, width: AppSize.s2),
    ),
    contentPadding: const EdgeInsets.all(AppPadding.p16),
  ),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.secondary,
    linearTrackColor: AppColors.neutral200,
    borderRadius: BorderRadius.circular(RadiusSize.r8),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.white,
    elevation: 0,
    surfaceTintColor: AppColors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s18,
    ),
    contentTextStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral900,
      fontSize: FontSize.s16,
    ),
  ),

  cardTheme: CardThemeData(
    color: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.neutral200),
    ),
  ),

  dividerTheme: const DividerThemeData(color: AppColors.neutral200),

  iconTheme: const IconThemeData(color: AppColors.neutral900),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.white,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.primaryLight8,
    selectedLabelStyle: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.primary,
      fontSize: FontSize.s16,
    ),
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.neutral400,
    selectedIconTheme: const IconThemeData(color: AppColors.primary),
    unselectedIconTheme: const IconThemeData(color: AppColors.neutral400),
    showUnselectedLabels: false,
    unselectedLabelStyle: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral400,
      fontSize: FontSize.s14,
    ),
  ),

  searchBarTheme: SearchBarThemeData(
    elevation: const WidgetStatePropertyAll(AppSize.s0),
    backgroundColor: const WidgetStatePropertyAll(AppColors.transparent),
    side: const WidgetStatePropertyAll(BorderSide(color: AppColors.lightGrey)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppPadding.p16),
      ),
    ),
    textStyle: WidgetStatePropertyAll(
      getRegularStyle(
        fontFamily: FontConstants.outfit,
        color: AppColors.grey,
      ),
    ),
  ),
);
