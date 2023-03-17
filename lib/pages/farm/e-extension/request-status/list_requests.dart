import 'dart:developer';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/e-extension/request-status/request_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/farm_controller.dart';
import '../../../../data/models/error.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/spacing.dart';
import '../../../../widgets/error_widget.dart';
import '../../../../widgets/loading_spinner.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({super.key});

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
  @override
  void didChangeDependencies() {
    getExtensionServiceRequest(context);
    super.didChangeDependencies();
  }

  final controller = Get.find<FarmsController>();

  Future<void> getExtensionServiceRequest(BuildContext context) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchDetails = await client.query(QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      operationName: "ExtensionServiceRequest",
      variables: {
        "filter": {"farmId": controller.farm.value['id']}
      },
      document: gql(context.queries.getExtensionServiceRequests()),
    ));

    if (fetchDetails.data!.isNotEmpty) {
      controller
          .extensionRequests(fetchDetails.data!['extensionServiceRequests']);
    }
  }

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

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
            'Request Status',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: Query(
                options: QueryOptions(
                  document: gql(context.queries.getExtensionServiceRequests()),
                  fetchPolicy: FetchPolicy.networkOnly,
                  operationName: "ExtensionServiceRequest",
                  variables: {
                    "filter": {"farmId": controller.farm.value['id']}
                  },
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

                  if (result.data!.isNotEmpty) {
                    controller.extensionRequests(
                        result.data!['extensionServiceRequests']);
                  }
                  return controller.extensionRequests.isEmpty
                      ? const Center(
                          child: Text(
                              "You have not made any extension service requests"),
                        )
                      : Obx((() => ListView.builder(
                          itemCount: controller.extensionRequests.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => RequestDetails(
                                      request:
                                          controller.extensionRequests[index],
                                    ));
                              },
                              child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('TODAY'),
                                      const SizedBox(
                                        height: CustomSpacing.s1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.extensionRequests[index]
                                                        ["farmVisit"] !=
                                                    null
                                                ? "Farm Visit Request"
                                                : "Medical Visit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 2.1.h),
                                          ),
                                          Text(formatter.format(formatter.parse(
                                              controller
                                                      .extensionRequests[index]
                                                  ['createdAt'])))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: CustomSpacing.s1,
                                      ),
                                      Text(
                                          "${controller.extensionRequests[index]["farmVisit"] != null ? controller.extensionRequests[index]["farmVisit"]["visitPurpose"] : "Medical Visit"}"),
                                      const SizedBox(
                                        height: CustomSpacing.s2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '#${controller.extensionRequests[index]["status"]}',
                                            style:
                                                TextStyle(color: Colors.yellow),
                                          ),
                                          Icon(PhosphorIcons.arrowRight)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }))));
                })));
  }
}
