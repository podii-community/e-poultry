import 'package:epoultry/pages/farm/join_farm_otp.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';

class JoinFarmPage extends StatelessWidget {
  const JoinFarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
                child: Image.asset(
                  'assets/chicken.png',
                  scale: 0.6,
                ),
              ),
              Text(
                "Hello Sophia",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 3.h),
              ),
              SizedBox(
                height: CustomSpacing.s2,
              ),
              Text(
                  "Farmer or Farm Manager, there is something for everyone.Join an existing farm or create your own farm account",
                  style: TextStyle(fontSize: 2.4.h)),
              SizedBox(
                height: CustomSpacing.s3,
              ),
              GradientWidget(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinFarmOtp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                      onPrimary: CustomColors.background,
                      fixedSize: Size(100.w, 6.h)),
                  child: Text('JOIN A FARM'),
                ),
              ),
              SizedBox(
                height: CustomSpacing.s2,
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text('CREATE A FARM'),
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
