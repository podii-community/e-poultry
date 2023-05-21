class DashboardModel {
  DashboardModel(
      {required this.birdCount,
      required this.eggCount,
      // required this.storeFeed,
      required this.farmName,
      required this.owner});

  final String? owner;
  final String? farmName;
  final int? birdCount;
  final int? eggCount;
  // final

  DashboardModel.fromJson(Map<String, dynamic> data)
      : owner = data['owner'],
        farmName = data['farmName'],
        birdCount = data['imageUrl'],
        eggCount = data['description'];

  DashboardModel.dummy({int id_ = 0})
      : owner = "Odongo",
        farmName = "Odongo Farm",
        birdCount = 20,
        eggCount = 20;
}
