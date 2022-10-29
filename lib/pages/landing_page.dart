import 'package:epoultry/pages/auth/login.dart';
import 'package:epoultry/pages/auth/registration.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          // padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 55.h,
                width: 100.w,
                child: Image.asset(
                  'assets/landing.png',
                  scale: 0.1,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Image.asset(
                'assets/logo.png',
                scale: 1.5,
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
               Text("Welcome to Epoultry!", style: TextStyle(
                fontSize: 2.8.h,
                 fontWeight: FontWeight.w600
              ),),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
               Text(
                "Farmer or Farm Manager, \n  there is something for everyone.",
                style: TextStyle(
                    fontSize: 2.1.h,

                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
                child: GradientWidget(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        onPrimary: CustomColors.background,
                        fixedSize: Size(100.w, 6.h)),
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontSize: 1.8.h,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              RichText(
                text: TextSpan(
                    text: "Have an existing account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 1.8.h,
                    ),
                    children: [
                      TextSpan(
                          text: "LOGIN",
                          style: TextStyle(
                              color: CustomColors.secondary,
                              fontSize: 1.8.h,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            })
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
