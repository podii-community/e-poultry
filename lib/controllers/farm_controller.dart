import 'package:epoultry/services/farm_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class FarmsController extends GetxController {
  final farm = {}.obs;
  final farms = [].obs;
  final selectedFarmId = "".obs;
  final batchesList = [].obs;
  final reportsList = [].obs;
  final filteredReports = [].obs;
  final selectedBatch = {}.obs;
  final storeItems = [].obs;

  final selectedCountyName = "".obs;
  final selectedSubCountyName = "Choose subcounty".obs;
  final selectedWardName = "Choose ward".obs;

  final filteredSubCounties = [""].obs;
  final filteredWards = [""].obs;

  final report = {
    "data": {
      "batchId": "".obs,
      "birdCounts": [].obs,
      "briquettesReport": {
        "inStore": {}.obs,
        "received": {}.obs,
        "used": {}.obs
      },
      "eggCollection": {
        "brokenCount": "".obs,
        "comments": "".obs,
        "eggCount": "".obs,
        "largeCount": "".obs,
        "smallCount": "".obs,
        "deformedCount": "".obs,
      },
      "feedsReport": {"inStore": [].obs, "received": [].obs, "used": [].obs},
      "medicationsReport": {
        "inStore": [].obs,
        "received": [].obs,
        "used": [].obs
      },
      "reportDate": "".obs,
      "sawdustReport": {"inStore": {}.obs, "received": {}.obs, "used": {}.obs},
      "weightReport": {"averageWeight": "".obs}
    }
  };

  final selectedReport = {}.obs;
  final farmReport = {}.obs;

  var fetchedReports = [].obs;

  applySubCounties(List<String> subCounties) {
    filteredSubCounties(subCounties);
  }

  applyWards(List<String> wards) {
    filteredWards(wards);
  }

  updateFarm(dynamic selectedFarm) {
    farm(selectedFarm);
  }

  updateFarms(farm) {
    farms(farm);
  }

  updateBatches(batches) {
    batchesList(batches);
  }

  updateReports(reports) {
    reportsList(reports);
  }

  selectBatch(batch) {
    selectedBatch(batch);
  }

  setStoreItems(items) {
    storeItems(items);
  }

  void fetchReports() async {
    // var reports = FarmService().getFarmReports(farm['id']);
  }
}
