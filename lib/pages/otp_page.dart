import 'package:epoultry/pages/farm/join_farm_page.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:epoultry/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../theme/colors.dart';
import '../theme/spacing.dart';

class OtpPage extends StatefulWidget {
  OtpPage({Key? key, required this.route, required this.phone})
      : super(key: key);

  final String route;
  final String phone;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

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
              'Verify Phone Number',
              style: TextStyle(fontSize: 3.h),
            ),
            SizedBox(
              height: CustomSpacing.s2,
            ),
            Container(
              width: 80.w,
              child: Text(
                'A 4-digit code has been sent to +254${widget.phone}',
                style: TextStyle(fontSize: 2.h),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: CustomSpacing.s3,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Pinput(
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      validator: (s) {
                        return s == '2222'
                            ? null
                            : 'Wrong code. Please try again';
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                    SizedBox(
                      height: CustomSpacing.s3,
                    ),
                  ],
                )),
            SizedBox(
              height: CustomSpacing.s3,
            ),
            GradientWidget(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuccessWidget(
                                  message:
                                      'Your phone number has been verified',
                                  route: widget.route,
                                )));
                  },
                  child: Text('VERIFY PHONE NUMBER'),
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
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Didnt get the code? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 2.2.h,
                  ),
                  children: [
                    TextSpan(
                      text: "Resend in 60 seconds",
                      style: TextStyle(
                          color: CustomColors.secondary,
                          fontSize: 2.2.h,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
