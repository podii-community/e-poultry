import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../controllers/farm_controller.dart';
import '../../controllers/user_controller.dart';
import '../../theme/spacing.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();
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
              'NEW REQUESTS',
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
                // getFarmReports;
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
                        itemCount: controller.requestsList.length,
                        itemBuilder: (context, index) {
                          String farmName =
                              controller.requestsList[index]["farm"]["name"];
                          String name = controller.requestsList[index]["farm"]
                                  ["owner"]["firstName"]! +
                              " " +
                              controller.requestsList[index]["farm"]["owner"]
                                  ["lastName"]!;
                          String county = controller.requestsList[index]["farm"]
                              ["address"]["county"];
                          String subCounty = controller.requestsList[index]
                              ["farm"]["address"]["subcounty"];
                          String visitPorpose = controller.requestsList[index]
                              ["farmVisit"]["visitPurpose"];
                          DateTime date = DateTime.parse(controller
                              .requestsList[index]["farmVisit"]["visitDate"]);

                          DateTime time = DateTime.parse(
                              controller.requestsList[index]['createdAt']);

                          String formattedTime = DateFormat.jms().format(time);

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
                          String formattedDate =
                              "$day, $dayNumber$dayNumberSuffix ${DateFormat.MMMM().format(date)} ${date.year.toString().substring(2)}";

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xfff6fbff)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "#$visitPorpose",
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      // style: TextStyelsjn,
                                    ),
                                    Text(
                                      formattedTime,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                      // style: TextStyelsjn,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "$farmName visit request on $formattedDate.",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Request by $name"),
                                        Text("$farmName, $county, $subCounty"),
                                      ],
                                    )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            PhosphorIcons.arrowCircleRightBold))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
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
    // final data = fetchRequests.data?['extensionServiceRequests'];

    List requests = [];

    for (var request in fetchRequests.data!["extensionServiceRequests"]) {
      requests.add(request);
    }

    controller.requestsList.value = requests;
  }
}
