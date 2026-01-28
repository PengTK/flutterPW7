import 'package:flutter/material.dart';
import 'planets_screen.dart';
import 'emoji_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Практос')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PlanetsScreen()),
              ),
              child: const Text('Планеты'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EmojiScreen()),
              ),
              child: const Text('Смайлики'),
            ),
          ],
        ),
      ),
    );
  }
}