class Planet {
  final String name;
  final double? mass; // масса планеты (в массах Юпитера)
  final double? radius; // радиус (в радиусах Юпитера)
  final double? period; // орбитальный период (дни)
  final double? semiMajorAxis; // большая полуось (а.е.)
  final double? temperature; // температура (K)
  final double? distanceLightYear; // расстояние до Земли (световые годы)
  final double? hostStarMass; // масса звезды (в массах Солнца)
  final double? hostStarTemperature; // температура звезды (K)

  Planet({
    required this.name,
    this.mass,
    this.radius,
    this.period,
    this.semiMajorAxis,
    this.temperature,
    this.distanceLightYear,
    this.hostStarMass,
    this.hostStarTemperature,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'] ?? '',
      mass: _toDouble(json['mass']),
      radius: _toDouble(json['radius']),
      period: _toDouble(json['period']),
      semiMajorAxis: _toDouble(json['semi_major_axis']),
      temperature: _toDouble(json['temperature']),
      distanceLightYear: _toDouble(json['distance_light_year']),
      hostStarMass: _toDouble(json['host_star_mass']),
      hostStarTemperature: _toDouble(json['host_star_temperature']),
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}