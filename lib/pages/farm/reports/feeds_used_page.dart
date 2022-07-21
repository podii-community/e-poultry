import 'package:epoultry/models/batch_model.dart';
import 'package:epoultry/models/report_model.dart';
import 'package:epoultry/pages/farm/reports/eggs_collected_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class FeedsUsedPage extends StatefulWidget {
  FeedsUsedPage({Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final Batches batchDetails;
  final Report report;
  @override
  State<FeedsUsedPage> createState() => _FeedsUsedPageState();
}

class _FeedsUsedPageState extends State<FeedsUsedPage> {
  final _formKey = GlobalKey<FormState>();

  var typeOfFeed = ["", "Layers Mash"];

  var units = ["", "Kilograms", "Grams"];

  String initialFeed = "";

  String initialUnit = "";

  final quantity = TextEditingController();

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
                height: CustomSpacing.s3,
              ),
              Container(
                height: 50.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Update Feeds Used",
                        style: TextStyle(fontSize: 3.h),
                      ),
                    ),
                    SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    Expanded(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  // Initial Value
                                  value: initialFeed,
                                  isExpanded: true,
                                  elevation: 0,
                                  decoration: InputDecoration(
                                      hintText: "--select--",
                                      labelText: "Type of Feed",
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

                                  items: typeOfFeed.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      initialFeed = newValue!;
                                    });
                                  },
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                ),
                                SizedBox(
                                  height: CustomSpacing.s2,
                                ),
                                Expanded(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: CustomSpacing.s1,
                                    children: [
                                      TextFormField(
                                        controller: quantity,
                                        decoration: InputDecoration(
                                            labelText: "Quantity",
                                            labelStyle: TextStyle(
                                                fontSize: 2.2.h,
                                                color: CustomColors.secondary),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.3.w,
                                                    color: CustomColors
                                                        .secondary)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.3.w,
                                                    color: CustomColors
                                                        .secondary))),
                                      ),
                                      DropdownButtonFormField(
                                        // Initial Value
                                        key: UniqueKey(),
                                        value: initialUnit,
                                        isExpanded: true,
                                        elevation: 0,
                                        decoration: InputDecoration(
                                            hintText: "--select--",
                                            labelText: "Measurement",
                                            labelStyle: TextStyle(
                                                fontSize: 2.2.h,
                                                color: CustomColors.secondary),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.3.w,
                                                    color: CustomColors
                                                        .secondary)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.3.w,
                                                    color: CustomColors
                                                        .secondary))),

                                        items: units.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            initialUnit = newValue!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))),
                    OutlinedButton(
                        onPressed: () {},
                        child: Text('ADD FEEDS'),
                        style: OutlinedButton.styleFrom(
                            primary: CustomColors.secondary,
                            onSurface: CustomColors.secondary,
                            shadowColor: CustomColors.secondary,
                            // onPrimary: CustomColors.background,
                            fixedSize: Size(50.w, 6.h))),
                  ],
                ),
              ),
              SizedBox(
                height: CustomSpacing.s3,
              ),
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      Report _report = Report(
                          reason: widget.report.reason,
                          reduceBy: widget.report.reduceBy,
                          typeOfFeed: initialFeed,
                          quantity: quantity.text,
                          measurement: initialUnit);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EggsCollectedPage(
                                  batchDetails: widget.batchDetails,
                                  report: _report,
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
