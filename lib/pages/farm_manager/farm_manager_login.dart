import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../otp_page.dart';

class FarmManagerLogin extends StatelessWidget {
   FarmManagerLogin({Key? key}) : super(key: key);

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
              'Log In',
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(route: "login",)),);
                  },
                  child: Text('LOG IN'),
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
                  text: "Create an account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 2.2.h,
                  ),
                  children: [
                    TextSpan(
                      text: "SIGN UP",
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
