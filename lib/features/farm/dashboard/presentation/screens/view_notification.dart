import 'package:epoultry/core/presentation/components/lottie_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';

class ViewNotification extends StatefulWidget {
  const ViewNotification({Key? key}) : super(key: key);

  @override
  State<ViewNotification> createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Center(
                      child: LottieAnimation(
                    lottie: "assets/lottie/blue_bell.json",
                  ))),
            ),
            Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Text("No Notifications yet."))))
          ],
        ),
      ),
    );
  }
}
