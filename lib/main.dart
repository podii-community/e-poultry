import 'package:epoultry/pages/farm/batch/confirm_batch_page.dart';
import 'package:epoultry/pages/farm/batch/create_batch_page.dart';
import 'package:epoultry/pages/farm/batch/list_batches_page.dart';
import 'package:epoultry/pages/farm/farm_dashboard_page.dart';
import 'package:epoultry/pages/farm/join_farm_otp.dart';
import 'package:epoultry/pages/farm/join_farm_page.dart';
import 'package:epoultry/pages/farm_manager/farm_manager_login.dart';
import 'package:epoultry/pages/farm_manager/farm_manager_registration.dart';
import 'package:epoultry/pages/landing_page.dart';
import 'package:epoultry/pages/otp_page.dart';
import 'package:epoultry/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Epoultry',
          theme: CustomTheme.lightTheme,
          home: LandingPage(),
        );
      },
    );
  }
  // return MaterialApp(
  //     title: 'Epoultry', theme: CustomTheme.lightTheme, home: LandingPage());

}
