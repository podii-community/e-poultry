import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        // leading: IconButton(
        //   icon: const Icon(
        //     PhosphorIcons.arrowLeft,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
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
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      width: 2,
                                    ),
                                    image: const DecorationImage(
                                        image: AssetImage('assets/logo.png'),
                                        fit: BoxFit.fitWidth),
                                    borderRadius: const BorderRadius.all(
                                        Radius.elliptical(88, 88)),
                                  ))),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Text(
                              'Margaret WN.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Extension officer',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '0701 234 567',
                              textAlign: TextAlign.left,
                              style: TextStyle(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ACCOUNT',
                  style: TextStyle(
                      color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.background,
        selectedItemColor: CustomColors.primary,
        unselectedItemColor: CustomColors.secondary,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.houseLine),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.clipboardBold), label: "Farm Visits"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.userCircle), label: "Profile"),
          // BottomNavigationBarItem(
          //     icon: Icon(PhosphorIcons.shoppingCart), label: "Ecommerce"),
        ],
      ),
    );
  }
}
