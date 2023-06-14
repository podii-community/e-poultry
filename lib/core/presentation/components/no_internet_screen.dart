import 'package:epoultry/core/presentation/components/lottie_animation.dart';
import 'package:epoultry/core/presentation/controllers/user_controller.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'gradient_widget.dart';

class NoInternetScreen extends StatefulWidget {
  final VoidCallback onRefresh;

  const NoInternetScreen({super.key, required this.onRefresh});

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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              width: 250,
              height: 250,
              child: LottieAnimation(lottie: 'assets/lottie/disconnect.json')),
          const SizedBox(
            height: 48,
          ),
          const Text("Couldn't retrieve data",
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
              onPressed: () => widget.onRefresh(),
              style: ElevatedButton.styleFrom(
                  foregroundColor: CustomColors.background,
                  backgroundColor: Colors.transparent,
                  disabledForegroundColor: Colors.transparent.withOpacity(0.38),
                  disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
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
    );
  }
}
