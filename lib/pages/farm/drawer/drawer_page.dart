import 'dart:developer';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/farm-managers/manage-farm-managers_page.dart';
import 'package:epoultry/pages/farm/farm-managers/profile_page.dart';
import 'package:epoultry/pages/farm/quotation/request_quotation_page.dart';
import 'package:epoultry/pages/landing_page.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

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
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('appData');
    final role = box.get('role');
    log("$role");
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(CustomSpacing.s1),
            bottomRight: Radius.circular(CustomSpacing.s1)),
      ),
      child: Column(
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

              return UserAccountsDrawerHeader(
                accountName: Text(user["firstName"] + user["lastName"]),
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
          Query(
            options: QueryOptions(
              document: gql(context.queries.getFarms()),
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

              if ((result.data?['user']!["managingFarms"]).isNotEmpty) {
                List farms = result.data?['user']?["managingFarms"];
                return farms.isEmpty
                    ? const Center(
                        child: Text("No Farms"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: farms.length,
                        itemBuilder: (context, position) {
                          // return Container();
                          return Card(
                            elevation: 0.2,
                            child: ListTile(
                              title: Text(
                                "${farms[position]["name"]}",
                                style: TextStyle(
                                    color: CustomColors.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 1.8.h),
                              ),
                            ),
                          );
                        });
              }

              if ((result.data?['user']!["ownedFarms"]).isNotEmpty) {
                List farms = result.data?['user']?["ownedFarms"];
                return farms.isEmpty
                    ? const Center(
                        child: Text("No Farms"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: farms.length,
                        itemBuilder: (context, position) {
                          // return Container();
                          return Card(
                            elevation: 0.2,
                            child: ListTile(
                              title: Text(
                                "${farms[position]["name"]}",
                                style: TextStyle(
                                    color: CustomColors.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 1.8.h),
                              ),
                            ),
                          );
                        });
              }

              return Container();
            },
          ),
          const SizedBox(
            height: CustomSpacing.s1,
          ),
          role == 'farmer'
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
          role == 'farmer'
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
          role == 'farmer'
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
          Expanded(child: Container()),
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
