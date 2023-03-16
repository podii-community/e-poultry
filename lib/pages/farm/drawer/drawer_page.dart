import 'dart:developer';

import 'package:epoultry/controllers/user_controller.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/farm-managers/manage-farm-managers_page.dart';
import 'package:epoultry/pages/farm/farm-managers/profile_page.dart';
import 'package:epoultry/pages/farm/quotation/request_quotation_page.dart';
import 'package:epoultry/pages/landing_page.dart';
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
    final selectedFarmId =
        TextEditingController(text: controller.farm.value['id']);

    // final role = box.get('role');
    return Drawer(
      backgroundColor: CustomColors.drawerBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(CustomSpacing.s1),
            bottomRight: Radius.circular(CustomSpacing.s1)),
      ),
      child: ListView(
        children: [
          Container(
            height: 15.h,
            child: Image.asset('assets/logo.png'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.2.w),
            child: Text(userController.userName.value,
                style: TextStyle(
                    color: CustomColors.textPrimary,
                    fontSize: 2.6.h,
                    fontWeight: FontWeight.w500)),
          ),
          Obx(
            () => controller.farms.isEmpty
                ? const Center(
                    child: Text("No Farms"),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.2.w),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(),
                      dropdownColor: CustomColors.drawerBackground,
                      style: TextStyle(
                          color: CustomColors.textPrimary, fontSize: 2.3.h),
                      value: selectedFarmId.text,
                      hint: const Text(
                        'Select Farm',
                      ),
                      onChanged: (String? farmId) {
                        var selectedFarm = controller.farms
                            .firstWhere((farm) => farm['id'] == farmId);

                        final farm = selectedFarm ?? {};
                        final batches = farm!["batches"] ?? [];
                        controller.updateFarm(farm);
                        controller.batchesList(batches);

                        getFarmManager(context, selectedFarmId.text);

                        Get.back();
                      },
                      items: controller.farms.map((value) {
                        return DropdownMenuItem(
                          value: value["id"].toString(),
                          child: Text(value["name"]),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          const SizedBox(
            height: CustomSpacing.s1,
          ),
          Divider(),
          userController.userRole.value == 'farmer'
              ? ListTile(
                  leading: Icon(
                    PhosphorIcons.plusCircleFill,
                    color: CustomColors.textPrimary,
                    size: 3.h,
                  ),
                  title: Text(
                    'Add Another Farm',
                    style: TextStyle(
                        color: CustomColors.textPrimary, fontSize: 2.2.h),
                  ),
                  onTap: () {
                    Get.to(() => const CreateFarmPage());
                  },
                )
              : Container(),
          userController.userRole.value == 'farmer'
              ? ListTile(
                  leading: Icon(
                    PhosphorIcons.usersFill,
                    color: CustomColors.textPrimary,
                    size: 3.h,
                  ),
                  title: Text('Manage Farm Managers',
                      style: TextStyle(
                          color: CustomColors.textPrimary, fontSize: 2.2.h)),
                  onTap: () {
                    Get.to(() => const ManageFarmManagers());
                  },
                )
              : Container(),
          userController.userRole.value == 'farmer'
              ? ListTile(
                  leading: Icon(
                    PhosphorIcons.tagFill,
                    color: CustomColors.textPrimary,
                    size: 3.h,
                  ),
                  title: Text('Request Quotation',
                      style: TextStyle(
                          color: CustomColors.textPrimary, fontSize: 2.2.h)),
                  onTap: () {
                    Get.to(() => const RequestQuotationPage());
                  },
                )
              : Container(),
          ListTile(
            leading: Icon(
              PhosphorIcons.pencilFill,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            title: Text('Profile',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
            onTap: () {
              Get.to(() => const ProfilePage());
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
                        color: CustomColors.primary, fontSize: 2.2.h)),
                onTap: () async {
                  controller.selectedFarmId.value = "";
                  controller.farm.clear();
                  final box = Hive.box('appData');
                  box.clear();

                  Get.to(() => const LandingPage());
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
