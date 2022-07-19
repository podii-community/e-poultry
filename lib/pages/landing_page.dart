import 'package:epoultry/pages/farm_manager/farm_manager_login.dart';
import 'package:epoultry/pages/farm_manager/farm_manager_registration.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.background,
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          scale: 2,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 6.h,),
              Container(
                height: 55.h,
                child: Stack(
                  children: [
                    Align(
                      child: Image.asset(
                        'assets/landing.png',
                        scale: 0.2,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Purchase.",
                          style: TextStyle(
                              fontSize: 4.h, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Manage.",
                          style: TextStyle(
                              fontSize: 4.h, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Sell.",
                          style: TextStyle(
                              fontSize: 4.h, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GradientWidget(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FarmManagerRegistration()),
                    );
                  },
                  child: Text('SIGN UP'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                      onPrimary: CustomColors.background,
                      fixedSize: Size(100.w, 6.h)),
                ),
              ),
              SizedBox(
                height: CustomSpacing.s1,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FarmManagerLogin()),
                  );
                },
                child: Text('LOG IN'),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 0.1.w, color: CustomColors.primary),
                    primary: CustomColors.primary,
                    fixedSize: Size(100.w, 6.h)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
