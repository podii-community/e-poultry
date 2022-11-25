import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/batch/list_batches_page.dart';
import 'package:epoultry/pages/farm/dashboard/dashboard_page.dart';
import 'package:epoultry/pages/farm/drawer/drawer_page.dart';
import 'package:epoultry/pages/farm/farm-managers/profile_page.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../controllers/farm_controller.dart';
import '../../../controllers/user_controller.dart';

class FarmDashboardPage extends StatefulWidget {
  const FarmDashboardPage({Key? key}) : super(key: key);

  @override
  State<FarmDashboardPage> createState() => _FarmDashboardPageState();
}

class _FarmDashboardPageState extends State<FarmDashboardPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    DashboardPage(),
    const ListBatchPage(),
    const ProfilePage(
      showAppbar: false,
    )
  ];
  final GlobalKey<ScaffoldState> _dashboardkey = GlobalKey();
  final FarmsController controller = Get.put(FarmsController());
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    // implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFarms(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _dashboardkey,
      appBar: AppbarWidget(
        drawerKey: _dashboardkey,
      ),
      drawer: const DrawerPage(),
      body: IndexedStack(
        key: UniqueKey(),
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.background,
        selectedItemColor: CustomColors.primary,
        unselectedItemColor: CustomColors.secondary,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.houseLine),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.plus), label: "Manage Batch"),
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

  Future<void> getFarms(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var farms = await client.query(QueryOptions(
      document: gql(context.queries.getFarms()),
    ));

    List managingFarms = farms.data!['user']!["managingFarms"];
    List ownedFarms = farms.data!['user']!["ownedFarms"];

    List farmsList = managingFarms + ownedFarms;

    controller.updateFarms(farmsList);
  }
}
