import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:epoultry/core/presentation/components/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/presentation/controllers/farm_controller.dart';
import '../../../core/domain/models/error.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/presentation/components/loading_spinner.dart';

class AddFarmManagerPage extends StatefulWidget {
  const AddFarmManagerPage({Key? key}) : super(key: key);

  @override
  State<AddFarmManagerPage> createState() => _AddFarmManagerPageState();
}

class _AddFarmManagerPageState extends State<AddFarmManagerPage> {
  final controller = Get.find<FarmsController>();
  final selectedFarmId = TextEditingController();
  bool valueSelected = false;
  String selectedFarmName = "";

  @override
  void initState() {
    selectedFarmId.text = controller.farm['id'];

    super.initState();
  }

  String inviteCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Get.back();
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: CustomSpacing.s2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select Farm",
                style: TextStyle(fontSize: 3.h),
              ),
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),

            Mutation(
              options: MutationOptions(
                operationName: "CreateInvite",
                document: gql(context.queries.createInvite()),
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
                return DropdownButtonFormField<String>(
                    // value: selectedFarmId.text,
                    hint: Text(
                      valueSelected ? selectedFarmName : 'Select Farm',
                    ),
                    onChanged: (farmId) {
                      setState(() {
                        selectedFarmId.text = farmId!;
                        valueSelected = true;
                      });
                      _farmIdChanged(context, runMutation);
                    },
                    validator: (value) =>
                        value == null ? 'field required' : null,
                    items: controller.farms.map((value) {
                      return DropdownMenuItem(
                        onTap: () {
                          selectedFarmName = value["name"];
                        },
                        value: value["id"].toString(),
                        child: Text(value["name"]),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                        labelText: "Name of Farm",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))));
              },
            ),

            // Query(
            //   options: QueryOptions(
            //     document: gql(context.queries.getFarms()),
            //     fetchPolicy: FetchPolicy.noCache,
            //     pollInterval: const Duration(minutes: 2),
            //   ),
            //   builder: (QueryResult result,
            //       {VoidCallback? refetch, FetchMore? fetchMore}) {
            //     if (result.isLoading) {
            //       return const LoadingSpinner();
            //     }
            //     if (result.hasException) {
            //       return AppErrorWidget(
            //         error: ErrorModel.fromString(
            //           result.exception.toString(),
            //         ),
            //       );
            //     }

            //     if ((result.data?['user']!["managingFarms"]).isNotEmpty) {
            //       List farms = result.data?["user"]?["managingFarms"];

            //       selectedFarmId.text = farms.first["id"];
            //       return farms.isEmpty
            //           ? const Center(
            //               child: Text("No Farms"),
            //             )
            //       : Mutation(
            //           options: MutationOptions(
            //             operationName: "CreateInvite",
            //             document: gql(context.queries.createInvite()),
            //             onCompleted: (data) => _onCompleted(data, context),
            //           ),
            //           builder:
            //               (RunMutation runMutation, QueryResult? result) {
            //             if (result != null) {
            //               if (result.isLoading) {
            //                 return const LoadingSpinner();
            //               }

            //               if (result.hasException) {
            //                 context.showError(
            //                   ErrorModel.fromGraphError(
            //                     result.exception?.graphqlErrors ?? [],
            //                   ),
            //                 );
            //               }
            //             }
            //             return DropdownButtonFormField<String>(
            //                 value: selectedFarmId.text,
            //                 hint: const Text(
            //                   'Select Farm',
            //                 ),
            //                 onChanged: (String? farmId) {
            //                   setState(() {
            //                     selectedFarmId.text = farmId!;
            //                   });

            //                   _farmIdChanged(context, runMutation);
            //                 },
            //                 validator: (value) =>
            //                     value == null ? 'field required' : null,
            //                 items: farms.map((value) {
            //                   return DropdownMenuItem(
            //                     value: value["id"].toString(),
            //                     child: Text(value["name"]),
            //                   );
            //                 }).toList(),
            //                 decoration: InputDecoration(
            //                     labelText: "Name of Farm",
            //                     labelStyle: TextStyle(
            //                         fontSize: 2.2.h,
            //                         color: CustomColors.secondary),
            //                     border: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                             width: 0.3.w,
            //                             color: CustomColors.secondary)),
            //                     focusedBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                             width: 0.3.w,
            //                             color: CustomColors.secondary))));
            //           },
            //         );
            // }

            //     if ((result.data?['user']!["ownedFarms"]).isNotEmpty) {
            //       List farms = result.data?["user"]?["ownedFarms"];

            //       selectedFarmId.text = farms.first["id"];
            //       return farms.isEmpty
            //           ? const Center(
            //               child: Text("No Farms"),
            //             )
            //           : Mutation(
            //               options: MutationOptions(
            //                 operationName: "CreateInvite",
            //                 document: gql(context.queries.createInvite()),
            //                 onCompleted: (data) => _onCompleted(data, context),
            //               ),
            //               builder:
            //                   (RunMutation runMutation, QueryResult? result) {
            //                 if (result != null) {
            //                   if (result.isLoading) {
            //                     return const LoadingSpinner();
            //                   }

            //                   if (result.hasException) {
            //                     context.showError(
            //                       ErrorModel.fromGraphError(
            //                         result.exception?.graphqlErrors ?? [],
            //                       ),
            //                     );
            //                   }
            //                 }
            //                 return DropdownButtonFormField<String>(
            //                     value: selectedFarmId.text,
            //                     hint: const Text(
            //                       'Select Farm',
            //                     ),
            //                     onChanged: (String? farmId) {
            //                       setState(() {
            //                         selectedFarmId.text = farmId!;
            //                       });

            //                       _farmIdChanged(context, runMutation);
            //                     },
            //                     validator: (value) =>
            //                         value == null ? 'field required' : null,
            //                     items: farms.map((value) {
            //                       return DropdownMenuItem(
            //                         value: value["id"].toString(),
            //                         child: Text(value["name"]),
            //                       );
            //                     }).toList(),
            //                     decoration: InputDecoration(
            //                         labelText: "Name of Farm",
            //                         labelStyle: TextStyle(
            //                             fontSize: 2.2.h,
            //                             color: CustomColors.secondary),
            //                         border: OutlineInputBorder(
            //                             borderSide: BorderSide(
            //                                 width: 0.3.w,
            //                                 color: CustomColors.secondary)),
            //                         focusedBorder: OutlineInputBorder(
            //                             borderSide: BorderSide(
            //                                 width: 0.3.w,
            //                                 color: CustomColors.secondary))));
            //               },
            //             );
            //     }

            //     return Container();
            //   },
            // ),

            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            GradientWidget(
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CustomSpacing.s2, vertical: CustomSpacing.s3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Farm Code",
                        style: TextStyle(
                            fontSize: 2.5.h, color: CustomColors.background),
                      ),
                      const SizedBox(
                        height: CustomSpacing.s1,
                      ),
                      Text(
                        "Send the code below to the farm manager to join the farm",
                        style: TextStyle(
                            fontSize: 1.9.h, color: CustomColors.background),
                      ),
                      const SizedBox(
                        height: CustomSpacing.s3,
                      ),
                      Row(
                        children: [
                          Text(
                            " $inviteCode",
                            style: TextStyle(
                                fontSize: 5.2.h,
                                color: CustomColors.background),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                        ClipboardData(text: inviteCode))
                                    .then((_) {
                                  Fluttertoast.showToast(
                                      msg: 'Code copied successfully');
                                });
                              },
                              icon: Icon(
                                PhosphorIcons.copy,
                                color: CustomColors.background,
                                size: 3.2.h,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ));
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    setState(() {
      inviteCode = data["createInvite"]["inviteCode"];
    });
  }

  Future<void> _farmIdChanged(
      BuildContext context, RunMutation runMutation) async {
    runMutation(
      {'farmId': selectedFarmId.text},
    );
  }
}
