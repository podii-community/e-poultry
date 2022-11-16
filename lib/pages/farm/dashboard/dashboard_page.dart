import 'package:epoultry/controllers/farm_controller.dart';
import 'package:epoultry/pages/farm/reports/all_reports_page.dart';
import 'package:epoultry/pages/farm/reports/select_batch_page.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/reports/view_report_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/user_controller.dart';
import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_text.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({
    Key? key,
  }) : super(key: key);

  final FarmsController controller = Get.put(FarmsController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
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
                variables: {'farmId': controller.farm.value['id']},
                fetchPolicy: FetchPolicy.noCache,
                pollInterval: const Duration(seconds: 2),
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
                // List reports = [];
                // for (var batch in data["batches"]) {
                //   reports.addAll(batch["reports"]);
                // }

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
                          Container(
                            height: 8.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: CustomSpacing.s1),
                            child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: 15.h,
                    child: ListView(
                      children: [
                        GradientWidget(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectBatchPage()),
                              );
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
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("PREVIOUS REPORTS",
                            style: TextStyle(fontSize: 2.2.h)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllReportsPage()),
                          );
                        },
                        child:
                            Text('SEE ALL', style: TextStyle(fontSize: 2.0.h)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
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
                                            fontSize: 3.w, color: Colors.grey),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewReportPage()),
                                  );
                                },
                                tileColor: CustomColors.background,
                                textColor: Colors.black,
                              );
                            })),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Future<void> getFarmReports(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchReports = await client.query(QueryOptions(
        operationName: "GetFarmReports",
        document: gql(context.queries.getFarmReports()),
        variables: {
          "filter": {"farmId": controller.farm.value['id']}
        }));

    List reports = [];
    // log("${fetchReports.data!["farmReports"]}");

    for (var report in fetchReports.data!["farmReports"]) {
      reports.add(report);
    }

    controller.reportsList(reports);
  }
}
