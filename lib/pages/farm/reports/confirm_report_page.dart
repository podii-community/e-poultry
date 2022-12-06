import 'dart:developer';

import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/reports/briquettes-used.dart';
import 'package:epoultry/pages/farm/reports/broiler-weight.dart';
import 'package:epoultry/pages/farm/reports/eggs_collected_page.dart';
import 'package:epoultry/pages/farm/reports/number_birds_page.dart';
import 'package:epoultry/services/farm_service.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
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
  final UserController userController =
      Get.put(UserController(), permanent: true);
  final FarmsController controller =
      Get.put(FarmsController(), permanent: true);

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
            Get.back();
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
                      Get.to(() => NumberOfBirdsReportPage(
                            batchDetails: widget.batchDetails,
                          ));
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
              Column(
                children:
                    (controller.report["data"]!['birdCounts'] as List).map((e) {
                  String reason = e?['reason'];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        reason.toTitleCase!,
                        style: TextStyle(color: Colors.black, fontSize: 2.3.h),
                      ),
                      Text(
                        e['quantity'].toString(),
                        style: TextStyle(fontSize: 1.8.h, color: Colors.black),
                      )
                    ],
                  );
                }).toList(),
              ),

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
                                Get.to(() => EggsCollectedPage(
                                      batchDetails: widget.batchDetails,
                                    ));
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
                        Column(
                          children: (controller.report["data"]!['eggCollection']
                                  as Map)
                              .keys
                              .toSet()
                              .map((key) => (controller.report["data"]
                                          ?['eggCollection'] as Map)[key]
                                      .toString()
                                      .isEmpty
                                  ? const SizedBox.shrink()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${(key.split("C")[0] as String).capitalizeFirst} ${("C${key.split("C")[1]}").capitalizeFirst}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 2.3.h),
                                        ),
                                        Text(
                                          (controller.report["data"]![
                                                  'eggCollection'] as Map)[key]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 1.8.h,
                                              color: Colors.black),
                                        )
                                      ],
                                    ))
                              .toList(),
                        )
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
                                Get.to(() => BroilerWeight(
                                      batchDetails: widget.batchDetails,
                                    ));
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
                        Column(
                          children: (controller.report["data"]!['weightReport']
                                  as Map)
                              .keys
                              .map((key) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (key as String).toTitleCase!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2.3.h),
                                      ),
                                      Text(
                                        (controller.report["data"]![
                                                'weightReport'] as Map)[key]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.8.h,
                                            color: Colors.black),
                                      )
                                    ],
                                  ))
                              .toList(),
                        )
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
                          Get.to(() => BriquettesUsed(
                                batchDetails: widget.batchDetails,
                              ));
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
                  Column(
                    children: (controller.report["data"]!['briquettesReport']
                            as Map)
                        .keys
                        .map((key) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (key as String).toTitleCase!,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 2.3.h),
                                ),
                                Text(
                                  "${((controller.report["data"]!['briquettesReport'] as Map)[key]["quantity"].toString())}  Kgs",
                                  style: TextStyle(
                                      fontSize: 1.8.h, color: Colors.black),
                                )
                              ],
                            ))
                        .toList(),
                  )
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
                          Get.to(() => BriquettesUsed(
                                batchDetails: widget.batchDetails,
                              ));
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
                  Column(
                    children: (controller.report["data"]!['sawdustReport']
                            as Map)
                        .keys
                        .map((key) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (key as String).toTitleCase!,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 2.3.h),
                                ),
                                Text(
                                  "${((controller.report["data"]!['sawdustReport'] as Map)[key]["quantity"].toString())} Kgs ",
                                  style: TextStyle(
                                      fontSize: 1.8.h, color: Colors.black),
                                )
                              ],
                            ))
                        .toList(),
                  ),
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

                    if (result.hasException) {
                      context.showError(
                        ErrorModel.fromGraphError(
                          result.exception?.graphqlErrors ?? [],
                        ),
                      );
                    }
                  }

                  return GradientWidget(
                    child: ElevatedButton(
                        onPressed: () => _submitReport(context, runMutation),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: CustomColors.background,
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor:
                                Colors.transparent.withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.transparent.withOpacity(0.12),
                            shadowColor: Colors.transparent,
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
    final data = controller.report["data"] as Map;

    runMutation({
      "data": {
        "batchId": data["batchId"],
        "birdCounts": data["birdCounts"],
        "briquettesReport": data["briquettesReport"],
        "eggCollection": {
          "brokenCount": (data["eggCollection"]["brokenCount"]).value.isEmpty
              ? 0
              : int.parse((data["eggCollection"]["brokenCount"]).value),
          "eggCount": (data["eggCollection"]["eggCount"]).value.isEmpty
              ? 0
              : int.parse((data["eggCollection"]["eggCount"]).value),
          "largeCount": (data["eggCollection"]["largeCount"]).value.isEmpty
              ? 0
              : int.parse((data["eggCollection"]["largeCount"]).value),
          "smallCount": (data["eggCollection"]["smallCount"]).value.isEmpty
              ? 0
              : int.parse((data["eggCollection"]["smallCount"]).value),
          "deformedCount":
              (data["eggCollection"]["deformedCount"]).value.isEmpty
                  ? 0
                  : int.parse((data["eggCollection"]["deformedCount"]).value)
        },
        "feedsReport": data["feedsReport"],
        "medicationsReport": data["medicationsReport"],
        "reportDate": data["reportDate"],
        "sawdustReport": data["sawdustReport"],
        "weightReport": {
          "averageWeight": (data["weightReport"]["averageWeight"]).value.isEmpty
              ? 0.0
              : double.parse((data["weightReport"]["averageWeight"]).value)
        }
      }
    });
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if ((data['createBatchReport']['id'] != null)) {
      var report = {
        "farmId": data['createBatchReport']["batch"]["farm"]["id"],
        "reportDate": data['createBatchReport']["reportDate"],
      };

      bool addReport = controller.reportsList.value.where((p0) {
        return p0['reportDate'] == report['reportDate'];
      }).isEmpty;

      if (addReport) {
        controller.reportsList.value.add(report);
      }
      // controller.reportsList.value.addIf(condition, report)

      Get.to(() => const SuccessWidget(
            message: 'You have updated the report',
            route: 'dashboard',
          ));
    }
  }
}
