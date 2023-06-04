import 'package:epoultry/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/presentation/controllers/farm_controller.dart';
import '../../../core/presentation/controllers/user_controller.dart';
import 'group_registration.dart';

class GroupDashboardPage extends StatefulWidget {
  const GroupDashboardPage({Key? key}) : super(key: key);

  @override
  State<GroupDashboardPage> createState() => _GroupDashboardPageState();
}

class _GroupDashboardPageState extends State<GroupDashboardPage> {
  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _dashboardkey = GlobalKey();
  final FarmsController controller = Get.put(FarmsController());
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _dashboardkey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          'Groups',
          style: TextStyle(color: Colors.black),
        ),
        leading: const Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.black,
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Manage Groups',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupRegistrationPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CustomColors.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                child: Row(children: [
                  const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Create a group',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'My Groups',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('All your groups will appear here'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.background,
        selectedItemColor: CustomColors.primary,
        unselectedItemColor: CustomColors.secondary,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt), label: "My Groups"),

          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.file), label: "Farm Visits"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.userPlus), label: "Profile"),

          // BottomNavigationBarItem(
          //     icon: Icon(PhosphorIcons.shoppingCart), label: "Ecommerce"),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
