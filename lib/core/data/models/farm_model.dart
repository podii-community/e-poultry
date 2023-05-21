class FarmModel {
  final String? id;
  final String name;

  const FarmModel({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  FarmModel.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        name = item["name"];
}
