import 'package:flutter/material.dart';

abstract class ScreenSize {
  static late double width;
  static late double height;

  static void intial(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;
  }
}
