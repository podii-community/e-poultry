import 'dart:developer';

import 'package:epoultry/data/data_export.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import 'feeds_used_page.dart';

class EggsCollectedPage extends StatefulWidget {
  const EggsCollectedPage(
      {Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<EggsCollectedPage> createState() => _EggsCollectedPageState();
}

class _EggsCollectedPageState extends State<EggsCollectedPage> {
  final _formKey = GlobalKey<FormState>();

  final eggsCollected = TextEditingController();
  final largeEggs = TextEditingController();
  final smallEggs = TextEditingController();
  final brokenEggs = TextEditingController();
  final deformedEggs = TextEditingController();

  String gradeEggs = "";

  @override
  Widget build(BuildContext context) {
    log("${widget.report["data"]}");
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Update Eggs in store",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: CustomSpacing.s2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: eggsCollected,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter number of eggs collected';
                                }
                                return null;
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
                                labelText:
                                    "How many Eggs have you collected today?",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                              ),
                            ),
                            const SizedBox(
                              height: CustomSpacing.s3,
                            ),
                            TextFormField(
                              controller: brokenEggs,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter number of broken eggs';
                                }
                                return null;
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
                                labelText: "How many Eggs were broken?",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                              ),
                            ),
                            const SizedBox(
                              height: CustomSpacing.s3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Would you like to grade the good eggs ?",
                                  style: TextStyle(
                                    fontSize: 2.2.h,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: ListTile(
                                        title: const Text('Yes'),
                                        leading: Radio<String>(
                                          value: "yes",
                                          groupValue: gradeEggs,
                                          onChanged: (value) {
                                            setState(() {
                                              gradeEggs = value.toString();
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
                                          groupValue: gradeEggs,
                                          onChanged: (value) {
                                            setState(() {
                                              gradeEggs = value.toString();
                                            });
                                            largeEggs.clear();
                                            deformedEggs.clear();
                                            smallEggs.clear();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            gradeEggs == 'yes'
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: CustomSpacing.s2,
                                      ),
                                      TextFormField(
                                        controller: deformedEggs,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter number of deformed eggs';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          prefixStyle:
                                              TextStyle(fontSize: 1.8.h),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          labelText:
                                              "How many Eggs out of  the collected were deformed?",
                                          labelStyle: TextStyle(
                                              fontSize: 1.6.h,
                                              color: CustomColors.secondary),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: CustomSpacing.s2,
                                      ),
                                      TextFormField(
                                        controller: smallEggs,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter number of small eggs';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          prefixStyle:
                                              TextStyle(fontSize: 1.8.h),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          labelText:
                                              "How many eggs out of the remaining were small?",
                                          labelStyle: TextStyle(
                                              fontSize: 1.6.h,
                                              color: CustomColors.secondary),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: CustomSpacing.s2,
                                      ),
                                      TextFormField(
                                        controller: largeEggs,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter number of large eggs';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          labelText:
                                              "How many Eggs out of the remaining  were large?",
                                          labelStyle: TextStyle(
                                              fontSize: 1.6.h,
                                              color: CustomColors.secondary),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(
                              height: CustomSpacing.s3,
                            ),
                          ],
                        ))
                  ],
                ),
                GradientWidget(
                  child: ElevatedButton(
                      onPressed: () {
                        var payload = {
                          "brokenCount": brokenEggs.text.isEmpty
                              ? 0
                              : int.parse(brokenEggs.text),
                          "deformedCount": deformedEggs.text.isEmpty
                              ? 0
                              : int.parse(deformedEggs.text),
                          "eggCount": eggsCollected.text.isEmpty
                              ? 0
                              : int.parse(eggsCollected.text),
                          "largeCount": largeEggs.text.isEmpty
                              ? 0
                              : int.parse(largeEggs.text),
                          "smallCount": smallEggs.text.isEmpty
                              ? 0
                              : int.parse(smallEggs.text),
                        };

                        // widget.report["data"]!["eggCollection"] =
                        //     payload as Map;

                        var report = {
                          "data": {
                            "birdCounts": widget.report["data"]["birdCounts"],
                            "eggCollection": payload
                          }
                        };

                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedsUsedPage(
                                      batchDetails: widget.batchDetails,
                                      report: report,
                                    )),
                          );
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
                const SizedBox(
                  height: CustomSpacing.s1,
                ),
              ],
            ),
          ),
        ));
  }
}
