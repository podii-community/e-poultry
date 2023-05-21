// ignore_for_file: constant_identifier_names

import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/pages/farm/reports/broiler_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import 'eggs_collected_page.dart';

class NumberOfBirdsReportPage extends StatefulWidget {
  const NumberOfBirdsReportPage(
      {Key? key, required this.batchDetails, this.report})
      : super(key: key);

  final BatchModel batchDetails;
  // ignore: prefer_typing_uninitialized_variables
  final report;
  @override
  State<NumberOfBirdsReportPage> createState() =>
      _NumberOfBirdsReportPageState();
}

enum Reasons { SOLD, MORTALITY, CURLED, STOLEN }

class _NumberOfBirdsReportPageState extends State<NumberOfBirdsReportPage> {
  final _noOfBirdsFormKey = GlobalKey<FormBuilderState>();

  Reasons? reason;
  String birdsReduced = "";
  List<String> reasons = ["", 'Mortality', 'Sold'];
  List selectedReasons = [];
  final reduce = TextEditingController();
  final deadBirds = TextEditingController();
  final soldBirds = TextEditingController();
  final sellingPriceBird = TextEditingController();
  final curledBirds = TextEditingController();
  final stolenBirds = TextEditingController();

  final controller = Get.find<FarmsController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 8.h,
          backgroundColor: CustomColors.white,
          elevation: 0.5,
          centerTitle: true,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Update Number of Birds",
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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

