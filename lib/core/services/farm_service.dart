import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../presentation/controllers/farm_controller.dart';

class FarmService {
  final controller = Get.find<FarmsController>();

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
        fetchPolicy: FetchPolicy.networkOnly,
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
