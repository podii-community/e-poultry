import 'package:epoultry/pages/farm/reports/confirm_report_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class EggsCollectedPage extends StatelessWidget {
  EggsCollectedPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmReportPage()),
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
