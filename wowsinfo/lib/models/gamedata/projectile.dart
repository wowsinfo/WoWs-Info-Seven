import 'package:flutter/foundation.dart';

@immutable
class Projectile {
  const Projectile({
    required this.type,
    required this.nation,
    required this.name,
    this.weight,
    this.ammoType,
    this.speed,
    this.damage,
    this.ricochetAngle,
    this.ricochetAlways,
    this.diameter,
    this.ap,
    this.overmatch,
    this.fuseTime,
    this.penHe,
    this.burnChance,
    this.visibility,
    this.range,
    this.floodChance,
    this.alphaDamage,
    this.deepWater,
    this.penSAP,
    this.ignoreClasses,
  });

  final String type;
  final String nation;
  final String name;
  final String? ammoType;
  final num? weight;
  final num? speed;
  final num? damage;
  final num? ricochetAngle;
  final double? ricochetAlways;
  final double? diameter;
  final ArmorPiecingInfo? ap;
  final int? overmatch;
  final double? fuseTime;
  final num? penHe;
  final double? penSAP;
  final double? burnChance;
  final double? visibility;
  final num? range;
  final num? floodChance;
  final num? alphaDamage;
  final bool? deepWater;
  final List<String>? ignoreClasses;

  factory Projectile.fromJson(Map<String, dynamic> json) => Projectile(
        type: json['type'],
        nation: json['nation'],
        name: json['name'],
        ammoType: json['ammoType'],
        weight: json['weight'],
        speed: json['speed'],
        damage: json['damage'],
        ricochetAngle: json['ricochetAngle'],
        ricochetAlways: json['ricochetAlways'],
        diameter: json['diameter'],
        ap: json['ap'] == null ? null : ArmorPiecingInfo.fromJson(json['ap']),
        overmatch: json['overmatch'],
        fuseTime: json['fuseTime'],
        penHe: json['penHE'],
        penSAP: json['penSAP'],
        burnChance: json['burnChance'],
        visibility: json['visibility'],
        range: json['range'],
        floodChance: json['floodChance'],
        alphaDamage: json['alphaDamage'],
        deepWater: json['deepWater'],
        ignoreClasses: json['ignoreClasses'] == null
            ? null
            : List<String>.from(json['ignoreClasses']),
      );
}

@immutable
class ArmorPiecingInfo {
  const ArmorPiecingInfo({
    required this.diameter,
    required this.weight,
    required this.drag,
    required this.velocity,
    required this.krupp,
  });

  final double diameter;
  final num weight;
  final double drag;
  final num velocity;
  final num krupp;

  factory ArmorPiecingInfo.fromJson(Map<String, dynamic> json) =>
      ArmorPiecingInfo(
        diameter: json['diameter'].toDouble(),
        weight: json['weight'],
        drag: json['drag'].toDouble(),
        velocity: json['velocity'],
        krupp: json['krupp'],
      );
}
