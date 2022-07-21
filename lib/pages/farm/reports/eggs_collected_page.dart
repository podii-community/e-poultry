import 'package:epoultry/models/batch_model.dart';
import 'package:epoultry/pages/farm/reports/confirm_report_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../models/report_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class EggsCollectedPage extends StatefulWidget {
  EggsCollectedPage(
      {Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final Batches batchDetails;
  final Report report;

  @override
  State<EggsCollectedPage> createState() => _EggsCollectedPageState();
}

class _EggsCollectedPageState extends State<EggsCollectedPage> {
  final _formKey = GlobalKey<FormState>();

  final eggsCollected = TextEditingController();
  final mediumEggs = TextEditingController();
  final largeEggs = TextEditingController();
  final fullyBroken = TextEditingController();
  final partiallyBroken = TextEditingController();
  final deformed = TextEditingController();
  final comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.background,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20.h,
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Palette.kPrimary[100],
                        title: Text("${widget.batchDetails.name}"),
                        trailing: Icon(
                          PhosphorIcons.caretDownFill,
                        ),
                      ),
                      SizedBox(
                        height: CustomSpacing.s2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: CustomSpacing.s2),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            crossAxisSpacing: CustomSpacing.s1,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Type of Birds",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 2.h),
                                  ),
                                  Text(
                                    "${widget.batchDetails.type}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 3.5.h,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "No of Birds",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 2.h),
                                  ),
                                  Text(
                                    "${widget.batchDetails.quantity}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 3.5.h,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Age of Birds",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 2.h),
                                  ),
                                  Text(
                                    "${widget.batchDetails.age + " " + widget.batchDetails.units}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 3.3.h,
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
              SizedBox(
                height: CustomSpacing.s2,
              ),
              Container(
                height: 60.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Update Eggs Collected",
                        style: TextStyle(fontSize: 3.h),
                      ),
                    ),
                    SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: eggsCollected,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Number of Good Eggs",
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
                            SizedBox(
                              height: CustomSpacing.s3,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: CustomSpacing.s1,
                              mainAxisSpacing: CustomSpacing.s1,
                              childAspectRatio: 2,
                              children: [
                                TextFormField(
                                  controller: mediumEggs,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Medium Eggs",
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
                                  controller: largeEggs,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Large Eggs",
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
                              ],
                            ),
                            SizedBox(
                              height: CustomSpacing.s1,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              crossAxisSpacing: CustomSpacing.s1,
                              childAspectRatio: 2,
                              children: [
                                TextFormField(
                                  controller: fullyBroken,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Fully Broken",
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
                                  controller: partiallyBroken,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Partially Broken",
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
                                  controller: deformed,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Deformed",
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
                              ],
                            ),
                            SizedBox(
                              height: CustomSpacing.s2,
                            ),
                            TextFormField(
                              controller: comment,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: "Comment on quality of Eggs",
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
                          ],
                        ))
                  ],
                ),
              ),
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      Report _report = Report(
                          reason: widget.report.reason,
                          reduceBy: widget.report.reduceBy,
                          typeOfFeed: widget.report.typeOfFeed,
                          quantity: widget.report.quantity,
                          measurement: widget.report.measurement,
                          eggsCollected: eggsCollected.text,
                          mediumEggs: mediumEggs.text,
                          largeEggs: largeEggs.text,
                          fullyBroken: fullyBroken.text,
                          partiallyBroken: partiallyBroken.text,
                          deformedEggs: deformed.text,
                          comment: comment.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmReportPage(
                                  report: _report,
                                  batch: widget.batchDetails,
                                )),
                      );
                    },
                    child: Text('PROCEED'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        onPrimary: CustomColors.background,
                        fixedSize: Size(100.w, 6.h))),
              ),
              SizedBox(
                height: CustomSpacing.s1,
              ),
            ],
          ),
        ));
  }
}
