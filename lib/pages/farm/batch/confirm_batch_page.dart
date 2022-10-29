import 'dart:developer';

import 'package:epoultry/data/models/batch_model.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../../../widgets/success_widget.dart';

class ConfirmBatchPage extends StatelessWidget {
  ConfirmBatchPage({Key? key, required this.newBatch}) : super(key: key);

  final BatchModel newBatch;
  final FarmsController controller = Get.put(FarmsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Confirm this Batch",
                      style: TextStyle(fontSize: 3.h),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Batch Name",
                              style: TextStyle(
                                  color: CustomColors.secondary,
                                  fontSize: 2.4.h),
                            ),
                            Text(
                              newBatch.name,
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
                              "Type of Birds",
                              style: TextStyle(
                                  color: CustomColors.secondary,
                                  fontSize: 2.4.h),
                            ),
                            Text(
                              newBatch.type!.name,
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
                              "Number of Birds",
                              style: TextStyle(
                                  color: CustomColors.secondary,
                                  fontSize: 2.4.h),
                            ),
                            Text(
                              '${newBatch.birdCount}',
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
                              "Age",
                              style: TextStyle(
                                  color: CustomColors.secondary,
                                  fontSize: 2.4.h),
                            ),
                            Text(
                              newBatch.birdAge.toString() +
                                  newBatch.ageType!.name.toString(),
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
                              style: TextStyle(
                                  color: CustomColors.secondary,
                                  fontSize: 2.4.h),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              style: TextStyle(fontSize: 2.1.h),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Mutation(
                    options: MutationOptions(
                      document: gql(context.queries.createBatch()),
                      onCompleted: (data) => _onCompleted(data, context),
                    ),
                    builder: (RunMutation runMutation, QueryResult? result) {
                      if (result != null) {
                        if (result.isLoading) {
                          return const LoadingSpinner();
                        }

                        if (result.hasException) {
                          context.showError(
                            ErrorModel.fromGraphError(
                              result.exception?.graphqlErrors ?? [],
                            ),
                          );
                        }
                      }

                      return GradientWidget(
                        child: ElevatedButton(
                            onPressed: () =>
                                _confirmBatchPressed(context, runMutation),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onSurface: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onPrimary: CustomColors.background,
                                fixedSize: Size(100.w, 6.h)),
                            child: const Text('CONFIRM')),
                      );
                    },
                  ),
                ],
              ),
            )));
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if ((data['createBatch']['id']).toString().isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SuccessWidget(
                    message: 'You have successfully created a batch',
                    route: 'dashboard',
                  )));
    }
  }

  Future<void> _confirmBatchPressed(
      BuildContext context, RunMutation runMutation) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    final FarmsController controller = Get.put(FarmsController());

    runMutation({
      "data": {
        'acquiredDate':
            formatter.format(DateFormat('dd-MM-yyyy').parse(date.toString())),
        'ageType': newBatch.ageType!.name,
        'birdAge': newBatch.birdAge,
        'birdCount': newBatch.birdCount,
        'birdType': newBatch.type!.name,
        'name': newBatch.name,
        'farmId': newBatch.farmId
      },
    });
  }
}
