import 'package:epoultry/pages/otp_page.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';

class FarmManagerRegistration extends StatelessWidget {
  FarmManagerRegistration({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              scale: 1,
            ),
            SizedBox(
              height: CustomSpacing.s1,
            ),
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 3.h),
            ),
            SizedBox(
              height: CustomSpacing.s3,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(fontSize: 2.2.h),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w,
                                  color: CustomColors.secondary))),
                    ),
                    SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(fontSize: 2.2.h),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w,
                                  color: CustomColors.secondary))),
                    ),
                  ],
                )),
            SizedBox(
              height: CustomSpacing.s3,
            ),
            GradientWidget(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(route: "register",)),);
                  },
                  child: Text('SIGN UP'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                      onPrimary: CustomColors.background,
                      fixedSize: Size(100.w, 6.h))),
            ),
            SizedBox(
              height: CustomSpacing.s3,
            ),
            RichText(
              text: TextSpan(
                  text: "Have an existing account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 2.2.h,
                  ),
                  children: [
                    TextSpan(
                      text: "LOGIN",
                      style: TextStyle(
                        color: CustomColors.secondary,
                        fontSize: 2.2.h,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
