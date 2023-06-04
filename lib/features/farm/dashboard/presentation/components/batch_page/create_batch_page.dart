// ignore_for_file: constant_identifier_names

import 'package:epoultry/core/data/data_export.dart';
import 'package:epoultry/features/farm/dashboard/presentation/components/batch_page/confirm_batch_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/presentation/controllers/farm_controller.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/presentation/components/gradient_widget.dart';

class CreateBatchPage extends StatefulWidget {
  const CreateBatchPage({Key? key}) : super(key: key);

  @override
  State<CreateBatchPage> createState() => _CreateBatchPageState();
}

enum AgeTypes { DAYS, WEEKS, MONTHS }

enum BirdTypes { BROILERS, LAYERS, KIENYEJI }

class _CreateBatchPageState extends State<CreateBatchPage> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final number = TextEditingController();
  final age = TextEditingController();
  final day = TextEditingController();
  final year = TextEditingController();
  final box = Hive.box('appData');
  final controller = Get.find<FarmsController>();

  var months = [
    "",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  BirdTypes? birdType;

  AgeTypes? ageType;

  String initialMonth = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColors.background,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create a New Batch",
                  style: TextStyle(fontSize: 3.h),
                ),
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: "Batch Name",
                            labelStyle: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary))),
                      ),
                      const SizedBox(
                        height: CustomSpacing.s3,
                      ),
                      GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          mainAxisSpacing: CustomSpacing.s3,
                          crossAxisSpacing: CustomSpacing.s2,
                        ),
                        children: [
                          DropdownButtonFormField<BirdTypes>(
                            // Initial Value
                            key: UniqueKey(),
                            value: birdType,
                            isExpanded: true,
                            elevation: 0,
                            decoration: InputDecoration(
                                hintText: "--select--",
                                labelText: "Type of Birds",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),

                            onChanged: (val) {
                              setState(() {
                                birdType = val;
                              });
                            },
                            items: BirdTypes.values.map((BirdTypes birdType) {
                              return DropdownMenuItem<BirdTypes>(
                                value: birdType,
                                child: Text(birdType.name.toString()),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            controller: number,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Number of Birds",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          TextFormField(
                            controller: age,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Age",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          DropdownButtonFormField<AgeTypes>(
                            // Initial Value
                            key: UniqueKey(),
                            value: ageType,
                            isExpanded: true,
                            elevation: 0,
                            decoration: InputDecoration(
                                hintText: "--select--",
                                labelText: "Days/Weeks/Months",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),

                            onChanged: (val) {
                              setState(() {
                                ageType = val;
                              });
                            },
                            items: AgeTypes.values.map((AgeTypes ageType) {
                              return DropdownMenuItem<AgeTypes>(
                                value: ageType,
                                child: Text(ageType.name.toString()),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  )),
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      final index = months.indexOf(initialMonth);
                      String s = index.toString().padLeft(2, '0');
                      BatchModel newBatch = BatchModel(
                          name: name.text,
                          type: birdType!,
                          birdAge: int.parse(age.text),
                          birdCount: int.parse(number.text),
                          ageType: ageType!,
                          date: ("${day.text}-$s-${year.text}"),
                          farmId: controller.farm['id']);

                      Get.to(() => ConfirmBatchPage(
                            newBatch: newBatch,
                          ));
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
                    child: const Text('CREATE BATCH')),
              ),
            ])));
  }
}
