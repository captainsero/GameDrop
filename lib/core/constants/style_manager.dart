import 'package:flutter/widgets.dart';

import 'font_manager.dart';

TextStyle getRegularStyle({
  required String fontFamily,
  required Color color,
  double fontSize = FontSize.s12c,
}) =>
    TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
    );

TextStyle getMediumStyle({
  required String fontFamily,
  required Color color,
  double fontSize = FontSize.s12c,
}) =>
    TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
    );

TextStyle getSemiBoldStyle({
  required String fontFamily,
  required Color color,
  double fontSize = FontSize.s12c,
}) =>
    TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
    );

TextStyle getBoldStyle({
  required String fontFamily,
  required Color color,
  double fontSize = FontSize.s12c,
}) =>
    TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
