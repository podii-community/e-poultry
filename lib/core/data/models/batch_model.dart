import 'package:epoultry/features/pages/farm/batch/create_batch_page.dart';

class BatchModel {
  final String? id;
  final String name;
  final BirdTypes? type;
  final int? birdAge;
  final int? birdCount;
  final AgeTypes? ageType;
  final String? date;
  final String? farmId;
  final bool? selected;

  const BatchModel(
      {this.id,
      required this.name,
      required this.type,
      required this.birdAge,
      required this.birdCount,
      required this.ageType,
      required this.date,
      required this.farmId,
      this.selected = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'birdCount': birdCount,
      'birdAge': birdAge,
      'units': ageType,
      'date': date,
      'farmId': farmId
    };
  }

  BatchModel.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        name = item["name"],
        type = BirdTypes.values.byName(item["birdType"]),
        birdAge = item["birdAge"],
        birdCount = item['birdCount'],
        ageType = AgeTypes.values.byName(item["ageType"]),
        farmId = item['farmId'],
        selected = item['selected'],
        date = item["date"];
}

class BatchesList {
  final List<BatchModel> batches;

  BatchesList.allBatchesFromJson(Map<String, dynamic> json)
      : batches =
            json['batches'].list.map((e) => BatchModel.fromMap(e)).toList();
}
