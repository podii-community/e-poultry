import 'package:flutter/material.dart';

class CustomColors {
  static const Color primary = Color(0xFFFF0000);
  static const Color secondary = Color(0xFF345995);
  static const Color red = Color(0xFFE40066);
  static const Color redLight = Color(0xFFFF9999);
  static const Color yellow = Color(0xFFEAC435);
  static const Color green = Color(0xFF03CEA4);
  static const Color background = Color.fromARGB(255, 253, 253, 253);
  static const Color tertiary = Color(0xFF5B41FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color drawerBackground = Color(0xFFF7FBFF);
  static const Color textPrimary = Color(0xFF012138);
  static const Color snackbarBackground = Color(0xff252525);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      yellow,
    ],
  );
}
