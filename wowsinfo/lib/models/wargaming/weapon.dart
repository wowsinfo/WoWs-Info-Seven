import 'package:flutter/foundation.dart';

typedef MainBattery = Weapon;
typedef SecondaryBattery = Weapon;
typedef RamAttack = Weapon;
typedef Torpedoe = Weapon;
typedef AttackAircraft = Weapon;

/// The statistics of different types of weapons.
@immutable
class Weapon {
  const Weapon({
    this.maxFragsBattle,
    this.frag,
    this.hits,
    this.maxFragsShipId,
    this.shot,
  });

  final int? maxFragsBattle;
  final int? frag;
  final int? hits;
  final int? maxFragsShipId;
  final int? shot;

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
        maxFragsBattle: json['max_frags_battle'],
        frag: json['frag'],
        hits: json['hits'],
        maxFragsShipId: json['max_frags_ship_id'],
        shot: json['shot'],
      );

  /// hits ratio doesn't apply to all weapons
  bool get hasHitRatio => shot != null && hits != null && hits! > 0;
  double get hitRatio =>
      hasHitRatio ? hits! * 10000 / shot! / 100.0 : double.nan;
  String get maxFrag => maxFragsBattle.toString();
  String get totalFrag => frag.toString();
}
