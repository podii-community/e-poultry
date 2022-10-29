import 'package:epoultry/pages/farm/farm-managers/edit-profile_page.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('appData');
    final name = box.get('name');
    final phone = box.get('phone');
    final role = box.get('role');
    return Scaffold(
        appBar: AppBar(
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
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: CustomSpacing.s3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                name,
                                style: TextStyle(fontSize: 2.h),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfilePage()),
                              );
                            },
                            child: Wrap(
                              children: [
                                Icon(
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
                        phone,
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
                        role == 'manager' ? "Farm Manager" : "Farmer",
                        style: TextStyle(fontSize: 2.h),
                      ),
                    ],
                  ),
                )),
              ]),
        ));
  }
}
