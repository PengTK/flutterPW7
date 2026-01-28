import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/di_setup.dart';
import 'package:hive/hive.dart';
import '../models/emoji_model.dart';

class EmojiScreen extends StatefulWidget {
  const EmojiScreen({super.key});

  @override
  State<EmojiScreen> createState() => _EmojiScreenState();
}

class _EmojiScreenState extends State<EmojiScreen> {
  final TextEditingController _controller = TextEditingController();
  late Box<EmojiHistoryItem> _box;
  List<EmojiHistoryItem>? _history;
  String? _result;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _box = Hive.box<EmojiHistoryItem>('emoji_history');
    _loadHistory();
  }

  void _loadHistory() {
    setState(() {
      _history = _box.values.toList();
    });
  }

  Future<void> _searchEmoji() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() => _loading = true);
    try {
      final dio = getIt<Dio>();
      final res = await dio.get(
        'https://api.api-ninjas.com/v1/emoji',
        queryParameters: {'name': name},
      );

      if (res.data is List && (res.data as List).isNotEmpty) {
        final emoji = (res.data as List).first as Map<String, dynamic>;
        final item = EmojiHistoryItem.fromJson(emoji);
        await _box.add(item);
        _loadHistory();
        setState(() => _result = '${item.character} (${item.name})');
      } else {
        setState(() => _result = 'Смайлик не найден');
      }
    } catch (e) {
      setState(() => _result = 'Ошибка: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _deleteItem(int index) async {
    if (_history != null && index >= 0 && index < _history!.length) {
      await _history![index].delete();
      _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Смайлики')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Название смайлика на англ'),
              onSubmitted: (_) => _searchEmoji(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _searchEmoji, child: const Text('Поиск')),
            if (_loading) const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: LinearProgressIndicator()),
            if (_result != null) Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(_result!)),
            const SizedBox(height: 16),
            const Text('История:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: _history == null || _history!.isEmpty
                  ? const Center(child: Text('История пуста'))
                  : ListView.builder(
                      itemCount: _history!.length,
                      itemBuilder: (context, i) {
                        final item = _history![i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text('${item.character} — ${item.name}'),
                            subtitle: Text('Code: ${item.code}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteItem(i),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}