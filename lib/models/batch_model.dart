class Batches {
  final int? id;
  final String name;
  final String type;
  final String age;
  final String quantity;
  final String units;
  final String date;

  const Batches({
    this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.age,
    required this.units,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'age': age,
      'units': units,
      'date': date
    };
  }

  Batches.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        name = item["name"],
        type = item["type"],
        age = item["age"],
        quantity = item['quantity'],
        units = item["units"],
        date = item["date"];
}
