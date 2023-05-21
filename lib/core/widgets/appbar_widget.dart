import 'package:epoultry/features/pages/farm/notifications/view_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/farm_controller.dart';
import '../theme/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({Key? key, @required this.drawerKey})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final drawerKey;
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FarmsController>();

    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      toolbarHeight: 8.h,
      backgroundColor: CustomColors.white,
      elevation: 0.5,
      leading: InkWell(
          onTap: () {
            drawerKey.currentState!.openDrawer();
          },
          child: Image.asset(
            'assets/logo.png',
            scale: 2.1,
          )),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => const ViewNotification());
            },
            icon: const Icon(
              PhosphorIcons.bell,
              color: CustomColors.secondary,
            ))
      ],
      title: Obx(
        (() => Text(
              controller.farm['name'] ?? 'E-Poultry Farming',
              style: const TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
