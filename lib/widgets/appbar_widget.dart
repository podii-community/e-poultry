
import 'package:epoultry/controllers/user_controller.dart';
import 'package:epoultry/pages/farm/notifications/view-notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/farm_controller.dart';
import '../theme/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({Key? key, @required this.drawerKey})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  final drawerKey;
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('appData');
    final name = box.get('name');

    final controller = Get.find<FarmsController>();
    final userController = Get.find<UserController>();

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
          child: CircleAvatar(
            radius: 10,
            backgroundColor: CustomColors.secondary,
            child: Obx(() => Text(
                  userController.userName.value.isNotEmpty
                      ? userController.userName.value.substring(0, 1)
                      : "",
                  style:
                      TextStyle(fontSize: 4.h, color: CustomColors.background),
                )),
          ),
        ),
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
        title: Obx((() => Text(
              controller.farm.value['name'] ?? 'E-Poultry Farming',
              style: const TextStyle(color: Colors.black),
            ))));
  }
}