                  FormBuilder(
                      key: _noOfBirdsFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderRadioGroup<String>(
                            decoration: InputDecoration(
                                labelText: 'Has the number of birds reduced?',
                                labelStyle: TextStyle(
                                    fontSize: 3.2.h, color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 4.w),
                                border: InputBorder.none),
                            name: 'birdsReduced',
                            onChanged: (value) {
                              setState(() {
                                birdsReduced = value!.toLowerCase().toString();
                              });
                            },
                            validator: FormBuilderValidators.required(
                                errorText: "Choose a choice above"),
                            options: [
                              'Yes',
                              'No',
                            ]
                                .map((choice) => FormBuilderFieldOption(
                                      value: choice,
                                      child: Text(
                                        choice,
                                        style: TextStyle(
                                            fontSize: 2.2.h,
                                            color: Colors.black),
                                      ),
                                    ))
                                .toList(growable: false),
                            controlAffinity: ControlAffinity.trailing,
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          birdsReduced == 'yes'
                              ? Column(
                                  children: [
                                    FormBuilderField(
                                      name: "reason",
                                      builder: (FormFieldState<dynamic> field) {
                                        return DropdownSearch<
                                            String>.multiSelection(
                                          dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                  hintText: "--select--",
                                                  labelText:
                                                      "Reasons for the decrease in number",
                                                  labelStyle: TextStyle(
                                                      fontSize: 2.2.h,
                                                      color: CustomColors
                                                          .secondary),
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
                                                                  .secondary)))),
                                          items: const [
                                            'Mortality',
                                            'Sold',
                                            'Curled',
                                            'Stolen'
                                          ],
                                          popupProps:
                                              const PopupPropsMultiSelection
                                                  .menu(
                                            showSelectedItems: true,
                                          ),
                                          onChanged: (val) {
                                            if (!val.contains("Mortality")) {
                                              deadBirds.clear();
                                            } else if (!val.contains("Sold")) {
                                              soldBirds.clear();
                                              sellingPriceBird.clear();
                                            } else if (!val
                                                .contains("Curled")) {
                                              curledBirds.clear();
                                            } else if (!val
                                                .contains("Stolen")) {
                                              stolenBirds.clear();
                                            }
                                            setState(() {
                                              selectedReasons = val;
                                            });
                                          },
                                          validator:
                                              FormBuilderValidators.required(),
                                          autoValidateMode:
                                              AutovalidateMode.always,
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: CustomSpacing.s3,
                                    ),
                                    selectedReasons.contains("Mortality")
                                        ? FormBuilderField(
                                            name: "deadBirds",
                                            builder: (FormFieldState field) {
                                              return TextFormField(
                                                controller: deadBirds,
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: FormBuilderValidators
                                                    .required(
                                                        errorText:
                                                            'Enter number of dead birds'),
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
                                                  labelText:
                                                      "How many birds died?",
                                                  labelStyle: TextStyle(
                                                      fontSize: 2.2.h,
                                                      color: CustomColors
                                                          .secondary),
                                                ),
                                              );
                                            })
                                        : Container(),
                                    const SizedBox(
                                      height: CustomSpacing.s3,
                                    ),
                                    selectedReasons.contains("Sold")
                                        ? FormBuilderField(
                                            builder: (FormFieldState field) {
                                              return TextFormField(
                                                controller: soldBirds,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Enter number of sold birds';
                                                  }
                                                  return null;
                                                },
                                                keyboardType:
                                                    TextInputType.number,
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
                                                  labelText:
                                                      "How many birds were sold?",
                                                  labelStyle: TextStyle(
                                                      fontSize: 2.2.h,
                                                      color: CustomColors
                                                          .secondary),
                                                ),
                                              );
                                            },
                                            name: "soldBirds")
                                        : Container(),
                                    const SizedBox(
                                      height: CustomSpacing.s3,
                                    ),
                                    selectedReasons.contains("Sold")
                                        ? FormBuilderField(
                                            builder: ((field) => TextFormField(
                                                  controller: sellingPriceBird,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter price per bird';
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    prefixText: "Ksh",
                                                    prefixStyle: TextStyle(
                                                        fontSize: 1.8.h),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                    labelText:
                                                        "What was the selling price per bird?",
                                                    labelStyle: TextStyle(
                                                        fontSize: 2.2.h,
                                                        color: CustomColors
                                                            .secondary),
                                                  ),
                                                )),
                                            name: "sellingPriceBird")
                                        : Container(),
                                    const SizedBox(
                                      height: CustomSpacing.s3,
                                    ),
                                    selectedReasons.contains("Curled")
                                        ? FormBuilderField(
                                            builder: ((field) => TextFormField(
                                                  controller: curledBirds,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter number of curled birds';
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                    labelText:
                                                        "How many birds were curled?",
                                                    labelStyle: TextStyle(
                                                        fontSize: 2.2.h,
                                                        color: CustomColors
                                                            .secondary),
                                                  ),
                                                )),
                                            name: "curledBirds")
                                        : Container(),
                                    const SizedBox(
                                      height: CustomSpacing.s3,
                                    ),
                                    selectedReasons.contains("Stolen")
                                        ? FormBuilderField(
                                            builder: ((field) => TextFormField(
                                                  controller: stolenBirds,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter number of stolen birds';
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                    labelText:
                                                        "How many birds were stolen?",
                                                    labelStyle: TextStyle(
                                                        fontSize: 2.2.h,
                                                        color: CustomColors
                                                            .secondary),
                                                  ),
                                                )),
                                            name: "stolenBirds")
                                        : Container(),
                                    const SizedBox(
                                      height: CustomSpacing.s3,
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      )),

                  // SizedBox(

                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          _noOfBirdsFormKey.currentState!.save();

                          var report = {
                            "data": {"birdCounts": [], "eggCollection": {}}
                          };
                          var payload = [
                            {
                              "quantity": deadBirds.text.isEmpty
                                  ? 0
                                  : int.parse(deadBirds.text),
                              "reason": "MORTALITY",
                              "sellingPrice": 0
                            },
                            {
                              "quantity": soldBirds.text.isEmpty
                                  ? 0
                                  : int.parse(soldBirds.text),
                              "reason": "SOLD",
                              "sellingPrice": sellingPriceBird.text.isEmpty
                                  ? 0
                                  : int.parse(sellingPriceBird.text)
                            },
                            {
                              "quantity": curledBirds.text.isEmpty
                                  ? 0
                                  : int.parse(curledBirds.text),
                              "reason": "CURLED",
                              "sellingPrice": 0
                            },
                            {
                              "quantity": stolenBirds.text.isEmpty
                                  ? 0
                                  : int.parse(stolenBirds.text),
                              "reason": "STOLEN",
                              "sellingPrice": 0
                            },
                          ];

                          controller.report["data"]!["birdCounts"] = payload;
                          controller.report["data"]!["batchId"] =
                              widget.batchDetails.id!;

                          if (_noOfBirdsFormKey.currentState!.validate()) {
                            widget.batchDetails.type!.name == "LAYERS"
                                ? Get.to(() => EggsCollectedPage(
                                      batchDetails: widget.batchDetails,
                                    ))
                                : Get.to(() => BroilerWeight(
                                      batchDetails: widget.batchDetails,
                                      report: report,
                                    ));
                          } else {
                            debugPrint("validation failed");
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
                          'SAVE & CONTINUE',
                          style: TextStyle(
                              fontSize: 4.w, fontWeight: FontWeight.w700),
                        )),
                  ),
                ],
              )),
        ));
  }
}
