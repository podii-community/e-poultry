import 'package:epoultry/features/farm/create-farm/create_farm_page.dart';
import 'package:epoultry/features/farm/join-farm/join_farm_otp.dart';
import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/controllers/user_controller.dart';
import '../../../core/data/models/error.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading_spinner.dart';
import '../quotation/request_quotation_page.dart';

class JoinFarmPage extends StatefulWidget {
  const JoinFarmPage({Key? key, this.isUnAssigned = false}) : super(key: key);

  final bool isUnAssigned;
  @override
  State<JoinFarmPage> createState() => _JoinFarmPageState();
}

class _JoinFarmPageState extends State<JoinFarmPage> {
  final List<Map> choices = [
    {"name": "Join an existing Farm", "selected": false, "value": "join"},
    {"name": "Manage my own Farm", "selected": false, "value": "manage"},
    {"name": "Request a quotation", "selected": false, "value": "request"}
  ];

  List<Map> updatedChoices() {
    if (widget.isUnAssigned) {
      choices.removeWhere((element) => element.containsValue('request'));
      return choices;
    } else {
      return choices;
    }
  }

  final userController = Get.find<UserController>();

  String selectedChoice = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: CustomSpacing.s2, vertical: 20.h),
            child: Query(
                options: QueryOptions(
                  document: gql(context.queries.getUserDetails()),
                  fetchPolicy: FetchPolicy.noCache,
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

                  return SizedBox(
                    height: 50.h,
                    child: Column(
                      children: [
                        Text(
                          "What would you like to do ?",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 3.h),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: CustomSpacing.s2),
                          child: ListView.builder(
                            itemBuilder: (context, i) {
                              return RadioListTile<dynamic>(
                                groupValue: selectedChoice,
                                activeColor: CustomColors.primary,
                                value: choices[i]["value"],
                                title: Text(choices[i]["name"]),
                                onChanged: (value) {
                                  setState(() {
                                    selectedChoice = value;
                                  });
                                  switch (selectedChoice) {
                                    case "join":
                                      Get.to(() => JoinFarmOtp());

                                      userController.updateRole('manager');

                                      break;
                                    case "request":
                                      if (!widget.isUnAssigned) {
                                        Get.to(() => const RequestQuotationPage(
                                              isUnAssignedRole: true,
                                            ));
                                      }

                                      break;
                                    case "manage":
                                      Get.to(() => const CreateFarmPage());

                                      userController.updateRole('farmer');
                                      break;
                                  }
                                },
                              );
                            },
                            itemCount: updatedChoices().length,
                          ),
                        )),
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
