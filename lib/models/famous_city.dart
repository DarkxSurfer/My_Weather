class FamousCity {
  final String name;
  final double lat;
  final double lon;
  double? temperature;
  String? weatherDescription;

  FamousCity({
    required this.name,
    required this.lat,
    required this.lon,
    this.temperature,
    this.weatherDescription,
  });
}
