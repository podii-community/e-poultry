import 'package:epoultry/core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/presentation/controllers/farm_controller.dart';
import '../../../../../core/presentation/controllers/user_controller.dart';
import '../../../../../core/theme/colors.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    // final box = Hive.box('appData');
    // final name = box.get('name');
    // final phone = box.get('phone');
    // final role = box.get('role');
    // log("Profile ${controller.farm.value['id']}");

    return Scaffold(
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
