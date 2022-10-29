import '../../pages/farm/reports/number_birds_page.dart';

class ReportModel {
  final int? id;
  final int? reduceBy;
  final Reasons? reason;
  final String? typeOfFeed;
  final String? quantity;
  final String? measurement;
  final int? eggsCollected;
  final int? mediumEggs;
  final int? largeEggs;
  final int? fullyBroken;
  final int? partiallyBroken;
  final int? deformedEggs;
  final String? comment;
  final String? date;

  const ReportModel(
      {this.id,
      this.reduceBy,
      this.reason,
      this.typeOfFeed,
      this.quantity,
      this.measurement,
      this.eggsCollected,
      this.mediumEggs,
      this.largeEggs,
      this.fullyBroken,
      this.partiallyBroken,
      this.deformedEggs,
      this.comment,
      this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reduceBy': reduceBy,
      'reason': reason,
      'typeOfFeed': typeOfFeed,
      'quantity': quantity,
      'measurement': measurement,
      'eggsCollected': eggsCollected,
      'mediumEggs': mediumEggs,
      'largeEggs': largeEggs,
      'fullyBroken': fullyBroken,
      'partiallyBroken': partiallyBroken,
      'deformedEggs': deformedEggs,
      'comment': comment,
      'date': date
    };
  }

  ReportModel.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        reduceBy = item["reduceBy"],
        reason = Reasons.values.byName(item["reason"]),
        typeOfFeed = item["typeOfFeed"],
        quantity = item['quantity'],
        measurement = item["measurement"],
        eggsCollected = item["eggsCollected"],
        mediumEggs = item["mediumEggs"],
        largeEggs = item["largeEggs"],
        fullyBroken = item["fullyBroken"],
        partiallyBroken = item['partiallyBroken'],
        deformedEggs = item["deformedEggs"],
        comment = item["comment"],
        date = item["date"];
}

class BirdsReducedModel {
  final int? id;
  final int? reduceBy;
  final String? reason;
  final String? sellingPrice;

  const BirdsReducedModel(
      {this.id, this.reduceBy, this.reason, this.sellingPrice});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reduceBy': reduceBy,
      'reason': reason,
      'sellingPrice': sellingPrice
    };
  }

  BirdsReducedModel.fromMap(Map<String, dynamic> item)
      : id = item['id'],
        reduceBy = item['reduceBy'],
        reason = item['reason'],
        sellingPrice = item['sellingPrice'];
}
