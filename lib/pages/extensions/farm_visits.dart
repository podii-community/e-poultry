import 'dart:ui';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/farm_controller.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/error.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/gradient_widget.dart';
import '../../widgets/loading_spinner.dart';
import '../../widgets/success_widget.dart';
import 'farm_visit_report.dart';

class FarmVisits extends StatefulWidget {
  const FarmVisits({super.key});

  @override
  State<FarmVisits> createState() => _FarmVisitsState();
}

class _FarmVisitsState extends State<FarmVisits> {
  bool dealStatus = true;
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
  String? id;
  @override
  void didChangeDependencies() {
    getFarmRequests(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            const Text(
              'FARM VISIT REQUESTS',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Obx(() {
                return controller.requestsList.isEmpty
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xfff6fbff)),
                          child: const Text(
                            "Your new service requests will appear here .",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.requestsList
                            .where((element) => element["farmVisit"] != null)
                            .length,
                        itemBuilder: (context, index) {
                          var filteredList = List.from(controller.requestsList
                              .where(
                                  (element) => element["farmVisit"] != null));
                          String? farmName =
                              filteredList[index]["farm"]["name"];
                          String status = filteredList[index]["status"];
                          String? name = filteredList[index]["farm"]["owner"]
                                  ["firstName"]! +
                              " " +
                              filteredList[index]["farm"]["owner"]["lastName"]!;
                          String? county =
                              filteredList[index]["farm"]["address"]["county"];
                          String? subCounty = filteredList[index]["farm"]
                              ["address"]["subcounty"];
                          String? visitPorpose =
                              filteredList[index]["farmVisit"]["visitPurpose"];

                          DateTime? time =
                              DateTime.parse(filteredList[index]['createdAt']);

                          DateTime? date =
                              filteredList[index]["farmVisit"] == null
                                  ? DateTime.now()
                                  : DateTime.parse(filteredList[index]
                                      ["farmVisit"]["visitDate"]);

                          String? formattedTime = DateFormat.jms().format(time);

                          String id = filteredList[index]["id"];

                          String day = DateFormat.EEEE().format(date);
                          String dayNumberSuffix = 'th';
                          int dayNumber = date.day;
                          if (dayNumber == 1 ||
                              dayNumber == 21 ||
                              dayNumber == 31) {
                            dayNumberSuffix = 'st';
                          } else if (dayNumber == 2 || dayNumber == 22) {
                            dayNumberSuffix = 'nd';
                          } else if (dayNumber == 3 || dayNumber == 23) {
                            dayNumberSuffix = 'rd';
                          }
                          String? formattedDate =
                              "$day, $dayNumber$dayNumberSuffix ${DateFormat.MMMM().format(date)} ${date.year.toString()}";
//  || status == "PENDING"
                          return (status == "ACCEPTED")
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xfff6fbff)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "#$status",
                                        style: const TextStyle(
                                            color: Colors.green),
                                        // style: TextStyelsjn,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "You will be visiting $farmName in $county, $subCounty Sub-county on $formattedDate .",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        // onTap: () => const FarmVisitReport(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextButton.icon(
                                                onPressed: () {
                                                  Get.to(
                                                    () =>
                                                        const FarmVisitReport(),
                                                  );
                                                },
                                                icon: const Icon(
                                                  PhosphorIcons.plusCircle,
                                                  size: 32.0,
                                                  color: Colors.black,
                                                ),
                                                label: const Text(
                                                  'Add a Farm Visit Report',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                style: TextButton.styleFrom(
                                                  side: const BorderSide(
                                                      width: 2,
                                                      color: Colors.black26),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Text(
                                      //   formattedTime,
                                      //   style: const TextStyle(
                                      //     color: Colors.grey,
                                      //     fontSize: 12,
                                      //   ),
                                      //   // style: TextStyelsjn,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //         child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text("Request by $name"),
                                      //         Text(
                                      //             "$farmName, $county, $subCounty"),
                                      //       ],
                                      //     )),
                                      //     IconButton(
                                      //         onPressed: () {
                                      //           // filteredList[index];
                                      //           // Get.to(() => const RequestsPage());
                                      //         },
                                      //         icon: const Icon(PhosphorIcons
                                      //             .arrowCircleRightBold))
                                      //   ],
                                      // )
                                    ],
                                  ),
                                )
                              : Mutation(
                                  options: MutationOptions(
                                    document: gql(context.queries
                                        .acceptExtensionRequest()),
                                    onCompleted: (data) =>
                                        _onCompleted(data, context),
                                  ),
                                  builder: (RunMutation runMutation,
                                      QueryResult? result) {
                                    // log("${result}");
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

                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xfff6fbff)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "#$status",
                                            style: const TextStyle(
                                                color: Colors.green),
                                            // style: TextStyelsjn,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "$name would like you to visit $farmName in  $county, $subCounty Sub-county on $formattedDate .",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            // onTap: () => const FarmVisitReport(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextButton.icon(
                                                    onPressed: () {
                                                      setState(() {
                                                        id = filteredList[index]
                                                            ["id"];
                                                      });
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 5,
                                                                    sigmaY: 5),
                                                            child: SimpleDialog(
                                                              // title: const Text('Confirm'),
                                                              children: [
                                                                Container(
                                                                  height: 10,
                                                                  alignment:
                                                                      FractionalOffset
                                                                          .topRight,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .clear),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                      "#ACCEPT"),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "You will be visiting $farmName in $county, $subCounty Sub-county on $formattedDate .",
                                                                  ),
                                                                ),
                                                                SimpleDialogOption(
                                                                  onPressed:
                                                                      () {
                                                                    // Confirm action
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      GradientWidget(
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          _acceptFarmVisitRequest(
                                                                              context,
                                                                              runMutation);

                                                                          // Navigator.pop(
                                                                          //     context);
                                                                        },
                                                                        style: ElevatedButton.styleFrom(foregroundColor: CustomColors.background, backgroundColor: Colors.transparent, disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12), shadowColor: Colors.transparent, fixedSize: Size(100.w, 6.h)),
                                                                        child: Text(
                                                                          'CONFIRM',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                2.4.h,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon:
                                                        const Icon(Icons.check),
                                                    label: const Text('Accept'),
                                                    style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 3.0,
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: TextButton.icon(
                                                    onPressed: () {
                                                      acceptRequestDialog(
                                                          context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.call),
                                                    label: const Text('Call'),
                                                    style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 3.0,
                                                          color: Colors.amber),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Text(
                                          //   formattedTime,
                                          //   style: const TextStyle(
                                          //     color: Colors.grey,
                                          //     fontSize: 12,
                                          //   ),
                                          //   // style: TextStyelsjn,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //         child: Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.start,
                                          //       children: [
                                          //         Text("Request by $name"),
                                          //         Text(
                                          //             "$farmName, $county, $subCounty"),
                                          //       ],
                                          //     )),
                                          //     IconButton(
                                          //         onPressed: () {
                                          //           // filteredList[index];
                                          //           // Get.to(() => const RequestsPage());
                                          //         },
                                          //         icon: const Icon(PhosphorIcons
                                          //             .arrowCircleRightBold))
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    );

                                    // GradientWidget(
                                    //   child: ElevatedButton(
                                    //     onPressed: () =>

                                    //     style: ElevatedButton.styleFrom(
                                    //         foregroundColor:
                                    //             CustomColors.background,
                                    //         backgroundColor: Colors.transparent,
                                    //         disabledForegroundColor: Colors
                                    //             .transparent
                                    //             .withOpacity(0.38),
                                    //         disabledBackgroundColor: Colors
                                    //             .transparent
                                    //             .withOpacity(0.12),
                                    //         shadowColor: Colors.transparent,
                                    //         fixedSize: Size(100.w, 6.h)),
                                    //     child: Text(
                                    //       'REQUEST',
                                    //       style: TextStyle(
                                    //         fontSize: 1.8.h,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  });
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );

    // return SingleChildScrollView(
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           dealStatus
    //               ? Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     const Text(
    //                       'FARM VISIT REQUESTS',
    //                       textAlign: TextAlign.left,
    //                       style: TextStyle(
    //                           color:
    //                               Color.fromRGBO(1, 33, 56, 0.6000000238418579),
    //                           fontFamily: 'Roboto',
    //                           fontSize: 12,
    //                           letterSpacing: 0.15000000596046448,
    //                           fontWeight: FontWeight.normal,
    //                           height: 1),
    //                     ),
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     const Text(
    //                       'Odongo odongo would like you to visit Teriq farm in Vihiga, sublocation, ward on Monday, 17th October 2022.',
    //                       textAlign: TextAlign.left,
    //                       style: TextStyle(
    //                           color: Color.fromRGBO(1, 33, 56, 1),
    //                           fontFamily: 'DM Sans',
    //                           fontSize: 16,
    //                           letterSpacing: -0.23999999463558197,
    //                           fontWeight: FontWeight.normal,
    //                           height: 1.375),
    //                     ),
    //                     const SizedBox(height: 20),
    //                     const Text(
    //                       'Today 4:00pm',
    //                       textAlign: TextAlign.left,
    //                       style: TextStyle(
    //                           color:
    //                               Color.fromRGBO(1, 33, 56, 0.3799999952316284),
    //                           fontFamily: 'Open Sans',
    //                           fontSize: 10,
    //                           letterSpacing: 0,
    //                           fontWeight: FontWeight.normal,
    //                           height: 1.6),
    //                     ),
    //                     const SizedBox(height: 20),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [

    //                         const SizedBox(width: 20),

    //                       ],
    //                     ),
    //                   ],
    //                 )
    //               : Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     const Text(
    //                       'FARM VISIT REQUESTS',
    //                       textAlign: TextAlign.left,
    //                       style: TextStyle(
    //                           color:
    //                               Color.fromRGBO(1, 33, 56, 0.6000000238418579),
    //                           fontFamily: 'Roboto',
    //                           fontSize: 12,
    //                           letterSpacing: 0.15000000596046448,
    //                           fontWeight: FontWeight.normal,
    //                           height: 1),
    //                     ),
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     const Text(
    //                       '#ACCEPTED',
    //                       textAlign: TextAlign.left,
    //                       style: TextStyle(
    //                           color:
    //                               Color.fromRGBO(1, 33, 56, 0.6000000238418579),
    //                           fontFamily: 'Roboto',
    //                           fontSize: 12,
    //                           letterSpacing: 0.15000000596046448,
    //                           fontWeight: FontWeight.normal,
    //                           height: 1),
    //                     ),
    //                     const SizedBox(
    //                       height: 10,
    //                     ),
    //                     const Text(
    //                       'You will be visiting Teriq farm in Vihiga, sublocation, ward on Monday, 17th October 2022.',
    //                       textAlign: TextAlign.left,
    //                       style: TextStyle(
    //                           color: Color.fromRGBO(1, 33, 56, 1),
    //                           fontFamily: 'DM Sans',
    //                           fontSize: 16,
    //                           letterSpacing: -0.23999999463558197,
    //                           fontWeight: FontWeight.normal,
    //                           height: 1.375),
    //                     ),
    //                     const SizedBox(height: 20),
    // Row(
    //   children: [
    //     Expanded(
    //       child: TextButton.icon(
    //         onPressed: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) =>
    //                   const FarmVisitReport(),
    //             ),
    //           );
    //         },
    //         icon: const Icon(
    //           PhosphorIcons.plusCircle,
    //           size: 32.0,
    //         ),
    //         label: const Text('Add a Farm Visit Report'),
    //         style: TextButton.styleFrom(
    //           side: const BorderSide(
    //               width: 3.0, color: Colors.black26),
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
    //                   ],
    //                 ),
    //           const SizedBox(height: 40),
    //           const Text(
    //             'PREVIOUS FARM VISITS',
    //             textAlign: TextAlign.left,
    //             style: TextStyle(
    //                 color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
    //                 fontFamily: 'Roboto',
    //                 fontSize: 12,
    //                 letterSpacing: 0.15000000596046448,
    //                 fontWeight: FontWeight.normal,
    //                 height: 1),
    //           ),
    //           const SizedBox(height: 20),
    //           Container(
    //             width: double.infinity,
    //             height: 131,
    //             decoration: const BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(10),
    //                 topRight: Radius.circular(10),
    //                 bottomLeft: Radius.circular(10),
    //                 bottomRight: Radius.circular(10),
    //               ),
    //               color: Color.fromRGBO(246, 251, 255, 1),
    //             ),
    //             child: const Center(
    //               child: Text(
    //                 'All your previous reports will appear here',
    //                 textAlign: TextAlign.left,
    //                 style: TextStyle(
    //                     color: Color.fromRGBO(1, 33, 56, 0.3799999952316284),
    //                     fontFamily: 'DM Sans',
    //                     fontSize: 16,
    //                     letterSpacing: -0.23999999463558197,
    //                     fontWeight: FontWeight.normal,
    //                     height: 1.375),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<dynamic> acceptRequestDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SimpleDialog(
            children: [
              Container(
                height: 10,
                alignment: FractionalOffset.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  minLines: 6,
                  maxLines: 8,
                  // controller: firstName,
                  keyboardType: TextInputType.text,
                  // validator: (String? value) {
                  //   if (value!.isEmpty) {
                  //     return 'First Name is required';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                      labelText: "Reason for Decline",
                      labelStyle: TextStyle(
                          fontSize: 2.2.h, color: CustomColors.secondary),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.3.w, color: CustomColors.secondary)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.3.w, color: CustomColors.secondary))),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // Confirm action
                  Navigator.of(context).pop();
                },
                child: GradientWidget(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(
                          fontSize: 2.4.h,
                        ),
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getFarmRequests(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchRequests = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "FarmRequests",
        document: gql(context.queries.farmRequests()),
        variables: const {
          "filter": {"status": "ALL"}
        },
      ),
    );

    List requests = [];

    for (var request in fetchRequests.data!["extensionServiceRequests"]) {
      requests.add(request);
    }

    controller.requestsList.value = requests;
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    Get.back();
    // if ((data['requestMedicalVisit(']['farmId']).toString().isNotEmpty) {
    // Get.to(() => const SuccessWidget(
    //       message:
    //           'You have sucessfully requested for medical help. We’ll notify you as soon as there is a Vetinary officer available.',
    //       route: 'dashboard',
    //     ));
    // }
  }

  Future<void> _acceptFarmVisitRequest(
      BuildContext context, RunMutation runMutation) async {
    runMutation({
      "data": {
        {"extensionServiceId": id}
      },
    });
  }

  // Future<void> acceptExtensionService(BuildContext context,) async {

  // }
}
