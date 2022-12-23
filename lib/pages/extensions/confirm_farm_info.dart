import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import 'housing_inspection.dart';

class ConfirmFarmInformation extends StatelessWidget {
  const ConfirmFarmInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Farm Information',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: CustomColors.background,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Farm Information Summary",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HousingInspection(),
                            ),
                          );
                          // _confirmBatchPressed(context, runMutation);
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: CustomColors.background,
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor:
                                Colors.transparent.withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.transparent.withOpacity(0.12),
                            shadowColor: Colors.transparent,
                            fixedSize: Size(100.w, 6.h)),
                        child: const Text('CONFIRM')),
                  )
                  // Mutation(
                  //   options: MutationOptions(
                  //     document: gql(context.queries.createBatch()),
                  //     onCompleted: (data) => _onCompleted(data, context),
                  //   ),
                  //   builder: (RunMutation runMutation, QueryResult? result) {
                  //     if (result != null) {
                  //       if (result.isLoading) {
                  //         return const LoadingSpinner();
                  //       }

                  //       if (result.hasException) {
                  //         context.showError(
                  //           ErrorModel.fromGraphError(
                  //             result.exception?.graphqlErrors ?? [],
                  //           ),
                  //         );
                  //       }
                  //     }

                  //     return
                  //   },
                  // ),
                ],
              ),
            )));
  }

  // Future<void> _onCompleted(data, BuildContext context) async {
  //   if ((data['createBatch']['id']).toString().isNotEmpty) {
  //     Get.to(() => const SuccessWidget(
  //           message: 'You have successfully created a batch',
  //           route: 'dashboard',
  //         ));
  //   }
  // }

  // Future<void> _confirmBatchPressed(
  //     BuildContext context, RunMutation runMutation) async {
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   DateTime now = DateTime.now();
  //   DateTime date = DateTime(now.year, now.month, now.day);

  //   runMutation({
  //     "data": {
  //       'acquiredDate':
  //           formatter.format(DateFormat('dd-MM-yyyy').parse(date.toString())),
  //       'ageType': newBatch.ageType!.name,
  //       'birdAge': newBatch.birdAge,
  //       'birdCount': newBatch.birdCount,
  //       'birdType': newBatch.type!.name,
  //       'name': newBatch.name,
  //       'farmId': newBatch.farmId
  //     },
  //   });
  // }
}
