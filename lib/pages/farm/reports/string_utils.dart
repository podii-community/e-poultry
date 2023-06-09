extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.inCaps).join(" ");
}
