import 'dart:developer';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/batch/create_batch_page.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/farm_controller.dart';
import '../../../../data/models/error.dart';
import '../../../../theme/colors.dart';
import '../../../../widgets/gradient_widget.dart';
import '../../../../widgets/loading_spinner.dart';
import '../../../../widgets/success_widget.dart';

class GetMedicalHelp extends StatefulWidget {
  GetMedicalHelp({super.key});

  @override
  State<GetMedicalHelp> createState() => _GetMedicalHelpState();
}

class _GetMedicalHelpState extends State<GetMedicalHelp> {
  final controller = Get.find<FarmsController>();

  final selectedBatch = TextEditingController();

  final issue = TextEditingController();

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    if (controller.batchesList.isNotEmpty) {
      selectedBatch.text = controller.batchesList.first['id'];
    }
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
          'Get Medical Help',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: controller.batchesList.isEmpty
          ? Container(
              child: Center(
                child: Column(
                  children: [
                    Text('You dont have any batches.Create one'),
                    TextButton(
                        onPressed: (() => Get.to(CreateBatchPage())),
                        child: Text('Create Batch'))
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Text(
                    "Select the batch you want to vaccinate",
                    style: TextStyle(fontSize: 2.2.h),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  DropdownButtonFormField<dynamic>(
                    // Initial Value
                    key: UniqueKey(),
                    value: selectedBatch.text,
                    isExpanded: true,
                    elevation: 0,
                    decoration: InputDecoration(
                        hintText: "Select batch",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        helperText:
                            "Selecting a batch will share the type of birds, age and number of birds. This will help the vet better advise on the doses required for medication",
                        helperMaxLines: 5,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),

                    onChanged: (val) {},
                    items: controller.batchesList.map((batch) {
                      return DropdownMenuItem<dynamic>(
                        value: batch['id'],
                        child: Text(batch['name']),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    controller: issue,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'What issue are you facing?';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Describe the issue",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  CheckboxListTile(
                    title: const Text(
                        "I understand that this service may accrue a charge that will be agreed upon by both the officer and I"),
                    value: agree,
                    onChanged: (newValue) {
                      setState(() {
                        agree = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Mutation(
                      options: MutationOptions(
                        document: gql(context.queries.requestMedicalVisit()),
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
                            onPressed: () => agree
                                ? _requestMedicalVisitPressed(
                                    context, runMutation)
                                : null,
                            style: ElevatedButton.styleFrom(
                                foregroundColor: CustomColors.background,
                                backgroundColor: Colors.transparent,
                                disabledForegroundColor:
                                    Colors.transparent.withOpacity(0.38),
                                disabledBackgroundColor:
                                    Colors.transparent.withOpacity(0.12),
                                shadowColor: Colors.transparent,
                                fixedSize: Size(100.w, 6.h)),
                            child: Text(
                              'REQUEST',
                              style: TextStyle(
                                fontSize: 1.8.h,
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            )),
    );
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if ((data['requestMedicalVisit']['farmId']).toString().isNotEmpty) {
      Get.to(() => const SuccessWidget(
            message:
                'You have sucessfully requested for medical help. We’ll notify you as soon as there is a Vetinary officer available.',
            route: 'dashboard',
          ));
    }
  }

  Future<void> _requestMedicalVisitPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation({
      "data": {'batchId': selectedBatch.text, "description": issue.text},
    });
  }
}
