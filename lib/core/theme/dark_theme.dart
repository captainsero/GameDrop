import 'package:flutter/material.dart';

import '../constants/color_manager.dart';
import '../constants/font_manager.dart';
import '../constants/style_manager.dart';
import '../constants/values_manager.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  primaryColor: AppColors.primary,
  primaryColorDark: AppColors.primaryDark1,
  primaryColorLight: AppColors.primaryLight1,

  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.primaryDark4,
    onPrimaryContainer: AppColors.primaryLight8,
    secondary: AppColors.secondary,
    onSecondary: AppColors.backgroundDark4,
    secondaryContainer: AppColors.secondaryDarkest,
    onSecondaryContainer: AppColors.secondaryLightest,
    tertiary: AppColors.backgroundLight2,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.backgroundDark1,
    onTertiaryContainer: AppColors.backgroundLight3,
    error: AppColors.error,
    onError: AppColors.white,
    errorContainer: AppColors.primaryDark6,
    onErrorContainer: AppColors.white,
    surface: AppColors.cardSurface,
    onSurface: AppColors.white,
    surfaceDim: AppColors.backgroundDark3,
    surfaceBright: AppColors.backgroundLight1,
    surfaceContainerLowest: AppColors.backgroundDark5,
    surfaceContainerLow: AppColors.backgroundDark3,
    surfaceContainer: AppColors.backgroundDark2,
    surfaceContainerHigh: AppColors.backgroundDark1,
    surfaceContainerHighest: AppColors.background,
    onSurfaceVariant: AppColors.neutral200,
    outline: AppColors.cardBorder,
    outlineVariant: AppColors.neutral700,
    shadow: AppColors.black,
    scrim: AppColors.black,
    inverseSurface: AppColors.white,
    onInverseSurface: AppColors.neutral900,
    inversePrimary: AppColors.primaryDark2,
  ),

  textTheme: TextTheme(
    displayLarge: getBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s40,
    ),
    displayMedium: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s35,
    ),
    displaySmall: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s30,
    ),

    headlineLarge: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s24,
    ),
    headlineMedium: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s22,
    ),
    headlineSmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s18,
    ),

    titleLarge: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s22,
    ),
    titleMedium: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s16,
    ),
    titleSmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s14,
    ),

    bodyLarge: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral200,
      fontSize: FontSize.s16,
    ),
    bodyMedium: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral200,
      fontSize: FontSize.s14,
    ),
    bodySmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral200,
    ),

    labelLarge: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral400,
      fontSize: FontSize.s14,
    ),
    labelMedium: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral400,
    ),
    labelSmall: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral400,
      fontSize: FontSize.s10,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    leadingWidth: AppSize.s25,
    actionsPadding: const EdgeInsets.only(right: AppPadding.p20),
    titleSpacing: AppSize.s16,
    titleTextStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s25,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.neutral800,
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
    hintStyle: const TextStyle(
      color: AppColors.neutral300,
      fontSize: FontSize.s16,
      fontFamily: FontConstants.outfit,
    ),
    labelStyle: const TextStyle(
      color: AppColors.neutral300,
      fontSize: FontSize.s18,
      fontWeight: FontWeight.w500,
      fontFamily: FontConstants.outfit,
    ),
    floatingLabelStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s18,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.error,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(color: AppColors.neutral700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(color: AppColors.neutral700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r16),
      borderSide: const BorderSide(
        color: AppColors.secondary,
        width: AppSize.s2,
      ),
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
    linearTrackColor: AppColors.neutral800,
    borderRadius: BorderRadius.circular(RadiusSize.r8),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.backgroundDark1,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: getSemiBoldStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.white,
      fontSize: FontSize.s18,
    ),
    contentTextStyle: getRegularStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.neutral200,
      fontSize: FontSize.s16,
    ),
  ),

  cardTheme: CardThemeData(
    color: AppColors.cardSurface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.cardBorder),
    ),
  ),

  dividerTheme: const DividerThemeData(color: AppColors.divider),

  iconTheme: const IconThemeData(color: AppColors.white),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.backgroundDark1,
    ),
    checkColor: WidgetStateProperty.all(AppColors.white),
    side: const BorderSide(color: AppColors.neutral500),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundDark3,
    selectedLabelStyle: getMediumStyle(
      fontFamily: FontConstants.outfit,
      color: AppColors.secondary,
      fontSize: FontSize.s16,
    ),
    selectedItemColor: AppColors.secondary,
    unselectedItemColor: AppColors.neutral400,
    selectedIconTheme: const IconThemeData(color: AppColors.secondary),
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
    side: const WidgetStatePropertyAll(BorderSide(color: AppColors.cardBorder)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppPadding.p16),
      ),
    ),
    textStyle: WidgetStatePropertyAll(
      getSemiBoldStyle(
        fontFamily: FontConstants.outfit,
        color: AppColors.white,
      ),
    ),
  ),
);
