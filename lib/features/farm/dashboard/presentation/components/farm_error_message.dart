import 'package:epoultry/core/presentation/components/lottie_animation.dart';
import 'package:epoultry/features/farm/create-farm/create_farm_page.dart';
import 'package:epoultry/features/farm/join-farm/join_farm_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/presentation/components/gradient_widget.dart';

/// To be implement if the farm input is null
class FarmErrorMessage extends StatelessWidget {
  const FarmErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          children: [
            const LottieAnimation(lottie: "assets/lottie/farm_truck.json"),

            const SizedBox(height: 24,),

            const Text("No Farm found, Let's help you create one."),

            const SizedBox(height: 24,),

            GradientWidget(
              child: ElevatedButton(
                onPressed: () {
                  //  navigate to Create Farm page
                  Get.to(() => const JoinFarmPage());
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
                  'Create a Farm',
                  style: TextStyle(
                    fontSize: 1.8.h,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
