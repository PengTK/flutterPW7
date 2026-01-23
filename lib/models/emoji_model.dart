import 'package:hive/hive.dart';

part 'emoji_model.g.dart';

@HiveType(typeId: 0)
class EmojiHistoryItem extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String character;

  @HiveField(2)
  final String unicodeName;

  EmojiHistoryItem({
    required this.name,
    required this.character,
    required this.unicodeName,
  });

  factory EmojiHistoryItem.fromJson(Map<String, dynamic> json) {
    return EmojiHistoryItem(
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      unicodeName: json['unicode_name'] ?? '',
    );
  }
}