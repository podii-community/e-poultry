import 'dart:developer';

import 'package:epoultry/pages/farm/reports/all_reports_page.dart';
import 'package:epoultry/pages/farm/reports/select_batch_page.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/reports/view_report_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_text.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

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
          Query(
            options: QueryOptions(
              document: gql(context.queries.dashboardData()),
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

              final box = Hive.box('appData');

              if ((result.data?['user']!["managingFarms"]).isNotEmpty) {
                var data = result.data?['user']!["managingFarms"][0];
                box.put('farmId', data["id"]);
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
                                      "Feeds in Store",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 2.h),
                                    ),
                                    GradientText(
                                      "${data["eggCount"] ?? 0} Kgs",
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
              }

              if ((result.data?['user']!["ownedFarms"]).isNotEmpty) {
                var data = result.data?['user']!["ownedFarms"][0];
                box.put('farmId', data["id"]);
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
                                      "Feeds in Store",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 2.h),
                                    ),
                                    GradientText(
                                      "${data["eggCount"] ?? 0} Kgs",
                                      style: TextStyle(
                                          color: CustomColors.primary,
                                          fontSize: 3.5.h,
                                          fontWeight: FontWeight.w600),
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
              }

              return Container();
            },
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
                                builder: (context) => AllReportsPage()),
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
                  Query(
                      options: QueryOptions(
                        document: gql(context.queries.dashboardReports()),
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

                        if ((result.data?['user']!["managingFarms"])
                            .isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: (result.data!["user"]!["managingFarms"]
                                            [0]!["batches"][0]["reports"])
                                        .length <
                                    3
                                ? (result.data!["user"]!["managingFarms"]
                                        [0]!["batches"][0]["reports"])
                                    .length
                                : 3,
                            itemBuilder: (context, index) {
                              return ListTile(
                                trailing: const Icon(
                                  PhosphorIcons.arrowRightBold,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewReportPage(
                                              report: result.data!["user"]![
                                                          "managingFarms"]
                                                      [0]!["batches"][0]
                                                  ["reports"][index],
                                            )),
                                  );
                                },
                                title: Text("Farm Report",
                                    style: TextStyle(fontSize: 1.9.h)),
                                subtitle: Text(
                                    "${(result.data!["user"]!["managingFarms"][0]!["batches"][index]["reports"]).isNotEmpty ? (result.data!["user"]!["managingFarms"][0]!["batches"][index]["reports"][0]["reportDate"]) : ""}"),
                                tileColor: CustomColors.background,
                                textColor: Colors.black,
                              );
                            },
                          );
                        } else if ((result.data?['user']!["ownedFarms"])
                            .isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: (result.data!["user"]!["ownedFarms"]
                                            [0]!["batches"][0]["reports"])
                                        .length <
                                    3
                                ? (result.data!["user"]!["ownedFarms"]
                                        [0]!["batches"][0]["reports"])
                                    .length
                                : 3,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewReportPage(
                                              report: result.data!["user"]![
                                                          "ownedFarms"]
                                                      [0]!["batches"][0]
                                                  ["reports"][index],
                                            )),
                                  );
                                },
                                trailing: const Icon(
                                  PhosphorIcons.arrowRightBold,
                                  color: Colors.black,
                                ),
                                title: Text("Farm Report",
                                    style: TextStyle(fontSize: 1.9.h)),
                                subtitle: Text(
                                    "${(result.data!["user"]!["ownedFarms"][0]!["batches"][0]["reports"]).isNotEmpty ? (result.data!["user"]!["ownedFarms"][0]!["batches"][0]["reports"][0]["reportDate"]) : ""}"),
                                tileColor: CustomColors.background,
                                textColor: Colors.black,
                              );
                            },
                          );
                        }

                        return Container();
                      }),
                ],
              )),
        ],
      ),
    );
  }
}
