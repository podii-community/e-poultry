import 'dart:developer';

import 'package:epoultry/pages/farm/farm-managers/edit-profile_page.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.showAppbar = true}) : super(key: key);

  final bool showAppbar;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('appData');
    final name = box.get('name');
    final phone = box.get('phone');
    final role = box.get('role');
    log("Profile ${controller.farm.value['id']}");

    return Scaffold(
        appBar: widget.showAppbar
            ? AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                toolbarHeight: 8.h,
                backgroundColor: CustomColors.white,
                elevation: 0.5,
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
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
              )
            : const PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: SizedBox.shrink(),
              ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(fontSize: 1.5.h),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s1,
                          ),
                          Text(
                            userController.userName.value,
                            style: TextStyle(fontSize: 2.h),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const EditProfilePage());
                        },
                        child: Wrap(
                          children: [
                            const Icon(
                              PhosphorIcons.pencilFill,
                              color: CustomColors.secondary,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 5.w,
                                color: CustomColors.secondary,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 1.5.h),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    userController.phoneNumber.value,
                    style: TextStyle(fontSize: 2.h),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Text(
                    'Recovery Phone Number',
                    style: TextStyle(fontSize: 1.5.h),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    'None',
                    style: TextStyle(fontSize: 2.h),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 1.5.h),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    userController.userRole.value == 'manager'
                        ? "Farm Manager"
                        : "Farmer",
                    style: TextStyle(fontSize: 2.h),
                  ),
                ],
              ),
            )),
          ]),
        ));
  }
}
