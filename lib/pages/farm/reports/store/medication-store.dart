import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../../data/models/batch_model.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/spacing.dart';
import '../../../../widgets/gradient_widget.dart';

class MedicationStore extends StatefulWidget {
  const MedicationStore(
      {Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<MedicationStore> createState() => _MedicationStoreState();
}

class _MedicationStoreState extends State<MedicationStore> {
  final medicationName = TextEditingController();
  final quantityUsed = TextEditingController();

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
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.batchDetails.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Update medication in store",
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
                                shrinkWrap: true,
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
                                            fontSize: 3.5.h,
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
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 3.5.h,
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
                  SizedBox(
                    height: 50.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        TextFormField(
                          controller: medicationName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name of medication';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixStyle: TextStyle(fontSize: 1.8.h),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            labelText: "Name of medication",
                            labelStyle: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary),
                          ),
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        TextFormField(
                          controller: quantityUsed,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Quantity';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: 'L',
                            prefixStyle: TextStyle(fontSize: 1.8.h),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            labelText: "Quantity",
                            labelStyle: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary),
                          ),
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          DateTime now = DateTime.now();
                          DateTime date =
                              DateTime(now.year, now.month, now.day);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            onSurface: Colors.transparent,
                            shadowColor: Colors.transparent,
                            onPrimary: CustomColors.background,
                            fixedSize: Size(100.w, 6.h)),
                        child: Text(
                          'UPDATE MEDICATION',
                          style: TextStyle(
                              fontSize: 4.w, fontWeight: FontWeight.w700),
                        )),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
