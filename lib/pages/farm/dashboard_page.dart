import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/gradient_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Column(
        children: [
          SizedBox(
            height: CustomSpacing.s2,
          ),
          Container(
            height: 15.h,
            child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "OVERVIEW",
                        style: TextStyle(fontSize: 2.2.h),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 8.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: CustomSpacing.s1),
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No of Birds",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                              GradientText(
                                "2256",
                                style: TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 3.5.h,
                                    fontWeight: FontWeight.w600),
                                gradient: CustomColors.primaryGradient,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Eggs in Store",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                              GradientText(
                                "1030",
                                style: TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 3.5.h,
                                    fontWeight: FontWeight.w600),
                                gradient: CustomColors.primaryGradient,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Feeds in Store",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                              GradientText(
                                "15 Kgs",
                                style: TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 3.5.h,
                                    fontWeight: FontWeight.w600),
                                gradient: CustomColors.primaryGradient,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: CustomSpacing.s2,
          ),
          Container(
            child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text("TODO TODAY", style: TextStyle(fontSize: 2.2.h)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 15.h,
                      child: ListView(
                        children: [
                          GradientWidget(
                            child: ListTile(
                              leading: Icon(
                                PhosphorIcons.plusCircleFill,
                                color: CustomColors.background,
                              ),
                              title: Text(
                                "Add a farm report",
                                style: TextStyle(fontSize: 2.3.h),
                              ),
                              tileColor: Colors.transparent,
                              textColor: CustomColors.background,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ListTile(
                            leading: Icon(
                              PhosphorIcons.warningFill,
                              color: Colors.black,
                            ),
                            trailing: Icon(
                              PhosphorIcons.arrowRightBold,
                              color: Colors.black,
                            ),
                            title: Text("Vaccination Report",
                                style: TextStyle(fontSize: 2.3.h)),
                            subtitle: Text("Overdue 6th July 2021"),
                            tileColor: CustomColors.background,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: CustomSpacing.s2,
          ),
          Container(
            child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("PREVIOUS REPORTS",
                          style: TextStyle(fontSize: 2.2.h)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 15.h,
                      child: ListView(
                        children: [
                          ListTile(
                            trailing: Icon(
                              PhosphorIcons.arrowRightBold,
                              color: Colors.black,
                            ),
                            title: Text("Farm Report",
                                style: TextStyle(fontSize: 1.9.h)),
                            subtitle: Text("6th June 2021"),
                            tileColor: CustomColors.background,
                            textColor: Colors.black,
                          ),
                          ListTile(
                            trailing: Icon(
                              PhosphorIcons.arrowRightBold,
                              color: Colors.black,
                            ),
                            title: Text("Farm Report",
                                style: TextStyle(fontSize: 1.9.h)),
                            subtitle: Text("6th July 2021"),
                            tileColor: CustomColors.background,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
