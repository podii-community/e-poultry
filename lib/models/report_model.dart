class Report {
  final int? id;
  final String? reduceBy;
  final String? reason;
  final String? typeOfFeed;
  final String? quantity;
  final String? measurement;
  final String? eggsCollected;
  final String? mediumEggs;
  final String? largeEggs;
  final String? fullyBroken;
  final String? partiallyBroken;
  final String? deformedEggs;
  final String? comment;
  final String? date;

  const Report(
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

  Report.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        reduceBy = item["reduceBy"],
        reason = item["reason"],
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
