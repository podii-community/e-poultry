import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../controllers/farm_controller.dart';

class FarmService {
  final FarmsController controller =
      Get.put(FarmsController(), permanent: true);

  String farmReports() {
    return """
          query GetFarmReports(\$filter: FarmReportsFilterInput!) {
           farmReports(filter: \$filter){
             farmId,
            reportDate
           }
          }    
      """;
  }

  Future<void> getFarmReports(BuildContext context, String id) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var fetchReports = await client.query(QueryOptions(
        operationName: "GetFarmReports",
        document: gql(farmReports()),
        variables: {
          "filter": {"farmId": id}
        }));

    List reports = [];

    for (var report in fetchReports.data!["farmReports"]) {
      reports.add(report);
    }

    controller.reportsList(reports);
  }
}
