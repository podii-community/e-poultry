import 'dart:developer';

import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../controllers/farm_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../theme/colors.dart';
import '../../../widgets/loading_spinner.dart';
import '../../../widgets/success_widget.dart';

class ConfirmReportPage extends StatefulWidget {
  const ConfirmReportPage(
      {Key? key, required this.report, required this.batchDetails})
      : super(key: key);

  final report;
  final BatchModel batchDetails;

  @override
  State<ConfirmReportPage> createState() => _ConfirmReportPageState();
}

class _ConfirmReportPageState extends State<ConfirmReportPage> {
  final UserController userController = Get.put(UserController());
  final FarmsController controller = Get.put(FarmsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.background,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "CONFIRM REPORT",
          style: TextStyle(color: Colors.black, fontSize: 2.3.h),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Farm Name",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Obx((() => Text(
                            controller.farm.value['name'],
                            style: const TextStyle(color: Colors.black),
                          )))
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Farm Manager",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        userController.userName.value,
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Batch Name",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        widget.batchDetails.name,
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        style: TextStyle(fontSize: 2.1.h),
                      )
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
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        DateFormat.jm().format(DateTime.now()),
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: CustomSpacing.s1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Summary",
                style: TextStyle(fontSize: 2.5.h),
              ),
            ),
            SizedBox(
              height: 50.h,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.9,
                shrinkWrap: true,
                children: [
                  Card(
                    elevation: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Palette.kPrimary[200]!,
                        Palette.kSecondary[100]!
                      ])),
                      padding: const EdgeInsets.all(CustomSpacing.s2),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bird Count",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  widget.report!["data"]['birdCounts']!.length,
                              itemBuilder: (context, index) {
                                String reason = widget.report!["data"]
                                    ['birdCounts'][index]?['reason'];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      reason.toTitleCase!,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      widget.report!["data"]['birdCounts']
                                              [index]['quantity']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    )
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Palette.kPrimary[200]!,
                        Palette.kSecondary[100]!
                      ])),
                      padding: const EdgeInsets.all(CustomSpacing.s2),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Feeds",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget
                                  .report!["data"]['feedsUsageReports'].length,
                              itemBuilder: (context, index) {
                                String feedType = widget.report!["data"]
                                    ['feedsUsageReports']![index]!['feedType']!;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      feedType.toTitleCase!,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.4.h),
                                    ),
                                    Text(
                                      widget.report!["data"]
                                              ['feedsUsageReports'][index]
                                              ['quantity']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    )
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                  widget.report!["data"]['eggCollection'] != null &&
                          widget.batchDetails.type!.name == "LAYERS"
                      ? Card(
                          elevation: 0.4,
                          child: Container(
                            padding: const EdgeInsets.all(CustomSpacing.s2),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Palette.kPrimary[200]!,
                              Palette.kSecondary[100]!
                            ])),
                            child: ListView(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Eggs",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 2.h),
                                    ),
                                    Text(
                                      '+${widget.report!["data"]['eggCollection']["eggCount"]}',
                                      style: TextStyle(
                                          fontSize: 2.h,
                                          color: CustomColors.green),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: CustomSpacing.s2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Large",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      '${widget.report!["data"]['eggCollection']["largeCount"]}',
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: CustomSpacing.s1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Small",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      '${widget.report!["data"]['eggCollection']["smallCount"]}',
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: CustomSpacing.s1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Deformed",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      '${widget.report!["data"]['eggCollection']["deformedCount"]}',
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: CustomSpacing.s1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Broken",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      '${widget.report!["data"]['eggCollection']["brokenCount"]}',
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Mutation(
              options: MutationOptions(
                document: gql(context.queries.createBatchReport()),
                onCompleted: (data) => _onCompleted(data, context),
              ),
              builder: (RunMutation runMutation, QueryResult? result) {
                if (result != null) {
                  if (result.isLoading) {
                    return const LoadingSpinner();
                  }

                  log("DDEE$result");

                  if (result.hasException) {
                    Fluttertoast.showToast(
                        msg: "The report has already been submitted");
                  }
                }

                return GradientWidget(
                  child: ElevatedButton(
                      onPressed: () => _submitReport(context, runMutation),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent,
                          onPrimary: CustomColors.background,
                          fixedSize: Size(100.w, 6.h)),
                      child: const Text('SEND UPDATE')),
                );
              },
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReport(
      BuildContext context, RunMutation runMutation) async {
    runMutation({
      "data": {
        'batchId': widget.report["data"]["batchId"],
        "birdCounts": widget.report["data"]["birdCounts"],
        "feedsUsageReports": widget.report["data"]["feedsUsageReports"],
        "eggCollection": widget.report["data"]["eggCollection"],
        "reportDate": DateFormat('yyyy-MM-dd').format(DateTime.now())
      }
    });
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if ((data['createBatchReport']['id'] != null)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SuccessWidget(
                    message: 'You have updated the report',
                    route: 'dashboard',
                  )));
    }
  }
}
