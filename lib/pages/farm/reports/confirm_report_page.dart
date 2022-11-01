import 'dart:convert';
import 'dart:developer';

import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/reports/briquettes-used.dart';
import 'package:epoultry/pages/farm/reports/broiler-weight.dart';
import 'package:epoultry/pages/farm/reports/eggs_collected_page.dart';
import 'package:epoultry/pages/farm/reports/number_birds_page.dart';
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
  const ConfirmReportPage({Key? key, this.report, required this.batchDetails})
      : super(key: key);

  final report;
  final BatchModel batchDetails;

  @override
  State<ConfirmReportPage> createState() => _ConfirmReportPageState();
}

class _ConfirmReportPageState extends State<ConfirmReportPage> {
  final UserController userController = Get.put(UserController());
  final FarmsController controller = Get.put(FarmsController());

  // List birdCounts = controller.report["data"]!['birdCounts'] as List;

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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Confirm",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Obx((() => Text(
                    controller.farm.value['name'],
                    style: TextStyle(color: Colors.black, fontSize: 3.h),
                  ))),
              const SizedBox(
                height: CustomSpacing.s1,
              ),
              Text(
                widget.batchDetails.name,
                style: TextStyle(fontSize: 2.1.h),
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BIRDS',
                    style: TextStyle(fontSize: 2.5.h),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NumberOfBirdsReportPage(
                                  batchDetails: widget.batchDetails,
                                )),
                      );
                    },
                    child: Wrap(
                      children: [
                        const Icon(
                          PhosphorIcons.pencilFill,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 2.h,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemExtent: 4.5.h,
                  itemCount:
                      (controller.report["data"]!['birdCounts'] as List).length,
                  itemBuilder: (context, index) {
                    String reason = (controller.report["data"]!['birdCounts']
                        as List)[index]?['reason'];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reason.toTitleCase!,
                          style:
                              TextStyle(color: Colors.black, fontSize: 2.3.h),
                        ),
                        Text(
                          (controller.report["data"]!['birdCounts']
                                  as List)[index]['quantity']
                              .toString(),
                          style:
                              TextStyle(fontSize: 1.8.h, color: Colors.black),
                        )
                      ],
                    );
                  }),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              widget.batchDetails.type!.name == "LAYERS"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'EGGS',
                              style: TextStyle(fontSize: 2.5.h),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EggsCollectedPage(
                                            batchDetails: widget.batchDetails,
                                          )),
                                );
                              },
                              child: Wrap(
                                children: [
                                  const Icon(
                                    PhosphorIcons.pencilFill,
                                  ),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 2.h,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemExtent: 4.5.h,
                            itemCount: (controller
                                    .report["data"]!['eggCollection'] as Map)
                                .length,
                            itemBuilder: (context, index) {
                              String key = (controller
                                      .report["data"]!['eggCollection'] as Map)
                                  .keys
                                  .elementAt(index);

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    key.toTitleCase!,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 2.3.h),
                                  ),
                                  Text(
                                    (controller.report["data"]!['eggCollection']
                                            as Map)[key]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 1.8.h, color: Colors.black),
                                  )
                                ],
                              );
                            }),
                      ],
                    )
                  : Container(),
              widget.batchDetails.type!.name == "BROILERS"
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'WEIGHT',
                              style: TextStyle(fontSize: 2.5.h),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BroilerWeight(
                                            batchDetails: widget.batchDetails,
                                          )),
                                );
                              },
                              child: Wrap(
                                children: [
                                  const Icon(
                                    PhosphorIcons.pencilFill,
                                  ),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 2.h,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemExtent: 4.5.h,
                            itemCount: (controller
                                    .report["data"]!['weightReport'] as Map)
                                .length,
                            itemBuilder: (context, index) {
                              String key = (controller
                                      .report["data"]!['weightReport'] as Map)
                                  .keys
                                  .elementAt(index);

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    key.toTitleCase!,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 2.3.h),
                                  ),
                                  Text(
                                    (controller.report["data"]!['weightReport']
                                            as Map)[key]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 1.8.h, color: Colors.black),
                                  )
                                ],
                              );
                            }),
                      ],
                    )
                  : Container(),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BRIQUETTES',
                        style: TextStyle(fontSize: 2.5.h),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BriquettesUsed(
                                      batchDetails: widget.batchDetails,
                                    )),
                          );
                        },
                        child: Wrap(
                          children: [
                            const Icon(
                              PhosphorIcons.pencilFill,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 2.h,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 4.5.h,
                      itemCount: (controller.report["data"]!['briquettesReport']
                              as Map)
                          .length,
                      itemBuilder: (context, index) {
                        String key = (controller
                                .report["data"]!['briquettesReport'] as Map)
                            .keys
                            .elementAt(index);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key.toTitleCase!,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 2.3.h),
                            ),
                            Text(
                              "${((controller.report["data"]!['briquettesReport'] as Map)[key]["quantity"].toString())}  Kgs",
                              style: TextStyle(
                                  fontSize: 1.8.h, color: Colors.black),
                            )
                          ],
                        );
                      }),
                ],
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SAWDUST',
                        style: TextStyle(fontSize: 2.5.h),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BriquettesUsed(
                                      batchDetails: widget.batchDetails,
                                    )),
                          );
                        },
                        child: Wrap(
                          children: [
                            const Icon(
                              PhosphorIcons.pencilFill,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 2.h,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 4.5.h,
                      itemCount:
                          (controller.report["data"]!['sawdustReport'] as Map)
                              .length,
                      itemBuilder: (context, index) {
                        String key =
                            (controller.report["data"]!['sawdustReport'] as Map)
                                .keys
                                .elementAt(index);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key.toTitleCase!,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 2.3.h),
                            ),
                            Text(
                              "${((controller.report["data"]!['sawdustReport'] as Map)[key]["quantity"].toString())} Kgs ",
                              style: TextStyle(
                                  fontSize: 1.8.h, color: Colors.black),
                            )
                          ],
                        );
                      }),
                ],
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              // ignore: lines_longer_than_80_chars
              Text(
                "Report prepared by ${userController.userName.value} on  ${DateFormat('yyyy-MM-dd').format(DateTime.now())}  at  ${DateFormat.jm().format(DateTime.now())}",
                style: TextStyle(fontSize: 2.2.h),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              const SizedBox(
                height: CustomSpacing.s3,
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
                height: CustomSpacing.s3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitReport(
      BuildContext context, RunMutation runMutation) async {
    // log("${{...controller.report}}");

    final data = controller.report["data"] as Map;

    // jsonEncode({...controller.report});
    runMutation({
      "data": {
        "batchId": data["batchId"],
        "birdCounts": data["birdCounts"],
        "briquettesReport": data["briquettesReport"],
        "eggCollection": {
          "brokenCount":
              int.parse((data["eggCollection"]["brokenCount"]).toString()),
          "eggCount": int.parse((data["eggCollection"]["eggCount"]).toString()),
          "largeCount":
              int.parse((data["eggCollection"]["largeCount"]).toString()),
          "smallCount":
              int.parse((data["eggCollection"]["smallCount"]).toString()),
          "deformedCount":
              int.parse((data["eggCollection"]["deformedCount"]).toString())
        },
        "feedsReport": data["feedsReport"],
        "medicationsReport": data["medicationsReport"],
        "reportDate": "2022-11-01",
        "sawdustReport": data["sawdustReport"],
        "weightReport": {
          "averageWeight":
              (data["weightReport"]["averageWeight"]).toString().toDouble()
        }
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
