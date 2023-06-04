import 'dart:ui';
import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/presentation/controllers/farm_controller.dart';
import '../../core/domain/models/error.dart';
import '../../core/theme/colors.dart';
import '../../core/presentation/components/gradient_widget.dart';
import '../../core/presentation/components/loading_spinner.dart';
import '../../core/presentation/components/success_widget.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key, this.extensionServiceId}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final extensionServiceId;

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  String? testid;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FarmsController>();
    var filteredList = controller.requestsList
        .where((element) => element["id"] == widget.extensionServiceId)
        .toList();

    String? farmName = controller.requestsList[0]["farm"]["name"];
    String? status = filteredList[0]["status"];
    String? name = controller.requestsList[0]["farm"]["owner"]["firstName"]! +
        " " +
        controller.requestsList[0]["farm"]["owner"]["lastName"]!;
    String id = widget.extensionServiceId;
    String? county =
        controller.requestsList[0]["farm"]["address"]["county"] ?? "Kisumu";
    String? subCounty = controller.requestsList[0]["farm"]["address"]
            ["subcounty"] ??
        "Kisumu East";
    String? visitPorpose = "Medical Help";
    String imageUrl = controller.requestsList[0]["attachments"][0]["url"];
    String? description = filteredList[0]["medicalVisit"]["description"] ??
        "No description available";

    String? ageType = filteredList[0]["medicalVisit"]["ageType"];
    String? birdAge = filteredList[0]["medicalVisit"]["birdAge"].toString();
    String? birdCount = filteredList[0]["medicalVisit"]["birdCount"].toString();
    String? birdType = filteredList[0]["medicalVisit"]["birdType"];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        title: Text(
          farmName!,
          style: const TextStyle(color: Colors.black),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "#$visitPorpose",
              style: TextStyle(
                fontSize: 18,
                color:
                    visitPorpose == "Medical Help" ? Colors.red : Colors.blue,
              ),
              // style: TextStyelsjn,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              description!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  width: 2,
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl), // replace with your image URL
                  fit: BoxFit.cover,
                ),
                // borderRadius: const BorderRadius.all(
                //   Radius.elliptical(88, 88),
                // ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Type of bird: $birdType',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            Text(
              'Age of birds: $birdAge, $ageType',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            Text(
              'No of birds: $birdCount',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Request by $name',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            Text(
              '$farmName, $county, $subCounty',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            // Text(
            //   '$formattedDate, $formattedTime',
            //   textAlign: TextAlign.left,
            //   style: const TextStyle(
            //       color: Color.fromRGBO(1, 33, 56, 1),
            //       fontFamily: 'Roboto',
            //       fontSize: 18,
            //       letterSpacing: 0.15000000596046448,
            //       fontWeight: FontWeight.normal,
            //       height: 1),
            // ),
            const SizedBox(
              height: 60,
            ),
            (status == "PENDING")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              testid = id;
                            });

                            acceptRequestDialog(
                              context,
                              id,
                              farmName,
                              county,
                              subCounty,
                            );
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Accept'),
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                                width: 3.0, color: Colors.green),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            // ignore: deprecated_member_use
                            launch('tel:+254742088393');

                            setState(() {
                              testid = id;
                            });
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.call),
                          label: const Text('Call'),
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                                width: 3.0, color: Colors.amber),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<dynamic> acceptRequestDialog(
    BuildContext context,
    String? id,
    String? farmName,
    String? county,
    String? subCounty,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SimpleDialog(
            // title: const Text('Confirm'),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("#ACCEPT"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You will be visiting $farmName in $county, $subCounty Sub-county .",
                ),
              ),
              Mutation(
                options: MutationOptions(
                  document: gql(context.queries.acceptExtensionRequest()),
                  operationName: "AcceptExtensionRequestService",
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
                  return SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: GradientWidget(
                      child: ElevatedButton(
                          onPressed: () {
                            _acceptFarmVisitRequest(context, runMutation);
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
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if (data != null) {
      Get.to(() => const SuccessWidget(
            message:
                'You have sucessfully requested for medical help. We’ll notify you as soon as there is a Vetinary officer available.',
            route: 'extension',
          ));
    }
  }

  Future<void> _acceptFarmVisitRequest(
      BuildContext context, RunMutation runMutation) async {
    runMutation({"extensionServiceId": testid});
  }
}
