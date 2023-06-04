import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/presentation/components/gradient_widget.dart';
import '../../../core/presentation/controllers/farm_controller.dart';
import '../../../core/presentation/controllers/user_controller.dart';
import '../../../core/domain/models/error.dart';
import '../../../core/presentation/components/loading_spinner.dart';
import '../../../core/presentation/components/success_widget.dart';

class ConfirmGeneralObseravtions extends StatefulWidget {
  ConfirmGeneralObseravtions({
    Key? key,
    this.report,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final report;
  final controller = Get.find<FarmsController>();
  @override
  State<ConfirmGeneralObseravtions> createState() =>
      _ConfirmGeneralObseravtionsState();
}

class _ConfirmGeneralObseravtionsState
    extends State<ConfirmGeneralObseravtions> {
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FarmsController>();
    String generalObservation =
        controller.farmVisitReport["data"]!['generalObservation'].toString();
    String recommendation =
        controller.farmVisitReport["data"]!['recommendations'].toString();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Back',
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
                  const Center(
                    child: Text(
                      "General Observations",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("General Observation: $generalObservation",
                          style: const TextStyle(fontSize: 20)),
                      const Divider(),
                      Text("Recommendation: $recommendation",
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  Mutation(
                    options: MutationOptions(
                      document: gql(context.queries.createFarmVisitReport()),
                      operationName: "CreateFarmVisitReport",
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
                                _submitReport(context, runMutation),
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
                      );
                    },
                  ),
                ],
              ),
            )));
  }

  Future<void> _submitReport(
      BuildContext context, RunMutation runMutation) async {
    final data = controller.farmVisitReport["data"] as Map;
    runMutation({
      "data": {
        "compound": {
          "landscape": data["compound"]["landscape"].value,
          "security": data["compound"]["security"].value,
          "tankCleanliness": data["compound"]["security"].value,
        },
        "extensionServiceId": data["extensionServiceId"],
        "farmInformation": {
          "ageType": data["farmInformation"]["ageType"].value,
          "birdAge": data["farmInformation"]["birdAge"].value,
          "birdType": data["farmInformation"]["birdType"].value,
          "deliveredBirdCount":
              data["farmInformation"]["deliveredBirdCount"].value,
          "farmAssistantContact":
              data["farmInformation"]["farmAssistantContact"].value,
          "farmOfficerContact":
              data["farmInformation"]["farmOfficerContact"].value,
          "mortality": data["farmInformation"]["mortality"].value,
          "remainingBirdCount":
              data["farmInformation"]["remainingBirdCount"].value,
        },
        // data["farmInformation"]["landscape"].value,
        "farmTeam": {
          "cleanliness": data["farmTeam"]["cleanliness"].value,
          "gumboots": data["farmTeam"]["gumboots"].value,
          "uniforms": data["farmTeam"]["uniforms"].value,
        },
        // data["farmTeam"]["landscape"].value,
        "generalObservation": data["generalObservation"],
        "housingInspection": {
          "bioSecurity": data["housingInspection"]["bioSecurity"].value,
          "cobwebs": data["housingInspection"]["cobwebs"].value,
          "drinkers": data["housingInspection"]["drinkers"].value,
          "dust": data["housingInspection"]["dust"].value,
          "feeders": data["housingInspection"]["feeders"].value,
          "lighting": data["housingInspection"]["lighting"].value,
          "repairAndMaintainance":
              data["housingInspection"]["repairAndMaintainance"].value,
          "ventilation": data["housingInspection"]["ventilation"].value,
        },
        // data["housingInspection"]["landscape"].value,
        "recommendations": data["recommendations"],
        "store": {
          "cleanliness": data["store"]["cleanliness"].value,
          "arrangement": data["store"]["arrangement"].value,
          "stockTake": data["store"]["stockTake"].value,
        }
        // data["store"]["landscape"].value,
      }
    });
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if ((data['createFarmVisitReport']['id'] != null)) {
      Get.to(() => const SuccessWidget(
            message: 'You have updated the report',
            route: 'extension',
          ));
    }
  }
}
