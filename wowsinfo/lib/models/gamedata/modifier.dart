import 'package:flutter/foundation.dart';

/// Different values for different ship types.
@immutable
class ModifierShipType {
  const ModifierShipType({
    required this.airCarrier,
    required this.auxiliary,
    required this.battleship,
    required this.cruiser,
    required this.destroyer,
    required this.submarine,
  });

  final double airCarrier;
  final double auxiliary;
  final double battleship;
  final double cruiser;
  final double destroyer;
  final double submarine;

  factory ModifierShipType.fromJson(Map<String, dynamic> json) =>
      ModifierShipType(
        airCarrier: json['AirCarrier'].toDouble(),
        auxiliary: json['Auxiliary'].toDouble(),
        battleship: json['Battleship'].toDouble(),
        cruiser: json['Cruiser'].toDouble(),
        destroyer: json['Destroyer'].toDouble(),
        submarine: json['Submarine'].toDouble(),
      );
}
