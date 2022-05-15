import 'package:flutter/foundation.dart';

@immutable
class Consumable {
  const Consumable({
    required this.name,
    required this.type,
  });

  final String name;
  final String type;

  factory Consumable.fromJson(Map<String, dynamic> json) => Consumable(
        name: json['name'],
        type: json['type'],
      );
}
