import 'dart:developer';

import 'package:epoultry/core/presentation/components/no_internet_screen.dart';
import 'package:epoultry/core/presentation/controllers/farm_controller.dart';
import 'package:epoultry/features/farm/dashboard/presentation/components/farm_error_message.dart';
import 'package:epoultry/features/farm/reports/all_reports_page.dart';
import 'package:epoultry/features/farm/reports/select_batch_page.dart';
import 'package:epoultry/core/data/data_source/graphql/query_document_provider.dart';
import 'package:epoultry/features/farm/reports/view_report_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/presentation/controllers/user_controller.dart';
import '../../../../../core/domain/models/error.dart';
import '../../../../../theme/colors.dart';
import '../../../../../theme/spacing.dart';
import '../../../../../core/presentation/components/error_widget.dart';
import '../../../../../core/presentation/components/gradient_text.dart';
import '../../../../../core/presentation/components/gradient_widget.dart';
import '../../../../../core/presentation/components/loading_spinner.dart';
import '../farm_dashboard_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isDashboardVisible = false;
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  final box = Hive.box('appData');

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

    //  observe connection
    userController.checkInternetConnection();
    getUserDetails(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Column(
        children: [
          const SizedBox(
            height: CustomSpacing.s2,
          ),
          Obx(
            () => userController.hasInternet.value
                ? Query(
                    options: QueryOptions(
                      document: gql(context.queries.getFarm()),
                      variables: {'farmId': controller.farm['id']},
                      fetchPolicy: FetchPolicy.noCache,
                      // pollInterval: const Duration(seconds: 2),
                    ),
                    builder: (QueryResult result,
                        {VoidCallback? refetch, FetchMore? fetchMore}) {
                      if (result.isLoading) {
                        return const Center(child: LoadingSpinner());
                      }

                      if (result.data == null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.setFarmCreatedStatus(isFarmCreated: false);
                        });
                        return const SizedBox.shrink();
                      }

                      if (result.hasException) {
                        return AppErrorWidget(
                          error: ErrorModel.fromString(
                            result.exception.toString(),
                          ),
                        );
                      }
                      final data = result.data?['getFarm'];

                      getFarmReports(context);
                      getFeeds(context);

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        controller.batchesList(data["batches"]);
                        // controller.reportsList(reports);
                        controller.setStoreItems(data["storeItems"]);
                      });

                      return Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                            child: Card(
                                elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "OVERVIEW",
                                        style: TextStyle(fontSize: 2.2.h),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Flexible(
                                      // height: 12.h,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: CustomSpacing.s1),
                                        child: GridView.count(
                                          crossAxisCount: 3,
                                          shrinkWrap: true,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "No of Birds",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 2.h),
                                                ),
                                                GradientText(
                                                  "${data["birdCount"] ?? 0}",
                                                  style: TextStyle(
                                                      color:
                                                          CustomColors.primary,
                                                      fontSize: 3.5.h,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  gradient: CustomColors
                                                      .primaryGradient,
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Eggs in Store",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 2.h),
                                                ),
                                                GradientText(
                                                  "${data["eggCount"] ?? 0}",
                                                  style: TextStyle(
                                                      color:
                                                          CustomColors.primary,
                                                      fontSize: 3.5.h,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  gradient: CustomColors
                                                      .primaryGradient,
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Feeds Used",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 2.h),
                                                ),
                                                GradientText(
                                                  "${data["feedsUsage"] ?? 0} Kgs",
                                                  style: TextStyle(
                                                      color:
                                                          CustomColors.primary,
                                                      fontSize: 3.5.h,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  softWrap: false,
                                                  gradient: CustomColors
                                                      .primaryGradient,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Card(
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("TODO TODAY",
                                        style: TextStyle(fontSize: 2.2.h)),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  GradientWidget(
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => const SelectBatchPage());
                                      },
                                      leading: const Icon(
                                        PhosphorIcons.plusCircleFill,
                                        color: CustomColors.background,
                                      ),
                                      title: Text(
                                        "Add a farm report",
                                        style: TextStyle(fontSize: 2.3.h),
                                      ),
                                      tileColor: Colors.transparent,
                                      textColor: CustomColors.background,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Card(
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("PREVIOUS REPORTS",
                                            style: TextStyle(fontSize: 2.2.h)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => const AllReportsPage());
                                        },
                                        child: Row(
                                          children: [
                                            Text('SEE ALL',
                                                style:
                                                    TextStyle(fontSize: 2.0.h)),
                                            const Icon(Icons.arrow_right)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 2.h,
                                  // ),
                                  Obx(
                                    () => controller.reportsList.isEmpty
                                        ? Card(
                                            elevation: 4,
                                            shadowColor: CustomColors.secondary,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w,
                                                  vertical: 1.5.h),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    PhosphorIcons.info,
                                                    size: 8.w,
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'What is a report?',
                                                        style: TextStyle(
                                                            fontSize: 4.w),
                                                      ),
                                                      Text(
                                                        'A general overview of the farm',
                                                        style: TextStyle(
                                                            fontSize: 3.w,
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller
                                                        .reportsList.length <
                                                    3
                                                ? controller.reportsList.length
                                                : 3,
                                            itemBuilder: ((context, index) {
                                              return ListTile(
                                                trailing: const Icon(
                                                  PhosphorIcons.arrowRightBold,
                                                  color: Colors.black,
                                                ),
                                                title: Text("Farm Report",
                                                    style: TextStyle(
                                                        fontSize: 1.9.h)),
                                                subtitle: Text(
                                                    "${controller.reportsList[index]["reportDate"]}"),
                                                onTap: () {
                                                  controller.selectedReport(
                                                      controller
                                                          .reportsList[index]);

                                                  Get.to(
                                                      () => ViewReportPage());
                                                },
                                                tileColor:
                                                    CustomColors.background,
                                                textColor: Colors.black,
                                              );
                                            })),
                                  )
                                ],
                              ))
                        ],
                      );
                    },
                  )
                : NoInternetScreen(onRefresh: () {
                    userController.checkInternetConnection();
                  }),
          ),
        ],
      ),
    );
  }

  Future<void> getFarmReports(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchReports = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "GetFarmReports",
        document: gql(context.queries.getFarmReports()),
        variables: {
          "filter": {"farmId": controller.farm['id']}
        }));

    List reports = [];

    for (var report in fetchReports.data!["farmReports"]) {
      reports.add(report);
    }

    controller.reportsList.value = reports;
  }

  Future<void> getFeeds(BuildContext context) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchFeeds = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "StoreItems",
        document: gql(context.queries.storeItems()),
        variables: {
          "filter": {"farmId": controller.farm['id']}
        }));

    // log("${}");

    List items = fetchFeeds.data!["storeItems"];

    List feedsList =
        items.where((element) => element['itemType'] == "FEED").toList();

    List<String> feeds = [];

    for (var element in feedsList) {
      feeds.add((element["name"] as String).toUpperCase());
    }

    log("$feeds");

    List kienyejiFeeds = feeds
        .where((feed) =>
            feed == 'CHICKEN_DUCK_MASH' || feed == 'KIENYEJI_GROWERS_MASH')
        .toList();

    List broilerFeeds = feeds
        .where((feed) => feed == 'FINISHER_PELLETS' || feed == 'STARTER_CRUMBS')
        .toList();

    List layerFeeds = feeds
        .where((feed) =>
            feed == 'CHICKEN_DUCK_MASH' ||
            feed == 'LAYERS_MASH' ||
            feed == 'GROWERS_MASH')
        .toList();

    controller.kienyejiFeed.value = kienyejiFeeds as List<String>;

    controller.broilerFeeds.value = broilerFeeds as List<String>;

    controller.layersFeeds.value = layerFeeds as List<String>;

    controller.feedList.value = feeds;
  }
}
