import 'package:get/get.dart';

class FarmsController extends GetxController {
  final farm = {}.obs;
  final farms = [].obs;
  final batchesList = [].obs;
  final reportsList = [].obs;
  final selectedBatch = {}.obs;

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
}
