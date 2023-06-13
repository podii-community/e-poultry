import 'package:epoultry/core/presentation/components/lottie_animation.dart';
import 'package:epoultry/core/presentation/controllers/user_controller.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'gradient_widget.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {

  late final UserController _userController;

  @override
  void initState() {
    super.initState();

    _userController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: CustomColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: CustomColors.background,
        statusBarIconBrightness: Brightness.dark
      ),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: CustomColors.background,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LottieAnimation(lottie: 'assets/lottie/disconnect.json'),
              const SizedBox(
                height: 48,
              ),
              const Text("No Internet Connection",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: Colors.black)),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Check your internet connection and try again",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                  color: Color(0xff272727),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 48,
              ),
              //  refresh button
              GradientWidget(
                child: ElevatedButton(
                  onPressed: () {
                    //  refresh the internet connectivity checker
                    _userController.observeInternetConnection();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: CustomColors.background,
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor:
                      Colors.transparent.withOpacity(0.38),
                      disabledBackgroundColor:
                      Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                      fixedSize: Size(40.w, 6.h)),
                  child: Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 1.8.h,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
