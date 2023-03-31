import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../controllers/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  final box = Hive.box('appData');
  late final name = box.get('name');

  late final role = box.get('tokenRole');
  late final phone = box.get('tokenPhone');
  late final extVerify = box.get("extApproved");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Color.fromRGBO(1, 33, 56, 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: 88,
                            height: 88,
                            child: Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(userController
                                      .profileImage
                                      .value), // replace with your image URL
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.elliptical(88, 88),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(15.0),
                        //   child: SizedBox(
                        //       width: 88,
                        //       height: 88,
                        //       child: Container(
                        //           width: 88,
                        //           height: 88,
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: const Color.fromRGBO(
                        //                   255, 255, 255, 1),
                        //               width: 2,
                        //             ),
                        //             image: const DecorationImage(
                        //                 image: AssetImage(
                        //                     'assets/placeholder.png'),
                        //                 fit: BoxFit.fitWidth),
                        //             borderRadius: const BorderRadius.all(
                        //                 Radius.elliptical(88, 88)),
                        //           ))),
                        // ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              name ?? "E-Poultry Farming",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Extension Officer",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              phone ?? '  0701 234 567',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            (extVerify != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ACCOUNT',
                        style: TextStyle(
                            color:
                                Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            letterSpacing: 0.15000000596046448,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      const Divider(),
                      ListTile(
                        leading: SvgPicture.asset('assets/user_edit.svg',
                            semanticsLabel: 'vector'),
                        title: const Text("Edit Profile"),
                        trailing: SvgPicture.asset('assets/greater.svg',
                            semanticsLabel: 'vector'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.shield_moon,
                          color: Colors.black87,
                        ),
                        // SvgPicture.asset('assets/tick.svg',
                        //     semanticsLabel: 'vector'),
                        title: const Text("Change Password"),
                        trailing: SvgPicture.asset('assets/greater.svg',
                            semanticsLabel: 'vector'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: SvgPicture.asset('assets/plus.svg',
                            semanticsLabel: 'vector'),
                        title: const Text("Add Recovery Phone Number"),
                        trailing: SvgPicture.asset('assets/greater.svg',
                            semanticsLabel: 'vector'),
                      ),
                    ],
                  )
                : Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xfff6fbff)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("#Pending Approval",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "We are reviewing your account details. We’ll notify you as soon as it has been approved, till then you might not be able to acces some features.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ))
          ],
        ),
      ),
    );
  }
}
