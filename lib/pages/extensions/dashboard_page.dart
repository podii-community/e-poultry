import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/extensions/requests_page.dart';
import 'package:epoultry/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/farm_controller.dart';
import '../../data/models/error.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/gradient_text.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = Get.find<FarmsController>();
  // final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Query(
                options: QueryOptions(
                  document: gql(context.queries.getFarm()),
                  variables: {'farmId': controller.farm.value['id']},
                  fetchPolicy: FetchPolicy.noCache,
                  // pollInterval: const Duration(seconds: 2),
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

                  final data = result.data?['getFarm'];

                  getFarmReports(context);
                  // getFeeds(context);

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.batchesList(data["batches"]);
                    // controller.requestsList(reports);
                    controller.setStoreItems(data["storeItems"]);
                  });

                  return SizedBox(
                    height: 15.h,
                    child: Card(
                        elevation: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "OVERVIEW",
                                style: TextStyle(fontSize: 2.2.h),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Flexible(
                              // height: 12.h,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: CustomSpacing.s1),
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  shrinkWrap: true,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "No of Birds",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 2.h),
                                        ),
                                        GradientText(
                                          "${data["birdCount"] ?? 0}",
                                          style: TextStyle(
                                              color: CustomColors.primary,
                                              fontSize: 3.5.h,
                                              fontWeight: FontWeight.w600),
                                          gradient:
                                              CustomColors.primaryGradient,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Eggs in Store",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 2.h),
                                        ),
                                        GradientText(
                                          "${data["eggCount"] ?? 0}",
                                          style: TextStyle(
                                              color: CustomColors.primary,
                                              fontSize: 3.5.h,
                                              fontWeight: FontWeight.w600),
                                          gradient:
                                              CustomColors.primaryGradient,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Feeds Used",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 2.h),
                                        ),
                                        GradientText(
                                          "${data["feedsUsage"] ?? 0} Kgs",
                                          style: TextStyle(
                                              color: CustomColors.primary,
                                              fontSize: 3.5.h,
                                              fontWeight: FontWeight.w600),
                                          softWrap: false,
                                          gradient:
                                              CustomColors.primaryGradient,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
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
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color.fromRGBO(246, 251, 255, 1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => controller.requestsList.isEmpty
                        ? Card(
                            elevation: 4,
                            shadowColor: CustomColors.secondary,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 1.5.h),
                              child: Row(
                                children: [
                                  Icon(
                                    PhosphorIcons.info,
                                    size: 8.w,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'What is a report?',
                                        style: TextStyle(fontSize: 4.w),
                                      ),
                                      Text(
                                        'A general overview of the farm',
                                        style: TextStyle(
                                            fontSize: 3.w, color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.requestsList.length < 3
                                ? controller.requestsList.length
                                : 3,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                trailing: const Icon(
                                  PhosphorIcons.arrowRightBold,
                                  color: Colors.black,
                                ),
                                title: Text("Farm Report",
                                    style: TextStyle(fontSize: 1.9.h)),
                                subtitle: Text(
                                    "${controller.requestsList[index]["reportDate"]}"),
                                onTap: () {
                                  controller.selectedReport(
                                      controller.requestsList[index]);

                                  // Get.to(() => ViewReportPage());
                                },
                                tileColor: CustomColors.background,
                                textColor: Colors.black,
                              );
                            }))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '#MEDICAL HELP',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Calvin Mokua would like you to visit New farm in Kisumu, Kisumu East , ward on Monday, 2023-01-10.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(1, 33, 56, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 16,
                              letterSpacing: -0.23999999463558197,
                              fontWeight: FontWeight.normal,
                              height: 1.375),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Request by Odongo Odongo \n Teriq farm, Vihiga, sub, ward',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(1, 33, 56, 1),
                                  fontFamily: 'Open Sans',
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6),
                            ),
                            IconButton(
                              icon: const Icon(
                                  PhosphorIcons.arrowCircleRightBold),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RequestsPage(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getFarmReports(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchReports = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "GetFarmRequests",
        document: gql(context.queries.getFarmReports()),
        variables: const {
          "filter": {
            "farmId": {'907fc899-a51e-4999-8be9-ba0591749517'}
          }
        }));

    List reports = [];

    for (var report in fetchReports.data!["farmReports"]) {
      reports.add(report);
    }

    controller.requestsList.value = reports;
  }
}
