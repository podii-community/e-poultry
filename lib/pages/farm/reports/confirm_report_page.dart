import 'dart:developer';

import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

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
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('appData');
    final name = box.get('name');
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
                      Text(
                        '${name} Farm',
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
                        "Contractor ",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        'Chicken Basket',
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
                        "Farm Manager",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        name,
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
                        '${widget.report!["data"]['reportDate']}',
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
                        '12:00 PM',
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
                          gradient: LinearGradient(
                              colors: [
                            Palette.kPrimary[200]!,
                            Palette.kSecondary[100]!
                          ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
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
                                  widget.report!["data"]['birdCounts'].length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.report!["data"]['birdCounts']
                                          [index]?['reason'],
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
                          gradient: LinearGradient(
                              colors: [
                            Palette.kPrimary[200]!,
                            Palette.kSecondary[100]!
                          ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
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
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.report!["data"]
                                              ['feedsUsageReports'][index]
                                          ['feedType'],
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
                  widget.report!["data"]['eggCollection'] != null
                      ? Card(
                          elevation: 0.4,
                          child: Container(
                            padding: const EdgeInsets.all(CustomSpacing.s2),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Palette.kPrimary[200]!,
                                  Palette.kSecondary[100]!
                                ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight)),
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
                                      '+${widget.batchDetails.type!.name == "LAYERS" ? widget.report!["data"]['eggCollection']["eggCount"] : 0}',
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
                                      '${widget.batchDetails.type!.name == "LAYERS" ? widget.report!["data"]['eggCollection']["largeCount"] : 0}',
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
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
                                      "Small",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      '${widget.batchDetails.type!.name == "LAYERS" ? widget.report!["data"]['eggCollection']["smallCount"] : 0}',
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
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
                                      "Deformed",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      '${widget.batchDetails.type!.name == "LAYERS" ? widget.report!["data"]['eggCollection']["deformedCount"] : 0}',
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
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
                                      "Broken",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      '${widget.batchDetails.type!.name == "LAYERS" ? widget.report!["data"]['eggCollection']["brokenCount"] : 0}',
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
        "reportDate": widget.report["data"]["reportDate"]
      }
    });
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    /// If they do, move to home page. If not, take them to select artist page for them to select artists.
    ///
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
