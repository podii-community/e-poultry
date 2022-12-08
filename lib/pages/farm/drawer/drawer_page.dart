import 'dart:developer';

import 'package:epoultry/controllers/user_controller.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/auth/login.dart';
import 'package:epoultry/pages/farm/farm-managers/manage-farm-managers_page.dart';
import 'package:epoultry/pages/farm/farm-managers/profile_page.dart';
import 'package:epoultry/pages/farm/quotation/request_quotation_page.dart';
import 'package:epoultry/pages/landing_page.dart';
import 'package:epoultry/services/farm_service.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../controllers/managers_controller.dart';
import '../../../data/models/error.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../create-farm/create_farm_page.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({Key? key}) : super(key: key);

  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  final ManagersController managersController = ManagersController();

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('appData');

    // final role = box.get('role');
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(CustomSpacing.s1),
            bottomRight: Radius.circular(CustomSpacing.s1)),
      ),
      child: ListView(
        children: [
          Query(
            options: QueryOptions(
              document: gql(context.queries.getUserDetails()),
              fetchPolicy: FetchPolicy.noCache,
              pollInterval: const Duration(minutes: 2),
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

              final user = result.data?['user'];

              // final name = user["firstName"] + " " + user["lastName"];
              // userController.updateName(name);
              // userController.updatePhone(user["phoneNumber"]);

              return UserAccountsDrawerHeader(
                accountName: Text(userController.userName.value),
                accountEmail: Text(user["phoneNumber"]),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: CustomColors.background,
                  child: Text(
                    user["firstName"][0],
                    style: TextStyle(fontSize: 4.0.h),
                  ),
                ),
                decoration: const BoxDecoration(color: CustomColors.secondary),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("ALL FARMS"),
          ),
          Obx(
            () => controller.farms.isEmpty
                ? const Center(
                    child: Text("No Farms"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.farms.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, position) {
                      return Card(
                        elevation: 0.2,
                        child: ListTile(
                          onTap: () async {
                            final farm = controller.farms[position]! ?? {};
                            final batches = farm!["batches"] ?? [];
                            controller.updateFarm(farm);
                            controller.batchesList(batches);
                            // await FarmService().getFarmReports(
                            //     context, controller.farm.value['id']);
                            getFarmManager(
                                context, controller.farms[position]['id']);

                            Get.back();
                          },
                          title: Text(
                            "${controller.farms[position]["name"]}",
                            style: TextStyle(
                                color: CustomColors.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 1.8.h),
                          ),
                        ),
                      );
                    }),
          ),
          const SizedBox(
            height: CustomSpacing.s1,
          ),
          userController.userRole.value == 'farmer'
              ? ListTile(
                  leading: Icon(
                    PhosphorIcons.plusCircleFill,
                    color: CustomColors.secondary,
                    size: 3.h,
                  ),
                  title: Text(
                    'Add Another Farm',
                    style: TextStyle(
                        color: CustomColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 1.8.h),
                  ),
                  onTap: () {
                    Get.to(() => CreateFarmPage());
                  },
                )
              : Container(),
          userController.userRole.value == 'farmer'
              ? ListTile(
                  leading: Icon(
                    PhosphorIcons.usersFill,
                    color: CustomColors.secondary,
                    size: 3.h,
                  ),
                  title: Text('Manage Farm Managers',
                      style: TextStyle(
                          color: CustomColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.8.h)),
                  onTap: () {
                    Get.to(() => ManageFarmManagers());
                  },
                )
              : Container(),
          userController.userRole.value == 'farmer'
              ? ListTile(
                  leading: Icon(
                    PhosphorIcons.tagFill,
                    color: CustomColors.secondary,
                    size: 3.h,
                  ),
                  title: Text('Request Quotation',
                      style: TextStyle(
                          color: CustomColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.8.h)),
                  onTap: () {
                    Get.to(() => RequestQuotationPage());
                  },
                )
              : Container(),
          ListTile(
            leading: Icon(
              PhosphorIcons.pencilFill,
              color: CustomColors.secondary,
              size: 3.h,
            ),
            title: Text('Profile',
                style: TextStyle(
                    color: CustomColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 1.8.h)),
            onTap: () {
              Get.to(() => ProfilePage());
            },
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  PhosphorIcons.signOutFill,
                  color: CustomColors.primary,
                  size: 3.h,
                ),
                title: Text('Log Out',
                    style: TextStyle(
                        color: CustomColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 1.8.h)),
                onTap: () async {
                  controller.selectedFarmId.value = "";
                  controller.farm.clear();
                  final box = Hive.box('appData');
                  box.clear();

                  Get.to(() => LandingPage());

                  // await Get.deleteAll(force: true)
                  //     .then((value) => Get.to(() => LandingPage()));
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> getFarmReports(BuildContext context, id) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchReports = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "GetFarmReports",
        document: gql(context.queries.getFarmReports()),
        variables: {
          "filter": {"farmId": id}
        }));

    List reports = [];

    for (var report in fetchReports.data!["farmReports"]) {
      reports.add(report);
    }

    controller.reportsList(reports);
  }

  Future<void> getFarmManager(BuildContext context, id) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchManagers = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "GetFarmManagers",
        document: gql(context.queries.getFarmManagers()),
        variables: {"farmId": controller.farm.value['id']}));

    if (fetchManagers.data?["farmManagers"] != null) {
      List farmManagers = fetchManagers.data?["farmManagers"];

      managersController.managers(farmManagers);
    }
  }
}
