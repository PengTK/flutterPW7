import 'package:flutter/material.dart';
import '../models/planet_model.dart';

class ComparisonScreen extends StatelessWidget {
  final Planet planet1, planet2;

  const ComparisonScreen({super.key, required this.planet1, required this.planet2});

  @override
  Widget build(BuildContext context) {
    final fields = [
      ('Масса', planet1.mass, planet2.mass),
      ('Радиус', planet1.radius, planet2.radius),
      ('Орбитальный период (дни)', planet1.period, planet2.period),
      ('Большая полуось (а.е.)', planet1.semiMajorAxis, planet2.semiMajorAxis),
      ('Температура (K)', planet1.temperature, planet2.temperature),
      ('Расстояние (св. года)', planet1.distanceLightYear, planet2.distanceLightYear),
      ('Масса звезды', planet1.hostStarMass, planet2.hostStarMass),
      ('Температура звезды (K)', planet1.hostStarTemperature, planet2.hostStarTemperature),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('${planet1.name} vs ${planet2.name}')),
      body: ListView.builder(
        itemCount: fields.length,
        itemBuilder: (context, i) {
          final (label, v1, v2) = fields[i];
          String formatValue(double? v) => v != null ? v.toStringAsFixed(4) : '—';
          return ListTile(
            title: Text(label),
            subtitle: Text('${formatValue(v1)} vs ${formatValue(v2)}'),
          );
        },
      ),
    );
  }
}