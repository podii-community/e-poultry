import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/veterinary/dashboard_page.dart';
import 'package:epoultry/pages/veterinary/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../controllers/farm_controller.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/error.dart';
import '../../theme/colors.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_spinner.dart';

class VeterinaryHomePage extends StatefulWidget {
  const VeterinaryHomePage({super.key});

  @override
  State<VeterinaryHomePage> createState() => _VeterinaryHomePageState();
}

class _VeterinaryHomePageState extends State<VeterinaryHomePage> {
  int _selectedIndex = 0;
  bool isLoading = false;
  // final GlobalKey<ScaffoldState> _dashboardkey = GlobalKey();
  static final List<Widget> _pages = <Widget>[
    const DashboardPage(),
    const ProfilePage()
  ];
  final GlobalKey<ScaffoldState> _dashboardkey = GlobalKey();

  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  final box = Hive.box('appData');
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

      box.put('name',
          "${fetchDetails.data!['user']['firstName']} ${fetchDetails.data!['user']['lastName']}");
      box.put('phone', fetchDetails.data!['user']['phoneNumber']);

      if (fetchDetails.data!['user']['farmer'] == null) {
        box.put('role', 'manager');
        userController.updateRole('manager');
      } else {
        userController.updateRole('farmer');
        box.put('role', 'farmer');
      }

      if (fetchDetails.data!['user']['managingFarms'].isNotEmpty ||
          fetchDetails.data!['user']['ownedFarms'].isNotEmpty) {
        List managingFarms = fetchDetails.data!['user']!["managingFarms"];
        List ownedFarms = fetchDetails.data!['user']!["ownedFarms"];

        List farms = managingFarms + ownedFarms;

        controller.updateFarms(farms);
        if (controller.selectedFarmId.value.isEmpty) {
          controller.updateFarm(farms[0]);
          controller.selectedFarmId.value = farms[0]['id'];
          controller.updateBatches(farms[0]['batches']);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Query(
        options: QueryOptions(
          document: gql(context.queries.getContractors()),
          fetchPolicy: FetchPolicy.noCache,
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const LoadingSpinner();
          }
          if (result.hasException) {
            return AppErrorWidget(
              error: ErrorModel.fromString(
                result.exception.toString(),
              ),
            );
          }
          return Scaffold(
            appBar: AppbarWidget(
              drawerKey: _dashboardkey,
            ),
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
                    icon: Icon(PhosphorIcons.clipboardBold),
                    label: "Farm Visits"),
                BottomNavigationBarItem(
                    icon: Icon(PhosphorIcons.userCircle), label: "Profile"),
                // BottomNavigationBarItem(
                //     icon: Icon(PhosphorIcons.shoppingCart), label: "Ecommerce"),
              ],
            ),
          );
        });
  }
}
