import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/gradient_widget.dart';
import '../../widgets/success_widget.dart';

class JoinFarmOtp extends StatelessWidget {
  JoinFarmOtp({Key? key}) : super(key: key);

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
              'Join a Farm',
              style: TextStyle(fontSize: 3.h),
            ),
            SizedBox(
              height: CustomSpacing.s2,
            ),
            Container(
              width: 80.w,
              child: Text(
                'Get a 4 digit code from the farmer and dial it below',
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
                                      'You have successfully joined Odongos farm',
                                  route: 'dashboard',
                                )));
                  },
                  child: Text('VERIFY CODE'),
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
          ],
        ),
      ),
    );
  }
}
