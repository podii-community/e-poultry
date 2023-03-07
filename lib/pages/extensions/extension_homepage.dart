import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/extensions/dashboard_page.dart';
import 'package:epoultry/pages/extensions/farm_visits.dart';
import 'package:epoultry/pages/extensions/profile_page.dart';
import 'package:epoultry/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/farm_controller.dart';
import '../../controllers/user_controller.dart';
import '../../theme/colors.dart';

class ExtensionHomePage extends StatefulWidget {
  const ExtensionHomePage({super.key});

  @override
  State<ExtensionHomePage> createState() => _ExtensionHomePageState();
}

class _ExtensionHomePageState extends State<ExtensionHomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _dashboardkey = GlobalKey();
  static final List<Widget> _pages = <Widget>[
    const DashboardPage(),
    const FarmVisits(),
    const ProfilePage()
  ];

  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  final box = Hive.box('appData');
  late final name = box.get('name');

  late final role = box.get('tokenRole');
  @override
  void didChangeDependencies() {
    getUserDetails(context);
    super.didChangeDependencies();
  }

  Future<void> getUserDetails(BuildContext context) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchDetails = await client.query(QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      operationName: "GetUserDetails",
      document: gql(context.queries.getUserDetails()),
    ));

    if (fetchDetails.data!.isNotEmpty) {
      final name = fetchDetails.data!['user']["firstName"] +
          " " +
          fetchDetails.data!['user']["lastName"];

      userController.updateName(name);
      userController.updatePhone(fetchDetails.data!['user']['phoneNumber']);
      userController.updateLoc(
          fetchDetails.data!['user']["extensionOfficer"]['address']['county']);

      box.put('name',
          "${fetchDetails.data!['user']['firstName']} ${fetchDetails.data!['user']['lastName']}");
      box.put('phone', fetchDetails.data!['user']['phoneNumber']);
    }
  }

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
          leadingWidth: 80,
          toolbarHeight: 8.h,
          backgroundColor: CustomColors.white,
          elevation: 0.5,
          leading: InkWell(
              onTap: () {
                // widget.drawerKey.currentState!.openDrawer();
              },
              child: Image.asset(
                'assets/logo.png',
                scale: 2.1,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(() => const LandingPage());
                },
                icon: const Icon(
                  PhosphorIcons.signOut,
                  color: CustomColors.secondary,
                ))
          ],
          title: Text(
            userController.userName.value,
            style: const TextStyle(color: Colors.black),
          )),
      body: IndexedStack(
        key: UniqueKey(),
        index: _selectedIndex,
        children: _pages,
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
