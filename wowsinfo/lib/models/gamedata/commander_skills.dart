import 'package:flutter/foundation.dart';

enum CommanderSkillType {
  airCarrier,
  battleship,
  cruiser,
  destroyer,
  submarine;

  /// The enum name but the first letter is upper case
  String get rawName => name.substring(0, 1).toUpperCase() + name.substring(1);

  /// Use with localisation with prefix `IDS_`
  String get langName => name.toUpperCase();
}

@immutable
class CommandSkills {
  const CommandSkills({
    required this.airCarrier,
    required this.battleship,
    required this.cruiser,
    required this.destroyer,
    required this.submarine,
    required this.shipTypes,
  });

  final List<List<ShipSkill>> airCarrier;
  final List<List<ShipSkill>> battleship;
  final List<List<ShipSkill>> cruiser;
  final List<List<ShipSkill>> destroyer;
  final List<List<ShipSkill>> submarine;

  /// The raw map
  final Map<String, List<List<ShipSkill>>> shipTypes;

  factory CommandSkills.fromJson(Map<String, dynamic> json) => CommandSkills(
        airCarrier: List<List<ShipSkill>>.from(json['AirCarrier'].map(
            (x) => List<ShipSkill>.from(x.map((x) => ShipSkill.fromJson(x))))),
        battleship: List<List<ShipSkill>>.from(json['Battleship'].map(
            (x) => List<ShipSkill>.from(x.map((x) => ShipSkill.fromJson(x))))),
        cruiser: List<List<ShipSkill>>.from(json['Cruiser'].map(
            (x) => List<ShipSkill>.from(x.map((x) => ShipSkill.fromJson(x))))),
        destroyer: List<List<ShipSkill>>.from(json['Destroyer'].map(
            (x) => List<ShipSkill>.from(x.map((x) => ShipSkill.fromJson(x))))),
        submarine: List<List<ShipSkill>>.from(json['Submarine'].map(
            (x) => List<ShipSkill>.from(x.map((x) => ShipSkill.fromJson(x))))),
        shipTypes: json.map((key, value) => MapEntry(
            key,
            List<List<ShipSkill>>.from(value.map((x) =>
                List<ShipSkill>.from(x.map((x) => ShipSkill.fromJson(x))))))),
      );
}

@immutable
class ShipSkill {
  const ShipSkill({
    required this.name,
    required this.tier,
    required this.column,
  });

  final String name;
  final int tier;
  final int column;

  factory ShipSkill.fromJson(Map<String, dynamic> json) => ShipSkill(
        name: json['name'],
        tier: json['tier'],
        column: json['column'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'tier': tier,
        'column': column,
      };

  @override
  String toString() => 'ShipSkill{name: $name, tier: $tier, column: $column}';
}
