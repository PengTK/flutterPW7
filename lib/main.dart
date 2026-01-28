import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/emoji_model.dart';
import 'screens/home_screen.dart';
import 'di_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmojiHistoryItemAdapter());
  await Hive.openBox<EmojiHistoryItem>('emoji_history');

  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Хихихаха',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}