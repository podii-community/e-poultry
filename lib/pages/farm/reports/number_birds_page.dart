import 'package:epoultry/pages/farm/reports/feeds_used_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class NumberOfBirdsReportPage extends StatefulWidget {
  NumberOfBirdsReportPage({Key? key}) : super(key: key);

  @override
  State<NumberOfBirdsReportPage> createState() =>
      _NumberOfBirdsReportPageState();
}

class _NumberOfBirdsReportPageState extends State<NumberOfBirdsReportPage> {
  final _formKey = GlobalKey<FormState>();

  var reasons = ["", "Sold", "Mortality", "Curled"];

  String initialReason = "";

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
                        title: Text("Batch 2"),
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
                                    "Layers",
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
                                    "2256",
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
                                    "4 weeks",
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
                        "Update Number of Birds",
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
                              decoration: InputDecoration(
                                  labelText: "Reduce By",
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
                            DropdownButtonFormField(
                              // Initial Value
                              value: initialReason,
                              isExpanded: true,
                              elevation: 0,
                              decoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "Reason",
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

                              items: reasons.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  initialReason = newValue!;
                                });
                              },
                              // After selecting the desired option,it will
                              // change button value to selected value
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedsUsedPage()),
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
