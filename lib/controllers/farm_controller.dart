import 'package:epoultry/pages/extensions/farm_visit_report.dart';
import 'package:get/get.dart';

class FarmsController extends GetxController {
  final farm = {}.obs;
  final farms = [].obs;
  final selectedFarmId = "".obs;
  final batchesList = [].obs;
  final reportsList = [].obs;
  final requestsList = [].obs;
  final filteredReports = [].obs;
  final selectedBatch = {}.obs;
  final storeItems = [].obs;
  final feedList = <String>[].obs;
  final kienyejiFeed = <String>[].obs;
  final broilerFeeds = <String>[].obs;
  final layersFeeds = <String>[].obs;
  final vaccinationList = [].obs;
  final extensionRequests = [].obs;

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

  final farmVisitReport = {
    "data": {
      "compound": {
        "landscape": "".obs,
        "security": "".obs,
        "tankCleanliness": "".obs,
      },
      "extensionServiceId": "".obs,
      "farmInformation": {
        "ageType": "".obs,
        "birdAge": 0.obs,
        "birdType": "".obs,
        "deliveredBirdCount": 0.obs,
        "farmAssistantContact": "".obs,
        "farmOfficerContact": "".obs,
        "mortality": 0.obs,
        "remainingBirdCount": 0.obs
      },
      "farmTeam": {
        "cleanliness": "".obs,
        "gumboots": "".obs,
        "uniforms": "".obs,
      },
      "generalObservation": "".obs,
      "housingInspection": {
        "bioSecurity": "".obs,
        "cobwebs": "".obs,
        "drinkers": "".obs,
        "dust": "".obs,
        "feeders": "".obs,
        "lighting": "".obs,
        "repairAndMaintainance": "".obs,
        "ventilation": "".obs,
      },
      "recommendations": "".obs,
      "store": {
        "cleanliness": "".obs,
        "arrangement": "".obs,
        "stockTake": "".obs,
      },
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

  updateFarm(selectedFarm) {
    farm(selectedFarm);
  }

  updateFarms(farmsList) {
    farms(farmsList);
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
