import 'dart:developer';

import 'package:epoultry/core/data/data_source/graphql/query_document_provider.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/core/presentation/components/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/presentation/controllers/farm_controller.dart';
import '../../../../core/domain/models/error.dart';
import '../../../../theme/colors.dart';
import '../../../../core/presentation/components/loading_spinner.dart';
import '../../../../core/presentation/components/success_widget.dart';

class RequestFarmVisit extends StatefulWidget {
  const RequestFarmVisit({super.key});

  @override
  State<RequestFarmVisit> createState() => _RequestFarmVisitState();
}

class _RequestFarmVisitState extends State<RequestFarmVisit> {
  final date = TextEditingController();
  final purpose = TextEditingController();
  final controller = Get.find<FarmsController>();
  var selectedFarm = {};
  bool agreeFirstCondition = false;
  bool agreeSecondCondition = false;

  @override
  void initState() {
    super.initState();

    date.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
            'Request Farm Visit',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    Text(
                      "Select farm",
                      style: TextStyle(fontSize: 2.1.h),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    DropdownButtonFormField<String>(
                        value: controller.farm['id'],
                        items: controller.farms
                            .map((farm) => DropdownMenuItem<String>(
                                value: farm['id'], child: Text(farm['name'])))
                            .toList(),
                        decoration: InputDecoration(
                            labelText: "Name of farm",
                            labelStyle: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary))),
                        onChanged: (s) {
                          controller.updateFarmForVisit(controller.farms
                              .firstWhere((farm) => farm['id'] == s));
                        }),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Text(
                      "Select the date for the visit",
                      style: TextStyle(fontSize: 2.1.h),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    TextFormField(
                      onTap: () {
                        _selectDate(context);
                      },
                      controller: date,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Date is required';
                        }
                        return null;
                      },
                      showCursor: false,
                      decoration: InputDecoration(
                          labelText: "Date",
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                          labelStyle: TextStyle(
                              fontSize: 2.2.h, color: CustomColors.secondary),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w,
                                  color: CustomColors.secondary))),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    TextFormField(
                      controller: purpose,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Purpose is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Purpose of the visit",
                          labelStyle: TextStyle(
                              fontSize: 2.2.h, color: CustomColors.secondary),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w,
                                  color: CustomColors.secondary))),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    CheckboxListTile(
                      title: const Text(
                          "I understand that this service may accrue a charge that will be agreed upon by both the officer and I."),
                      value: agreeFirstCondition,
                      onChanged: (newValue) {
                        setState(() {
                          agreeFirstCondition = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    CheckboxListTile(
                      title: const Text(
                          "I understand that any incidents, outcomes, or consequences taht may arise during the farm visit are the sole responsibility of the officer and I."),
                      value: agreeSecondCondition,
                      onChanged: (newValue) {
                        setState(() {
                          agreeSecondCondition = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Mutation(
                        options: MutationOptions(
                          document: gql(context.queries.requestFarmVisit()),
                          onCompleted: (data) => _onCompleted(data, context),
                        ),
                        builder:
                            (RunMutation runMutation, QueryResult? result) {
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
                              onPressed: () => agreeFirstCondition && agreeSecondCondition
                                  ? _requestVisitPressed(context, runMutation)
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
                ))));
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null &&
        DateFormat('yyyy-MM-dd').format(picked) != date.text) {
      setState(() {
        date.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    log("$data");
    if ((data['requestFarmVisit']['farmId']).toString().isNotEmpty) {
      Get.to(() => const SuccessWidget(
            message:
                'You have sucessfully requested a farm visit. Well notifying you as soon as an extension officer accepts the visit.',
            route: 'dashboard',
          ));
    }
  }

  Future<void> _requestVisitPressed(
      BuildContext context, RunMutation runMutation) async {
    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
    log("${{
      "data": {
        "farmId": controller.selectedFarmForVisit['id'],
        "visitDate": date.text,
        "visitPurpose": purpose.text
      },
    }}");

    runMutation({
      "data": {
        "farmId": controller.farm['id'],
        "visitDate": date.text,
        "visitPurpose": purpose.text
      },
    });
  }
}
