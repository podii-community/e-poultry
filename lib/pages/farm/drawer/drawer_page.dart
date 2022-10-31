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
import '../../../data/models/error.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../create-farm/create_farm_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final FarmsController controller = Get.put(FarmsController());

  final UserController userController = Get.put(UserController());

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

              final name = user["firstName"] + " " + user["lastName"];
              userController.updateName(name);
              userController.updatePhone(user["phoneNumber"]);

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
            () => controller.farms!.isEmpty
                ? const Center(
                    child: Text("No Farms"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.farms!.length,
                    itemBuilder: (context, position) {
                      // return Container();
                      return Card(
                        elevation: 0.2,
                        child: ListTile(
                          onTap: () {
                            final farm = controller.farms[position]! ?? {};
                            final batches = farm!["batches"] ?? [];
                            controller.updateFarm(farm);
                            controller.batchesList(batches);

                            List reports = [];
                            for (var batch in batches) {
                              reports.addAll(batch["reports"]);
                            }

                            controller.reportsList(reports);
                            Navigator.pop(context);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateFarmPage()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageFarmManagers()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RequestQuotationPage()),
                    );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
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
                onTap: () {
                  final box = Hive.box('appData');
                  box.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
