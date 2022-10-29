import 'dart:developer';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/reports/view_report_page.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';

class AllReportsPage extends StatefulWidget {
  const AllReportsPage({Key? key}) : super(key: key);

  @override
  State<AllReportsPage> createState() => _AllReportsPageState();
}

class _AllReportsPageState extends State<AllReportsPage> {
  @override
  Widget build(BuildContext context) {
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
          'Reports',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey)),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Query(
                  options: QueryOptions(
                    document: gql(context.queries.dashboardReports()),
                    fetchPolicy: FetchPolicy.noCache,
                    pollInterval: const Duration(minutes: 2),
                  ),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.isLoading) {
                      return const LoadingSpinner();
                    }
                    if (result.hasException) {
                      return AppErrorWidget(
                        error: ErrorModel.fromString(
                          result.exception.toString(),
                        ),
                      );
                    }

                    List reports = [];

                    List managingFarms = result.data?['user']!["managingFarms"];

                    for (var farm in managingFarms) {
                      List farmBatches = farm["batches"];
                      for (var batch in farmBatches) {
                        List batchReport = batch["reports"];
                        for (var report in batchReport) {
                          reports.add(report);
                        }
                      }
                    }

                    List ownedFarms = result.data?['user']!["ownedFarms"];

                    for (var farm in ownedFarms) {
                      List farmBatches = farm["batches"];
                      for (var batch in farmBatches) {
                        List batchReport = batch["reports"];
                        for (var report in batchReport) {
                          reports.add(report);
                        }
                      }
                    }

                    if (reports.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: reports.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              trailing: const Icon(
                                PhosphorIcons.arrowRightBold,
                                color: Colors.black,
                              ),
                              title: Text("Farm Report",
                                  style: TextStyle(fontSize: 1.9.h)),
                              subtitle: Text("${reports[index]["reportDate"]}"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewReportPage(
                                            report: reports[index],
                                          )),
                                );
                              },
                              tileColor: CustomColors.background,
                              textColor: Colors.black,
                            );
                          }));
                    }
                    return Container();
                  }),
              Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                      onPressed: () {},
                      style:
                          OutlinedButton.styleFrom(fixedSize: Size(50.w, 6.h)),
                      child: GradientText("EXPORT REPORTS",
                          style: TextStyle(fontSize: 2.h),
                          gradient: CustomColors.primaryGradient)))
            ],
          ),
        ),
      ),
    );
  }
}
