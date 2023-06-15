import 'package:epoultry/core/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: CustomColors.primary,
        scaffoldBackgroundColor: CustomColors.background,
        textTheme: GoogleFonts.dmSansTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity);
  }
}
