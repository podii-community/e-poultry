import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/pages/farm/reports/feeds_used_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import 'eggs_collected_page.dart';

class NumberOfBirdsReportPage extends StatefulWidget {
  const NumberOfBirdsReportPage({Key? key, required this.batchDetails})
      : super(key: key);

  final BatchModel batchDetails;
  @override
  State<NumberOfBirdsReportPage> createState() =>
      _NumberOfBirdsReportPageState();
}

enum Reasons { SOLD, MORTALITY, CURLED, STOLEN }

class _NumberOfBirdsReportPageState extends State<NumberOfBirdsReportPage> {
  final _formKey = GlobalKey<FormState>();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
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

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Has the number of birds reduced?",
                        style: TextStyle(
                          fontSize: 2.2.h,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: ListTile(
                              title: const Text('Yes'),
                              leading: Radio<String>(
                                value: "yes",
                                groupValue: birdsReduced,
                                onChanged: (value) {
                                  setState(() {
                                    birdsReduced = value.toString();
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
                                groupValue: birdsReduced,
                                onChanged: (value) {
                                  setState(() {
                                    birdsReduced = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  birdsReduced == 'yes'
                      ? Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              DropdownSearch<String>.multiSelection(
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        hintText: "--select--",
                                        labelText:
                                            "Reasons for the decrease in number",
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
                                                color:
                                                    CustomColors.secondary)))),
                                items: const [
                                  'Mortality',
                                  'Sold',
                                  'Curled',
                                  'Stolen'
                                ],
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSelectedItems: true,
                                ),
                                onChanged: (val) {
                                  if (!val.contains("Mortality")) {
                                    deadBirds.clear();
                                  } else if (!val.contains("Sold")) {
                                    soldBirds.clear();
                                    sellingPriceBird.clear();
                                  } else if (!val.contains("Curled")) {
                                    curledBirds.clear();
                                  } else if (!val.contains("Stolen")) {
                                    stolenBirds.clear();
                                  }
                                  setState(() {
                                    selectedReasons = val;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: CustomSpacing.s3,
                              ),
                              selectedReasons.contains("Mortality")
                                  ? TextFormField(
                                      controller: deadBirds,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter number of dead birds';
                                        }
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
                                        labelText: "How many birds died?",
                                        labelStyle: TextStyle(
                                            fontSize: 2.2.h,
                                            color: CustomColors.secondary),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: CustomSpacing.s3,
                              ),
                              selectedReasons.contains("Sold")
                                  ? TextFormField(
                                      controller: soldBirds,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter number of sold birds';
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.3.w,
                                                color: CustomColors.secondary)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.3.w,
                                                color: CustomColors.secondary)),
                                        labelText: "How many birds were sold?",
                                        labelStyle: TextStyle(
                                            fontSize: 2.2.h,
                                            color: CustomColors.secondary),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: CustomSpacing.s3,
                              ),
                              selectedReasons.contains("Sold")
                                  ? TextFormField(
                                      controller: sellingPriceBird,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter price per bird';
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        prefixText: "Ksh",
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
                                            "What was the selling price per bird?",
                                        labelStyle: TextStyle(
                                            fontSize: 2.2.h,
                                            color: CustomColors.secondary),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: CustomSpacing.s3,
                              ),
                              selectedReasons.contains("Curled")
                                  ? TextFormField(
                                      controller: curledBirds,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter number of curled birds';
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.3.w,
                                                color: CustomColors.secondary)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.3.w,
                                                color: CustomColors.secondary)),
                                        labelText:
                                            "How many birds were curled?",
                                        labelStyle: TextStyle(
                                            fontSize: 2.2.h,
                                            color: CustomColors.secondary),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: CustomSpacing.s3,
                              ),
                              selectedReasons.contains("Stolen")
                                  ? TextFormField(
                                      controller: stolenBirds,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter number of stolen birds';
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.3.w,
                                                color: CustomColors.secondary)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.3.w,
                                                color: CustomColors.secondary)),
                                        labelText:
                                            "How many birds were stolen?",
                                        labelStyle: TextStyle(
                                            fontSize: 2.2.h,
                                            color: CustomColors.secondary),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: CustomSpacing.s3,
                              ),
                            ],
                          ),
                        )
                      : Container(),

                  // SizedBox(

                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          if (birdsReduced == 'yes') {
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

                            var report = {
                              "data": {
                                "birdCounts": payload,
                              }
                            };

                            if (_formKey.currentState!.validate()) {
                              if (widget.batchDetails.type!.name == "LAYERS") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EggsCollectedPage(
                                          batchDetails: widget.batchDetails,
                                          report: report)),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedsUsedPage(
                                            batchDetails: widget.batchDetails,
                                            report: report,
                                          )),
                                );
                              }
                            }
                          } else {
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
                            var report = {
                              "data": {
                                "birdCounts": payload,
                              }
                            };

                            if (widget.batchDetails.type!.name == "LAYERS") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EggsCollectedPage(
                                          batchDetails: widget.batchDetails,
                                          report: report,
                                        )),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeedsUsedPage(
                                          batchDetails: widget.batchDetails,
                                          report: report,
                                        )),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            onSurface: Colors.transparent,
                            shadowColor: Colors.transparent,
                            onPrimary: CustomColors.background,
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
