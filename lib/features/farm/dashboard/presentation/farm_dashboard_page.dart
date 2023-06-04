import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/list_batches_page.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/dashboard_page.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/drawer_page.dart';
import 'package:epoultry/features/farm/e-extension/extension_services.dart';
import 'package:epoultry/features/farm/farm-managers/profile_page.dart';
import 'package:epoultry/core/theme/colors.dart';
import 'package:epoultry/core/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/controllers/farm_controller.dart';
import '../../../../core/controllers/user_controller.dart';
import '../../../../core/data/models/error.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_spinner.dart';

class FarmDashboardPage extends StatefulWidget {
  const FarmDashboardPage({Key? key}) : super(key: key);

  @override
  State<FarmDashboardPage> createState() => _FarmDashboardPageState();
}

class _FarmDashboardPageState extends State<FarmDashboardPage> {
  int _selectedIndex = 0;
  bool isLoading = false;
  late List<GButton> _bottomNavTabs;
  late List<Widget> _pages;


  final GlobalKey<ScaffoldState> _dashboardkey = GlobalKey();

  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  final box = Hive.box('appData');

  @override
  void initState() {
    super.initState();

    _pages = [
      const DashboardPage(),
      const ExtensionService(),
      const ListBatchPage(),
      const ProfilePage(
        showAppbar: false,
      )
    ];

    _bottomNavTabs = const [
      GButton(
        icon: PhosphorIcons.houseLine,
        text: "Home",
      ),
      GButton(
        icon: PhosphorIcons.person,
        text: "E-extension",
      ),
      GButton(
        icon: PhosphorIcons.plus,
        text: "Manage Batch",
      ),
      GButton(
        icon: PhosphorIcons.userPlus,
        text: "Profile",
      ),
    ];
  }

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
    return Query(
        options: QueryOptions(
          document: gql(context.queries.getContractors()),
          fetchPolicy: FetchPolicy.noCache,
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {

          if (result.isLoading) {
            return Container(color: CustomColors.background, child: const LoadingSpinner(),);
          }
          if (result.hasException) {
            return AppErrorWidget(
              error: ErrorModel.fromString(
                result.exception.toString(),
              ),
            );
          }

          //  setting the navbar background color
          return AnnotatedRegion(
            value: const SystemUiOverlayStyle(
                systemNavigationBarColor: CustomColors.background,
                systemNavigationBarIconBrightness: Brightness.dark),
            child: Scaffold(
              key: _dashboardkey,
              appBar: AppbarWidget(
                drawerKey: _dashboardkey,
              ),
              drawer: DrawerPage(),
              body: IndexedStack(
                key: UniqueKey(),
                index: _selectedIndex,
                children: _pages,
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GNav(
                  tabs: _bottomNavTabs,
                  onTabChange: _onItemTapped,
                  backgroundColor: CustomColors.background,
                  tabBackgroundColor: CustomColors.primary.withOpacity(0.05),
                  color: CustomColors.secondary,
                  activeColor: CustomColors.primary,
                  gap: 8,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
