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
    this.frags,
    this.hits,
    this.maxFragsShipId,
    this.shots,
  });

  final int? maxFragsBattle;
  final int? frags;
  final int? hits;
  final int? maxFragsShipId;
  final int? shots;

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
        maxFragsBattle: json['max_frags_battle'],
        frags: json['frags'],
        hits: json['hits'],
        maxFragsShipId: json['max_frags_ship_id'],
        shots: json['shots'],
      );

  /// hits ratio doesn't apply to all weapons
  bool get hasHitRatio => shots != null && hits != null && hits! > 0;
  double get hitRatio =>
      hasHitRatio ? hits! * 10000 / shots! / 100.0 : double.nan;
  String get maxFrag => maxFragsBattle.toString();
  String get totalFrag => frags.toString();

  @override
  String toString() {
    return 'Weapon(maxFragsBattle: $maxFragsBattle, frag: $frags, hits: $hits, maxFragsShipId: $maxFragsShipId, shot: $shots)';
  }
}
