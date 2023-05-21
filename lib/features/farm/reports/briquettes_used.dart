import 'package:epoultry/features/farm/reports/confirm_report_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../core/controllers/farm_controller.dart';
import '../../../core/data/models/batch_model.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/gradient_widget.dart';

class BriquettesUsed extends StatefulWidget {
  const BriquettesUsed({Key? key, required this.batchDetails, this.report})
      : super(key: key);

  final BatchModel batchDetails;
  // ignore: prefer_typing_uninitialized_variables
  final report;

  @override
  State<BriquettesUsed> createState() => _BriquettesUsedState();
}

class _BriquettesUsedState extends State<BriquettesUsed> {
  String briquettesReceived = "";
  final _formKey = GlobalKey<FormState>();
  final briquettesUsedAmount = TextEditingController();
  final briquettesStoreAmount = TextEditingController();
  final briquettesReceivedAmount = TextEditingController();

  final controller = Get.find<FarmsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            widget.batchDetails.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Briquettes",
                        style: TextStyle(fontSize: 3.h),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                      child: Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: CustomSpacing.s2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: CustomSpacing.s2),
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: CustomSpacing.s1,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Type of Birds",
                                          style: TextStyle(
                                              color: CustomColors.secondary,
                                              fontSize: 2.h),
                                        ),
                                        Text(
                                          (widget.batchDetails.type!.name)
                                              .capitalize!,
                                          style: TextStyle(
                                              color: CustomColors.secondary,
                                              fontSize: 2.8.h,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "No of Birds",
                                          style: TextStyle(
                                              color: CustomColors.secondary,
                                              fontSize: 2.h),
                                        ),
                                        Text(
                                          "${widget.batchDetails.birdCount}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: CustomColors.secondary,
                                              fontSize: 2.8.h,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update briquettes used?",
                          style: TextStyle(
                            fontSize: 2.2.h,
                          ),
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        TextFormField(
                          controller: briquettesUsedAmount,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter amount';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            labelText: "Briquettes used",
                            suffixText: 'Kgs',
                            labelStyle: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary),
                          ),
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        controller.storeItems.isEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Update briquettes in store?",
                                    style: TextStyle(
                                      fontSize: 2.2.h,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: CustomSpacing.s3,
                                  ),
                                  TextFormField(
                                    controller: briquettesStoreAmount,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter amount';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.3.w,
                                              color: CustomColors.secondary)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.3.w,
                                              color: CustomColors.secondary)),
                                      labelText: "Briquettes in store",
                                      suffixText: 'Kgs',
                                      labelStyle: TextStyle(
                                          fontSize: 2.2.h,
                                          color: CustomColors.secondary),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        controller.storeItems.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Have you received briquettes today",
                                    style: TextStyle(
                                      fontSize: 2.2.h,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: CustomSpacing.s1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40.w,
                                        child: ListTile(
                                          title: const Text('Yes'),
                                          leading: Radio<String>(
                                            value: "yes",
                                            groupValue: briquettesReceived,
                                            onChanged: (value) {
                                              setState(() {
                                                briquettesReceived =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                        child: ListTile(
                                          title: const Text('No'),
                                          leading: Radio<String>(
                                            value: "no",
                                            groupValue: briquettesReceived,
                                            onChanged: (value) {
                                              setState(() {
                                                briquettesReceived =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: CustomSpacing.s3,
                                  ),
                                  briquettesReceived == 'yes'
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Update briquettes received?",
                                              style: TextStyle(
                                                fontSize: 2.2.h,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: CustomSpacing.s2,
                                            ),
                                            TextFormField(
                                              controller:
                                                  briquettesReceivedAmount,
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter quantity';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 0.3.w,
                                                        color: CustomColors
                                                            .secondary)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                labelStyle: TextStyle(
                                                    fontSize: 2.2.h,
                                                    color:
                                                        CustomColors.secondary),
                                                suffixText: 'Kgs',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: CustomSpacing.s3,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              )
                            : Container(),
                      ],
                    ),

                    // SizedBox(

                    GradientWidget(
                      child: ElevatedButton(
                          onPressed: () {
                            (controller.report["data"]!["briquettesReport"]
                                as Map)["inStore"]({
                              "quantity": briquettesStoreAmount.text.isEmpty
                                  ? 0.0
                                  : briquettesStoreAmount.text.toDouble()
                            });
                            (controller.report["data"]!["briquettesReport"]
                                as Map)["received"]({
                              "quantity": briquettesReceivedAmount.text.isEmpty
                                  ? 0.0
                                  : briquettesReceivedAmount.text.toDouble()
                            });
                            (controller.report["data"]!["briquettesReport"]
                                as Map)["used"]({
                              "quantity": briquettesUsedAmount.text.isEmpty
                                  ? 0.0
                                  : briquettesUsedAmount.text.toDouble()
                            });

                            controller.report["data"]!["reportDate"] =
                                DateFormat('yyyy-MM-dd').format(DateTime.now());

                            if (_formKey.currentState!.validate()) {
                              Get.to(() => ConfirmReportPage(
                                    batchDetails: widget.batchDetails,
                                  ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: CustomColors.background,
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor:
                                  Colors.transparent.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
                              fixedSize: Size(100.w, 6.h)),
                          child: Text(
                            'UPDATE BRIQUETTES',
                            style: TextStyle(
                                fontSize: 4.w, fontWeight: FontWeight.w700),
                          )),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s1,
                    ),
                  ],
                ),
              )),
        ));
  }
}
