import 'dart:developer';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_spinner.dart';

class ViewReportPage extends StatelessWidget {
  ViewReportPage({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<FarmsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 8.h,
          backgroundColor: CustomColors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'FARM REPORT',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Query(
            options: QueryOptions(
                operationName: "GetFarmReport",
                document: gql(context.queries.getFarmReport()),
                variables: {
                  "farmId": controller.selectedReport["farmId"],
                  "reportDate": controller.selectedReport["reportDate"]
                }),
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

              final farmReport = result.data!["getFarmReport"];

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSpacing.s3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    const Text('OVERVIEW'),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Farm Name",
                                style: TextStyle(fontSize: 2.1.h),
                              ),
                              Text(controller.farm.value["name"],
                                  style: TextStyle(fontSize: 2.1.h))
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contractor",
                                style: TextStyle(fontSize: 2.1.h),
                              ),
                              Text("Chicken Basket",
                                  style: TextStyle(fontSize: 2.1.h))
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s1,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Farm Manager",
                          //       style: TextStyle(fontSize: 2.1.h),
                          //     ),
                          //     Text("John Otieno",
                          //         style: TextStyle(fontSize: 2.1.h))
                          //   ],
                          // ),
                          const SizedBox(
                            height: CustomSpacing.s1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(fontSize: 2.1.h),
                              ),
                              Text(farmReport["reportDate"],
                                  style: TextStyle(fontSize: 2.1.h))
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Time",
                                style: TextStyle(fontSize: 2.1.h),
                              ),
                              Text(farmReport["reportTime"],
                                  style: TextStyle(fontSize: 2.1.h))
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    farmReport["birdCounts"] != null &&
                            (farmReport["birdCounts"] as List).isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('BIRDS'),
                              const SizedBox(
                                height: CustomSpacing.s2,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: farmReport["birdCounts"].length,
                                itemBuilder: (context, index) => Card(
                                  color: Colors.white,
                                  elevation: 0.2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 3.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (farmReport["birdCounts"][index]
                                                      ["birdType"])
                                                  .toString()
                                                  .capitalize!,
                                              style: TextStyle(fontSize: 2.4.h),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text("Batch 1"),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                const Text("Batch 2")
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                (farmReport["birdCounts"][index]
                                                        ["currentQuantity"])
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 2.4.h)),
                                            Row(
                                              children: [
                                                const Text("0 New"),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              // Column(
                              //   children: [

                              //     Card(
                              //       color: Colors.white,
                              //       elevation: 0.2,
                              //       child: Padding(
                              //         padding: EdgeInsets.symmetric(
                              //             vertical: 2.h, horizontal: 3.w),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   "Layers",
                              //                   style: TextStyle(
                              //                       fontSize: 2.4.h),
                              //                 ),
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceEvenly,
                              //                   children: [
                              //                     const Text("Batch 1"),
                              //                     SizedBox(
                              //                       width: 1.w,
                              //                     ),
                              //                     const Text("Batch 2")
                              //                   ],
                              //                 )
                              //               ],
                              //             ),
                              //             Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text("1053",
                              //                     style: TextStyle(
                              //                         fontSize: 2.4.h)),
                              //                 Row(
                              //                   children: [
                              //                     const Text("0 New"),
                              //                     SizedBox(
                              //                       width: 1.w,
                              //                     ),
                              //                     const Text("7 Dead")
                              //                   ],
                              //                 )
                              //               ],
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    farmReport["feedsUsage"] != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('FEEDS'),
                              const SizedBox(
                                height: CustomSpacing.s2,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: (farmReport["feedsUsage"]).length,
                                itemBuilder: (context, index) => Card(
                                  color: Colors.white,
                                  elevation: 0.2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 3.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ((farmReport["feedsUsage"][index]
                                                          ["feedType"])
                                                      .replaceAll(
                                                          RegExp('[\\W_]+'),
                                                          ' '))
                                                  .toString()
                                                  .capitalize!,
                                              style: TextStyle(fontSize: 2.4.h),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text("Batch 1"),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                const Text("Batch 2")
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${(farmReport["feedsUsage"][index]["currentQuantity"]).toString()} Kgs",
                                                style:
                                                    TextStyle(fontSize: 2.4.h)),
                                            Row(
                                              children: [
                                                Text(
                                                  "${(farmReport["feedsUsage"][index]["usedQuantity"]).toString()} Kgs Used",
                                                  style: const TextStyle(
                                                      color: CustomColors.red),
                                                ),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    farmReport["eggCollection"] == null
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('EGGS'),
                              const SizedBox(
                                height: CustomSpacing.s2,
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                                child: Column(
                                  children: [
                                    Card(
                                      color: Colors.white,
                                      elevation: 0.2,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 3.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Good Eggs",
                                                  style: TextStyle(
                                                      fontSize: 2.4.h),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Text("Batch 1"),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    const Text("Batch 2")
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    (farmReport["eggCollection"]
                                                            ["goodCount"])
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 2.4.h)),
                                                Row(
                                                  children: [
                                                    Text(
                                                        "${(farmReport["eggCollection"]?["deformedCount"]).toString()} Deformed",
                                                        style: const TextStyle(
                                                            color: CustomColors
                                                                .red))
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                  ],
                ),
              );
            },
          ),
        ));
  }

  Future<void> getFarmReport(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchReport = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "GetFarmReport",
        document: gql(context.queries.getFarmReport()),
        variables: {
          "farmId": controller.selectedReport["farmId"],
          "reportDate": controller.selectedReport["reportDate"]
        }));

    controller.farmReport(fetchReport.data!['getFarmReport']);
  }
}
