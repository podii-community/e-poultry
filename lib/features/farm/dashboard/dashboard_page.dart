import 'dart:developer';

import 'package:epoultry/core/controllers/farm_controller.dart';
import 'package:epoultry/features/farm/reports/all_reports_page.dart';
import 'package:epoultry/features/farm/reports/select_batch_page.dart';
import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:epoultry/features/farm/reports/view_report_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/controllers/user_controller.dart';
import '../../../core/data/models/error.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/gradient_text.dart';
import '../../../core/widgets/gradient_widget.dart';
import '../../../core/widgets/loading_spinner.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Column(
        children: [
          const SizedBox(
            height: CustomSpacing.s2,
          ),
          Obx(
            () => Query(
              options: QueryOptions(
                document: gql(context.queries.getFarm()),
                variables: {'farmId': controller.farm['id']},
                fetchPolicy: FetchPolicy.noCache,
                // pollInterval: const Duration(seconds: 2),
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

                final data = result.data?['getFarm'];

                getFarmReports(context);
                getFeeds(context);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.batchesList(data["batches"]);
                  // controller.reportsList(reports);
                  controller.setStoreItems(data["storeItems"]);
                });

                return SizedBox(
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
                                            color: Colors.black, fontSize: 2.h),
                                      ),
                                      GradientText(
                                        "${data["birdCount"] ?? 0}",
                                        style: TextStyle(
                                            color: CustomColors.primary,
                                            fontSize: 3.5.h,
                                            fontWeight: FontWeight.w600),
                                        gradient: CustomColors.primaryGradient,
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
                                            color: Colors.black, fontSize: 2.h),
                                      ),
                                      GradientText(
                                        "${data["eggCount"] ?? 0}",
                                        style: TextStyle(
                                            color: CustomColors.primary,
                                            fontSize: 3.5.h,
                                            fontWeight: FontWeight.w600),
                                        gradient: CustomColors.primaryGradient,
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
                                            color: Colors.black, fontSize: 2.h),
                                      ),
                                      GradientText(
                                        "${data["feedsUsage"] ?? 0} Kgs",
                                        style: TextStyle(
                                            color: CustomColors.primary,
                                            fontSize: 3.5.h,
                                            fontWeight: FontWeight.w600),
                                        softWrap: false,
                                        gradient: CustomColors.primaryGradient,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            ),
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
                    child:
                        Text("TODO TODAY", style: TextStyle(fontSize: 2.2.h)),
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
          Expanded(
            child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  style: TextStyle(fontSize: 2.0.h)),
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
                                    horizontal: 4.w, vertical: 1.5.h),
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
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'What is a report?',
                                          style: TextStyle(fontSize: 4.w),
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
                              itemCount: controller.reportsList.length < 3
                                  ? controller.reportsList.length
                                  : 3,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  trailing: const Icon(
                                    PhosphorIcons.arrowRightBold,
                                    color: Colors.black,
                                  ),
                                  title: Text("Farm Report",
                                      style: TextStyle(fontSize: 1.9.h)),
                                  subtitle: Text(
                                      "${controller.reportsList[index]["reportDate"]}"),
                                  onTap: () {
                                    controller.selectedReport(
                                        controller.reportsList[index]);

                                    Get.to(() => ViewReportPage());
                                  },
                                  tileColor: CustomColors.background,
                                  textColor: Colors.black,
                                );
                              })),
                    )
                  ],
                )),
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
