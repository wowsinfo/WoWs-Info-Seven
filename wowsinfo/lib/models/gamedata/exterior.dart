import 'package:flutter/foundation.dart';

import 'modifier.dart';

typedef Camouflage = Exterior;
typedef Flag = Exterior;

@immutable
class Exterior {
  const Exterior({
    required this.id,
    required this.name,
    required this.costGold,
    required this.costCR,
    required this.modifiers,
    required this.type,
  });

  final int id;
  final String name;
  final int? costGold;
  final int? costCR;
  final ExteriorModifiers? modifiers;
  final String type;

  factory Exterior.fromJson(Map<String, dynamic> json) => Exterior(
        id: json['id'],
        name: json['name'],
        costGold: json['costGold'],
        costCR: json['costCR'],
        modifiers: json['modifiers'] == null
            ? null
            : ExteriorModifiers.fromJson(json['modifiers']),
        type: json['type'],
      );
}
