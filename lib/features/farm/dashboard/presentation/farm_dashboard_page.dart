import 'package:epoultry/core/data/data_source/graphql/query_document_provider.dart';
import 'package:epoultry/features/farm/dashboard/presentation/components/bottom_app_bar/dashboard_app_bar.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/list_batches_page.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/dashboard_page.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/drawer_page.dart';
import 'package:epoultry/features/farm/e-extension/extension_services.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/profile_page.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/core/presentation/components/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/presentation/controllers/farm_controller.dart';
import '../../../../core/presentation/controllers/user_controller.dart';
import '../../../../core/domain/models/error.dart';
import '../../../../core/presentation/components/error_widget.dart';
import '../../../../core/presentation/components/loading_spinner.dart';
import 'components/bottom_app_bar/bottom_app_bar_icon.dart';
import 'controller/dashboard_controller.dart';

class FarmDashboardPage extends StatefulWidget {
  const FarmDashboardPage({Key? key}) : super(key: key);

  @override
  State<FarmDashboardPage> createState() => _FarmDashboardPageState();
}

class _FarmDashboardPageState extends State<FarmDashboardPage> {
  bool isLoading = false;
  late List<Widget> _bottomNavTabs;
  late List<Widget> _pages;
  late final DashboardController _dashboardController;

  final GlobalKey<ScaffoldState> _dashboardkey = GlobalKey();

  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  final box = Hive.box('appData');

  @override
  void initState() {
    super.initState();

    //  put the dashboard controller
    Get.lazyPut(() => DashboardController());
    _dashboardController = Get.find<DashboardController>();

    _pages = [
      const DashboardPage(),
      const ExtensionService(),
      const ListBatchPage(),
      const ProfilePage()
    ];

    _bottomNavTabs = [
      Obx(
        () => Expanded(
            child: bottomAppBarIcon(
                title: "Home",
                icon: PhosphorIcons.houseLineFill,
                isActive: _dashboardController.selectedTabIndex.value == 0,
                onTap: () => _dashboardController.onTabSelected(index: 0))),
      ),
      Obx(
        () => Expanded(
          child: bottomAppBarIcon(
              title: "E-Extension",
              icon: PhosphorIcons.personFill,
              isActive: _dashboardController.selectedTabIndex.value == 1,
              onTap: () => _dashboardController.onTabSelected(index: 1)),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      Obx(
        () => Expanded(
          child: bottomAppBarIcon(
              title: "Manage Batch",
              icon: PhosphorIcons.plus,
              isActive: _dashboardController.selectedTabIndex.value == 2,
              onTap: () => _dashboardController.onTabSelected(index: 2)),
        ),
      ),
      Obx(
        () => Expanded(
          child: bottomAppBarIcon(
              title: "Profile",
              icon: PhosphorIcons.userPlusFill,
              isActive: _dashboardController.selectedTabIndex.value == 3,
              onTap: () => _dashboardController.onTabSelected(index: 3)),
        ),
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
            return Container(
              color: CustomColors.background,
              child: const LoadingSpinner(),
            );
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
              body: Obx(
                () => IndexedStack(
                  key: UniqueKey(),
                  index: _dashboardController.selectedTabIndex.value,
                  children: _pages,
                ),
              ),
              bottomNavigationBar: mainBottomAppBar(tabs: _bottomNavTabs),
            ),
          );
        });
  }
}
