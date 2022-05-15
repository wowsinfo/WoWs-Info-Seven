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
    required this.modifiers,
    required this.type,
  });

  final int id;
  final String name;
  final int? costGold;
  final ExteriorModifiers? modifiers;
  final String type;

  factory Exterior.fromJson(Map<String, dynamic> json) => Exterior(
        id: json['id'],
        name: json['name'],
        costGold: json['costGold'],
        modifiers: json['modifiers'] == null
            ? null
            : ExteriorModifiers.fromJson(json['modifiers']),
        type: json['type'],
      );
}

// TODO: can be merged with another modifiers later
@immutable
class ExteriorModifiers {
  const ExteriorModifiers({
    this.afterBattleRepair,
    this.expFactor,
    this.shootShift,
    this.visibilityFactor,
    this.creditsFactor,
    this.freeExpFactor,
    this.collisionDamageApply,
    this.collisionDamageNerf,
    this.crewExpFactor,
    this.speedCoef,
    this.planeRegenerationRate,
    this.regenerationHPSpeed,
    this.burnTime,
    this.floodTime,
    this.pmDetonationProb,
    this.gsIdealRadius,
    this.gsMaxDist,
    this.gsShotDelay,
    this.consumableReloadTime,
    this.aaAuraDamage,
    this.aaBubbleDamage,
    this.burnChanceFactorBig,
    this.burnChanceFactorSmall,
    this.floodChanceFactor,
    this.floodChanceFactorPlane,
    this.smokeGeneratorWorkTimeCoeff,
    this.airDefenseDispReloadCoeff,
    this.sonarWorkTimeCoeff,
  });

  final double? afterBattleRepair;
  final double? expFactor;
  final double? shootShift;
  final double? visibilityFactor;
  final double? creditsFactor;
  final num? freeExpFactor;
  final double? collisionDamageApply;
  final double? collisionDamageNerf;
  final double? crewExpFactor;
  final double? speedCoef;
  final double? planeRegenerationRate;
  final double? regenerationHPSpeed;
  final double? burnTime;
  final double? floodTime;
  final double? pmDetonationProb;
  final double? gsIdealRadius;
  final double? gsMaxDist;
  final double? gsShotDelay;
  final ModifierShipType? consumableReloadTime;
  final ModifierShipType? aaAuraDamage;
  final ModifierShipType? aaBubbleDamage;
  final double? burnChanceFactorBig;
  final double? burnChanceFactorSmall;
  final double? floodChanceFactor;
  final double? floodChanceFactorPlane;
  final double? smokeGeneratorWorkTimeCoeff;
  final double? airDefenseDispReloadCoeff;
  final double? sonarWorkTimeCoeff;

  factory ExteriorModifiers.fromJson(Map<String, dynamic> json) =>
      ExteriorModifiers(
        afterBattleRepair: json['afterBattleRepair'],
        expFactor: json['expFactor'],
        shootShift: json['shootShift'],
        visibilityFactor: json['visibilityFactor'],
        creditsFactor: json['creditsFactor'],
        freeExpFactor: json['freeExpFactor'],
        collisionDamageApply: json['collisionDamageApply'],
        collisionDamageNerf: json['collisionDamageNerf'],
        crewExpFactor: json['crewExpFactor'],
        speedCoef: json['speedCoef'],
        planeRegenerationRate: json['planeRegenerationRate'],
        regenerationHPSpeed: json['regenerationHPSpeed'],
        burnTime: json['burnTime'],
        floodTime: json['floodTime'],
        pmDetonationProb: json['PMDetonationProb'],
        gsIdealRadius: json['GSIdealRadius'],
        gsMaxDist: json['GSMaxDist'],
        gsShotDelay: json['GSShotDelay'],
        consumableReloadTime: json['ConsumableReloadTime'] == null
            ? null
            : ModifierShipType.fromJson(json['ConsumableReloadTime']),
        aaAuraDamage: json['AAAuraDamage'] == null
            ? null
            : ModifierShipType.fromJson(json['AAAuraDamage']),
        aaBubbleDamage: json['AABubbleDamage'] == null
            ? null
            : ModifierShipType.fromJson(json['AABubbleDamage']),
        burnChanceFactorBig: json['burnChanceFactorBig'],
        burnChanceFactorSmall: json['burnChanceFactorSmall'],
        floodChanceFactor: json['floodChanceFactor'],
        floodChanceFactorPlane: json['floodChanceFactorPlane'],
        smokeGeneratorWorkTimeCoeff: json['smokeGeneratorWorkTimeCoeff'],
        airDefenseDispReloadCoeff: json['airDefenseDispReloadCoeff'],
        sonarWorkTimeCoeff: json['sonarWorkTimeCoeff'],
      );
}
