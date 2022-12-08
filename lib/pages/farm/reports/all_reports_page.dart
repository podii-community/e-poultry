import 'package:epoultry/pages/farm/reports/export-reports/filter-reports.dart';
import 'package:epoultry/pages/farm/reports/view_report_page.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../theme/colors.dart';

class AllReportsPage extends StatefulWidget {
  const AllReportsPage({Key? key}) : super(key: key);

  @override
  State<AllReportsPage> createState() => _AllReportsPageState();
}

class _AllReportsPageState extends State<AllReportsPage> {
  final controller = Get.find<FarmsController>();

  @override
  Widget build(BuildContext context) {
    // controller.filteredReports.clear();
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
            Get.back();
          },
        ),
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Text(
              "Find a specific report",
              style: TextStyle(fontSize: 3.h),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.w),
                  prefixIcon: Icon(
                    PhosphorIcons.magnifyingGlass,
                    color: CustomColors.secondary,
                    size: 7.w,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  hintText: 'Search date/batch name/farm manager',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey)),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            controller.reportsList.isEmpty
                ? Card(
                    elevation: 4,
                    shadowColor: CustomColors.secondary,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.5.h),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.info,
                            size: 8.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'What is a report?',
                                style: TextStyle(fontSize: 4.w),
                              ),
                              Text(
                                'A general overview of the farm',
                                style: TextStyle(
                                    fontSize: 3.w, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.reportsList.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            trailing: const Icon(
                              PhosphorIcons.arrowRightBold,
                              color: Colors.black,
                            ),
                            title: Text("Farm Report",
                                style: TextStyle(fontSize: 1.9.h)),
                            subtitle: Text(
                                "${controller.reportsList[index]["reportDate"]}"),
                            onTap: () {
                              controller.selectedReport(
                                  controller.reportsList[index]);

                              Get.to(() => ViewReportPage());
                            },
                            tileColor: CustomColors.background,
                            textColor: Colors.black,
                          );
                        })),
                  ),
            Align(
                alignment: Alignment.bottomRight,
                child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => FilterReportsPage());
                    },
                    style: OutlinedButton.styleFrom(fixedSize: Size(50.w, 6.h)),
                    child: GradientText("EXPORT REPORTS",
                        style: TextStyle(fontSize: 2.h),
                        gradient: CustomColors.primaryGradient)))
          ],
        ),
      ),
    );
  }
}
