
import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/pages/farm/reports/number_birds_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/farm_controller.dart';
import '../../../../data/models/batch_model.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/spacing.dart';
import '../../../../widgets/gradient_widget.dart';

class MedicationStore extends StatefulWidget {
  const MedicationStore({Key? key, required this.batchDetails, this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<MedicationStore> createState() => _MedicationStoreState();
}

class _MedicationStoreState extends State<MedicationStore> {
  final _formKey = GlobalKey<FormState>();
  var typeOfMedication = [
    "New Castle",
    "Gumboro",
  ];
  List _selectedMedication = [];
  final medicationName = TextEditingController();
  final newCastleStore = TextEditingController();
  final gumboroStore = TextEditingController();

  final FarmsController controller = Get.put(FarmsController());

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
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
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
                          DropdownSearch<String>.multiSelection(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: "--select--",
                                    labelText:
                                        "What medication do you have in store?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.0.h,
                                        color: CustomColors.secondary),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)))),
                            items: typeOfMedication,
                            popupProps: const PopupPropsMultiSelection.menu(
                              showSelectedItems: true,
                            ),
                            onChanged: (val) {
                              setState(() {
                                _selectedMedication = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          _selectedMedication.contains("New Castle")
                              ? TextFormField(
                                  controller: newCastleStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount';
                                    }
                                    return null;
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
                                    labelText:
                                        "What quantity is in store(Newcastle)",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          _selectedMedication.contains("Gumboro")
                              ? TextFormField(
                                  controller: gumboroStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount';
                                    }
                                    return null;
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
                                    labelText:
                                        "What quantity is in store(Gumboro)",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
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
                            var medicationStoreReports = [
                              {
                                "name": "Newcastle",
                                "quantity": newCastleStore.text.isEmpty
                                    ? 0
                                    : int.parse(newCastleStore.text)
                              },
                              {
                                "name": "Gumboro",
                                "quantity": gumboroStore.text.isEmpty
                                    ? 0
                                    : int.parse(gumboroStore.text)
                              },
                            ];

                            (controller.report["data"]!["medicationsReport"]
                                as Map)["inStore"](medicationStoreReports);
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NumberOfBirdsReportPage(
                                          batchDetails: widget.batchDetails,
                                        )),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: CustomColors.background, backgroundColor: Colors.transparent,
                              disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
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
          ),
        ));
  }
}
