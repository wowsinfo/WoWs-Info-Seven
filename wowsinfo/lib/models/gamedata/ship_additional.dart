import 'package:flutter/foundation.dart';

@immutable
class ShipAdditional {
  const ShipAdditional({
    required this.damage,
    required this.frags,
    required this.winrate,
    this.battles,
  });

  final int damage;
  final double frags;
  final double winrate;
  final int? battles;

  factory ShipAdditional.fromJson(Map<String, dynamic> json) => ShipAdditional(
        damage: json['damage'],
        frags: json['frags'],
        winrate: json['winrate'],
        battles: json['battles'],
      );
}
