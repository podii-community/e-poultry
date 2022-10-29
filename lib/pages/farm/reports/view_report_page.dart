import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/palette.dart';
import '../../../theme/spacing.dart';

class ViewReportPage extends StatelessWidget {
  const ViewReportPage({Key? key,required this.report}) : super(key: key);
  final report;
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
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "REPORT",
          style: TextStyle(color: Colors.black, fontSize: 2.3.h),
        ),
      ),
      body: Container(
        padding:  EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
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
                  const SizedBox(
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
                  const SizedBox(
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
                  const SizedBox(
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
                        "",
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  const SizedBox(
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
                        '${report!['reportDate']}',
                        style: TextStyle(fontSize: 2.1.h),
                      )
                    ],
                  ),
                  const SizedBox(
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
            const SizedBox(height: CustomSpacing.s1),
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

                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                              report!['birdCounts'].length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      report!['birdCounts']
                                      [index]['reason'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 1.8.h),
                                    ),
                                    Text(
                                      report!['birdCounts']
                                      [index]['quantity'].toString(),
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    )
                                  ],
                                );
                              })

                        ],
                      ),
                    ),
                  ),
                  report!['eggCollection'].isNotEmpty
                      ? Card(
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Eggs",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 2.h),
                              ),
                              Text(
                                '+${report!['eggCollection']["eggCount"]}',
                                style: TextStyle(
                                    fontSize: 2.h,
                                    color: CustomColors.green),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Large",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '${report!['eggCollection']["largeCount"]}',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Small",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '${report!['eggCollection']["smallCount"]}',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deformed",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '${report!['eggCollection']["deformedCount"] }',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Broken",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 1.8.h),
                              ),
                              Text(
                                '${report!['eggCollection']["brokenCount"]}',
                                style: TextStyle(
                                    fontSize: 1.8.h, color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                      : Container(),
                  // Card(
                  //   elevation: 0.4,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         gradient: LinearGradient(
                  //             colors: [
                  //               Palette.kPrimary[200]!,
                  //               Palette.kSecondary[100]!
                  //             ],
                  //             begin: Alignment.centerLeft,
                  //             end: Alignment.centerRight)),
                  //     padding: const EdgeInsets.all(CustomSpacing.s2),
                  //     child: ListView(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Feeds",
                  //               style: TextStyle(
                  //                   color: Colors.black, fontSize: 2.h),
                  //             ),
                  //           ],
                  //         ),
                  //         const SizedBox(
                  //           height: CustomSpacing.s2,
                  //         ),
                  //         ListView.builder(
                  //             shrinkWrap: true,
                  //             itemCount:
                  //                 report!['feedsUsageReports'].length,
                  //             itemBuilder: (context, index) {
                  //               return Row(
                  //                 mainAxisAlignment:
                  //                 MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     report!['feedsUsageReports']
                  //                     ['feedsUsageReports'][index]
                  //                     ['feedType'],
                  //                     style: TextStyle(
                  //                         color: Colors.black, fontSize: 1.4.h),
                  //                   ),
                  //                   Text(
                  //                     report!['feedsUsageReports'][index]
                  //                     ['quantity'].toString(),
                  //                     style: TextStyle(
                  //                         fontSize: 1.8.h, color: Colors.black),
                  //                   )
                  //                 ],
                  //               );
                  //             })
                  //
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),

            const SizedBox(
              height: CustomSpacing.s1,
            ),
          ],
        ),
      ),
    );
  }
}
