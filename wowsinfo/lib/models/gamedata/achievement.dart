import 'package:flutter/cupertino.dart';

@immutable
class Achievement {
  const Achievement({
    required this.icon,
    required this.name,
    required this.description,
    required this.type,
    required this.id,
    required this.constants,
  });

  final String icon;
  final String name;
  final String description;
  final List<String> type;
  final int id;

  /// This field can be empty. The number can be int or double.
  final Map<String, dynamic> constants;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        icon: json['icon'],
        name: json['name'],
        description: json['description'],
        type: List<String>.from(json['type']),
        id: json['id'],
        constants: Map.from(json['constants'])
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      );

  @override
  String toString() {
    return 'Achievement{icon: $icon, name: $name, description: $description, type: $type, id: $id, constants: $constants}';
  }
}
