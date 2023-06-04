import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kPrimary = MaterialColor(
    0xffFF0000, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      100: Color(0xffFCF7F7), //20%
      200: Color(0xffF8E7E7), //30%
      300: Color(0xffEF8F8F), //40%
      400: Color(0xffF35353), //50%
      500: Color(0xffD20F0F), //60%
      600: Color(0xffD20F0F), //70%
      700: Color(0xffAA1818), //80%
      800: Color(0xff821C1C), //90%
      900: Color(0xff602020), //100%
    },
  );

  static const MaterialColor kSecondary = MaterialColor(
    0xff345995, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      100: Color(0xffF4F5F6), //20%
      200: Color(0xffCED8DF), //30%
      300: Color(0xffA7C0D2), //40%
      400: Color(0xff75A5C7), //50%
      500: Color(0xff4892C7), //60%
      600: Color(0xff2776B0), //70%
      700: Color(0xff155B8E), //80%
      800: Color(0xff083D63), //90%
      900: Color(0xff012138), //100%
    },
  );

  static const MaterialColor kWarnings = MaterialColor(
    0xffEAC435, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      100: Color(0xffF8F7F2), //20%
      200: Color(0xffEBE4CC), //30%
      300: Color(0xffE4D6A0), //40%
      400: Color(0xffE2CA6E), //50%
      500: Color(0xffEAC435), //60%
      800: Color(0xff877221), //90%
      900: Color(0xff252113), //100%
    },
  );

  static const MaterialColor kSuccess = MaterialColor(
    0xffEAC435, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      100: Color(0xffF4FAF9), //20%
      200: Color(0xffBCEBE2), //30%
      300: Color(0xffB6F2E5), //40%
      400: Color(0xff2DEBC4), //50%
      500: Color(0xff03CEA4), //60%
      800: Color(0xff13725E), //90%
      900: Color(0xff0F2924), //100%
    },
  );
}
