import 'dart:developer';

import 'package:epoultry/core/controllers/farm_controller.dart';
import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:epoultry/features/pages/farm/dashboard/farm_dashboard_page.dart';
import 'package:epoultry/features/pages/farm/e-extension/vaccination/vaccine_details.dart';
import 'package:epoultry/core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/data/models/error.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../../../../core/widgets/loading_spinner.dart';

class VaccinationList extends StatefulWidget {
  const VaccinationList({super.key, this.batchId});

  // ignore: prefer_typing_uninitialized_variables
  final batchId;

  @override
  State<VaccinationList> createState() => _VaccinationListState();
}

class _VaccinationListState extends State<VaccinationList> {
  final controller = Get.find<FarmsController>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        centerTitle: true,
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
          'Batch 1 Vaccination',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PENDING",
                  style: TextStyle(
                      fontSize: 2.2.h, color: CustomColors.textPrimary),
                ),
              ],
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Query(
                options: QueryOptions(
                  operationName: "ListBatchVaccination",
                  variables: {"batchId": widget.batchId},
                  document: gql(context.queries.listBatchVaccination()),
                  // pollInterval: const Duration(seconds: 2),
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

                  List vaccinationList = result.data!["listBatchVaccinations"];
                  List pending = vaccinationList
                      .where((vaccine) =>
                          vaccine['status'].toString() == "PENDING")
                      .toList();

                  log("$pending");

                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: pending.length,
                        itemBuilder: (context, index) {
                          return Card(
                              elevation: 0,
                              child: ListTile(
                                title: Text(
                                    '${pending[index]["vaccinationSchedule"]["vaccineName"]}'),
                                subtitle: Text(formatter.format(formatter
                                    .parse(pending[index]['dateScheduled']))),
                                trailing: SizedBox(
                                  width: 40.w,
                                  child: Mutation(
                                    options: MutationOptions(
                                      operationName: "CompleteBatchVaccination",
                                      document: gql(context.queries
                                          .completeBatchVaccination()),
                                      onCompleted: (data) =>
                                          _onCompleted(data, context),
                                    ),
                                    builder: (RunMutation runMutation,
                                        QueryResult? result) {
                                      if (result != null) {
                                        if (result.isLoading) {
                                          return const LoadingSpinner();
                                        }
                                        if (result.hasException) {
                                          context.showError(
                                            ErrorModel.fromGraphError(
                                              result.exception?.graphqlErrors ??
                                                  [],
                                            ),
                                          );
                                        }
                                      }

                                      return InkWell(
                                        onTap: () =>
                                            _completeVacccinationPressed(
                                                context,
                                                runMutation,
                                                pending[index]['id']),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text('Complete Vaccination',
                                                style: TextStyle(
                                                    fontSize: 1.5.h,
                                                    color: Colors.blue)),
                                            const Icon(PhosphorIcons.arrowRight,
                                                color: Colors.blue),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ));
                        }),
                  );
                }),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "COMPLETE",
                  style: TextStyle(
                      fontSize: 2.2.h, color: CustomColors.textPrimary),
                ),
                InkWell(
                  onTap: () {},
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text('SEE ALL',
                          style: TextStyle(
                            fontSize: 2.2.h,
                          )),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Query(
                options: QueryOptions(
                  operationName: "ListBatchVaccination",
                  variables: {"batchId": widget.batchId},
                  document: gql(context.queries.listBatchVaccination()),
                  // pollInterval: const Duration(seconds: 2),
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

                  List vaccinationList = result.data!["listBatchVaccinations"];
                  List completed = vaccinationList
                      .where((vaccine) =>
                          vaccine['status'].toString() == "COMPLETED")
                      .toList();

                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: completed.length,
                        itemBuilder: (context, index) {
                          return Card(
                              elevation: 0,
                              child: ListTile(
                                  onTap: () {
                                    Get.to(() => VaccineDetails(
                                          vaccine: completed[index],
                                        ));
                                  },
                                  title: Text(
                                      '${completed[index]["vaccinationSchedule"]["vaccineName"]}'),
                                  subtitle: Text(formatter.format(
                                      formatter.parse(
                                          completed[index]['dateScheduled']))),
                                  trailing: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('Complete',
                                          style: TextStyle(
                                              fontSize: 1.5.h,
                                              color: Colors.green)),
                                    ],
                                  )));
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }

  void _onCompleted(data, BuildContext context) {
    if ((data != null)) {
      Get.to(() => const FarmDashboardPage());
    }
  }

  Future<void> _completeVacccinationPressed(
      BuildContext context, RunMutation runMutation, id) async {
    runMutation(
      {"vaccinationId": id},
    );
  }
}
