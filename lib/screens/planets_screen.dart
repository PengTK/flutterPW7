import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/planet_model.dart';
import 'compression_screen.dart';

class PlanetsScreen extends StatefulWidget {
  const PlanetsScreen({super.key});

  @override
  State<PlanetsScreen> createState() => _PlanetsScreenState();
}

class _PlanetsScreenState extends State<PlanetsScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Planet? _planet1, _planet2;
  bool _loading = false;

  Future<Planet?> _fetchPlanet(String name) async {
  if (name.isEmpty) return null;
  
  try {
    final dio = GetIt.instance<Dio>();
    final res = await dio.get('https://api.api-ninjas.com/v1/planets', queryParameters: {'name': name});
    
    if (res.data is List && (res.data as List).isNotEmpty) {
      final firstItem = (res.data as List).first;
      if (firstItem is Map<String, dynamic>) {
        return Planet.fromJson(firstItem);
      }
    }
    return null;
  } catch (e) {
    rethrow;
  }
}

  void _loadPlanet1() async {
  setState(() => _loading = true);
  try {
    final planet = await _fetchPlanet(_controller1.text.trim());
    if (mounted) {
      if (planet != null) {
        setState(() => _planet1 = planet);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Планета 1 не найдена')));
      }
    }
  } finally {
    if (mounted) setState(() => _loading = false);
  }
}

  void _loadPlanet2() async {
  setState(() => _loading = true);
  try {
    final planet = await _fetchPlanet(_controller2.text.trim());
    if (mounted) {
      if (planet != null) {
        setState(() => _planet2 = planet);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Планета 2 не найдена')));
      }
    }
  } finally {
    if (mounted) setState(() => _loading = false);
  }
}


  void _compare() {
    if (_planet1 != null && _planet2 != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ComparisonScreen(planet1: _planet1!, planet2: _planet2!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Сначала загрузите обе планеты')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Планеты')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _controller1, decoration: const InputDecoration(labelText: 'Планета 1')),
            ElevatedButton(onPressed: _loadPlanet1, child: const Text('Загрузить 1')),
            const SizedBox(height: 16),
            TextField(controller: _controller2, decoration: const InputDecoration(labelText: 'Планета 2')),
            ElevatedButton(onPressed: _loadPlanet2, child: const Text('Загрузить 2')),
            const SizedBox(height: 24),
            if (_planet1 != null) Text('✅ Загружено: ${_planet1!.name}'),
            if (_planet2 != null) Text('✅ Загружено: ${_planet2!.name}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (_planet1 != null && _planet2 != null) ? _compare : null,
              child: const Text('Сравнить'),
            ),
            if (_loading) const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}