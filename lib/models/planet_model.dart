class Planet {
  final String name;
  final double? mass;
  final double? radius;
  final double? period;
  final double? semiMajorAxis;
  final double? temperature;
  final double? distanceLightYear;
  final double? hostStarMass;
  final double? hostStarTemperature;

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