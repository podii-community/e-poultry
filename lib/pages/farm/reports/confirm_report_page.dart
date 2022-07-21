import 'package:epoultry/pages/farm/farm_dashboard_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';

class ConfirmReportPage extends StatelessWidget {
  const ConfirmReportPage({Key? key}) : super(key: key);

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
        title: Text(
          "CONFIRM REPORT",
          style: TextStyle(color: Colors.black, fontSize: 2.3.h),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Farm Name",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        'Odongos Vihiga Farm',
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Contractor ",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        'Chicken Basket',
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Farm Manager",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        'Sophia',
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Batch Name",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        'Batch 2',
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        '14th July 2022',
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Time",
                        style: TextStyle(color: Colors.black, fontSize: 2.2.h),
                      ),
                      Text(
                        '12:00 PM',
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: CustomSpacing.s1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Summary",
                style: TextStyle(fontSize: 2.5.h),
              ),
            ),
            SizedBox(
              height: 50.h,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.9,
                shrinkWrap: true,
                children: [
                  Card(
                    elevation: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Palette.kPrimary[200]!,
                            Palette.kSecondary[100]!
                          ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      padding: const EdgeInsets.all(CustomSpacing.s2),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bird Count",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                              Text(
                                '-10',
                                style: TextStyle(
                                    fontSize: 2.h, color: CustomColors.red),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mortality",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sold",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '2',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Curled",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '2',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stolen",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.4,
                    child: Container(
                      padding: const EdgeInsets.all(CustomSpacing.s2),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Palette.kPrimary[200]!,
                            Palette.kSecondary[100]!
                          ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Eggs",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                              Text(
                                '+1003',
                                style: TextStyle(
                                    fontSize: 2.h, color: CustomColors.green),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Large",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '700',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Medium",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '300',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deformed",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '2',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Broken",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Palette.kPrimary[200]!,
                            Palette.kSecondary[100]!
                          ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      padding: const EdgeInsets.all(CustomSpacing.s2),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Feeds",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                              Text(
                                '-10Kg',
                                style: TextStyle(
                                    fontSize: 2.h, color: CustomColors.red),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Layers Mash",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '5kg',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Chicken Mash",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
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
            GradientWidget(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FarmDashboardPage()),
                    );
                  },
                  child: Text('SEND UPDATE'),
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
      ),
    );
  }
}
