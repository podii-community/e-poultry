import 'package:epoultry/features/auth/login.dart';
import 'package:epoultry/core/theme/colors.dart';
import 'package:epoultry/core/theme/spacing.dart';
import 'package:epoultry/core/presentation/components/gradient_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../onboarding/extension_option.dart';

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
            children: [
              SizedBox(
                height: 15.h,
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Image.asset(
                'assets/landing.png',
                scale: 1.5,
              ),
              const SizedBox(
                height: CustomSpacing.s2,
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
                      Get.to(() => const ChooseExtension());
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: CustomColors.background,
                        backgroundColor: Colors.transparent,
                        disabledForegroundColor:
                            Colors.transparent.withOpacity(0.38),
                        disabledBackgroundColor:
                            Colors.transparent.withOpacity(0.12),
                        shadowColor: Colors.transparent,
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
                              Get.to(() => const LoginPage());
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
