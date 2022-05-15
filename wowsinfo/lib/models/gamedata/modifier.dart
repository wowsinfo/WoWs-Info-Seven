import 'package:flutter/foundation.dart';

// TODO: can be merged with another modifiers later
@immutable
class ExteriorModifiers {
  const ExteriorModifiers({
    required this.afterBattleRepair,
    required this.expFactor,
    required this.shootShift,
    required this.visibilityFactor,
    required this.creditsFactor,
    required this.freeExpFactor,
    required this.collisionDamageApply,
    required this.collisionDamageNerf,
    required this.crewExpFactor,
    required this.speedCoef,
    required this.planeRegenerationRate,
    required this.regenerationHPSpeed,
    required this.burnTime,
    required this.floodTime,
    required this.pmDetonationProb,
    required this.gsIdealRadius,
    required this.gsMaxDist,
    required this.gsShotDelay,
    required this.consumableReloadTime,
    required this.aaAuraDamage,
    required this.aaBubbleDamage,
    required this.burnChanceFactorBig,
    required this.burnChanceFactorSmall,
    required this.floodChanceFactor,
    required this.floodChanceFactorPlane,
    required this.smokeGeneratorWorkTimeCoeff,
    required this.airDefenseDispReloadCoeff,
    required this.sonarWorkTimeCoeff,
  });

  final double afterBattleRepair;
  final double expFactor;
  final double shootShift;
  final double visibilityFactor;
  final double creditsFactor;
  final num freeExpFactor;
  final double collisionDamageApply;
  final double collisionDamageNerf;
  final double crewExpFactor;
  final double speedCoef;
  final double planeRegenerationRate;
  final double regenerationHPSpeed;
  final double burnTime;
  final double floodTime;
  final double pmDetonationProb;
  final double gsIdealRadius;
  final double gsMaxDist;
  final double gsShotDelay;
  final ModifierShipType consumableReloadTime;
  final ModifierShipType aaAuraDamage;
  final ModifierShipType aaBubbleDamage;
  final double burnChanceFactorBig;
  final double burnChanceFactorSmall;
  final double floodChanceFactor;
  final double floodChanceFactorPlane;
  final double smokeGeneratorWorkTimeCoeff;
  final double airDefenseDispReloadCoeff;
  final double sonarWorkTimeCoeff;

  factory ExteriorModifiers.fromJson(Map<String, dynamic> json) =>
      ExteriorModifiers(
        afterBattleRepair: json['afterBattleRepair'] ?? 1,
        expFactor: json['expFactor'] ?? 1,
        shootShift: json['shootShift'] ?? 1,
        visibilityFactor: json['visibilityFactor'] ?? 1,
        creditsFactor: json['creditsFactor'] ?? 1,
        freeExpFactor: json['freeExpFactor'] ?? 1,
        collisionDamageApply: json['collisionDamageApply'] ?? 1,
        collisionDamageNerf: json['collisionDamageNerf'] ?? 1,
        crewExpFactor: json['crewExpFactor'] ?? 1,
        speedCoef: json['speedCoef'] ?? 1,
        planeRegenerationRate: json['planeRegenerationRate'] ?? 1,
        regenerationHPSpeed: json['regenerationHPSpeed'] ?? 1,
        burnTime: json['burnTime'] ?? 1,
        floodTime: json['floodTime'] ?? 1,
        pmDetonationProb: json['PMDetonationProb'] ?? 1,
        gsIdealRadius: json['GSIdealRadius'] ?? 1,
        gsMaxDist: json['GSMaxDist'] ?? 1,
        gsShotDelay: json['GSShotDelay'] ?? 1,
        consumableReloadTime: ModifierShipType.fromJson(
          json['ConsumableReloadTime'],
        ),
        aaAuraDamage: ModifierShipType.fromJson(json['AAAuraDamage']),
        aaBubbleDamage: ModifierShipType.fromJson(json['AABubbleDamage']),
        burnChanceFactorBig: json['burnChanceFactorBig'] ?? 1,
        burnChanceFactorSmall: json['burnChanceFactorSmall'] ?? 1,
        floodChanceFactor: json['floodChanceFactor'] ?? 1,
        floodChanceFactorPlane: json['floodChanceFactorPlane'] ?? 1,
        smokeGeneratorWorkTimeCoeff: json['smokeGeneratorWorkTimeCoeff'] ?? 1,
        airDefenseDispReloadCoeff: json['airDefenseDispReloadCoeff'] ?? 1,
        sonarWorkTimeCoeff: json['sonarWorkTimeCoeff'] ?? 1,
      );
}

// TODO: is it better to separate or merge modifiers into one big class?
@immutable
class ModernizationModifiers {
  const ModernizationModifiers({
    required this.planeEmptyReturnSpeed,
    required this.gmRotationSpeed,
    required this.planeExtraHangarSize,
    required this.planeSpawnTime,
    required this.gsIdealRadius,
    required this.gsMaxDist,
    required this.gmShotDelay,
    required this.gtCritProb,
    required this.gtShotDelay,
    required this.gmMaxDist,
    required this.planeSpeed,
    required this.planeHealth,
    required this.prioritySectorCooldownMultiplier,
    required this.burnProb,
    required this.floodProb,
    required this.burnTime,
    required this.floodTime,
    required this.engineBackwardForsageMaxSpeed,
    required this.engineBackwardForsagePower,
    required this.engineBackwardUpTime,
    required this.engineForwardForsageMaxSpeed,
    required this.engineForwardForsagePower,
    required this.engineForwardUpTime,
    required this.sgRudderTime,
    required this.visionXRayTorpedoDist,
    required this.planeVisibilityFactor,
    required this.shootShift,
    required this.visibilityDistCoeff,
    required this.visibilityForSubmarineCoeff,
    required this.gmIdealRadius,
    required this.gmCritProb,
    required this.gmMaxHP,
    required this.gmRepairTime,
    required this.gtMaxHP,
    required this.gtRepairTime,
    required this.aaMaxHP,
    required this.gsMaxHP,
    required this.pmDetonationProb,
    required this.gtRotationSpeed,
    required this.sgRepairTime,
    required this.speedBoostersWorkTimeCoeff,
    required this.smokeGeneratorLifeTime,
    required this.smokeGeneratorWorkTimeCoeff,
    required this.scoutWorkTimeCoeff,
    required this.crashCrewWorkTimeCoeff,
    required this.airDefenseDispReloadCoeff,
    required this.airDefenseDispWorkTimeCoeff,
    required this.sonarWorkTimeCoeff,
    required this.rlsWorkTimeCoeff,
    required this.gsShotDelay,
    required this.consumableReloadTime,
    required this.additionalConsumables,
    required this.consumablesWorkTime,
    required this.torpedoVisibilityFactor,
    required this.bombAlphaDamageMultiplier,
    required this.diveBomberMaxSpeedMultiplier,
    required this.diveBomberMinSpeedMultiplier,
    required this.diveBomberSpeedMultiplier,
    required this.planeForsageTimeCoeff,
    required this.planeMaxSpeedMultiplier,
    required this.fighterHealth,
    required this.torpedoBomberHealth,
    required this.diveBomberHealth,
    required this.torpedoBomberAimingTime,
    required this.fighterAimingTime,
    required this.sgCritProb,
    required this.engineCritProb,
    required this.engineRepairTime,
    required this.torpedoSpeedMultiplier,
    required this.planeTorpedoSpeedMultiplier,
    required this.planeConsumablesWorkTime,
    required this.aaAuraDamage,
    required this.aaBubbleDamage,
    required this.aaInnerExtraBubbles,
    required this.torpedoDamageCoeff,
    required this.skipBomberHealth,
    required this.batteryBurnRateCoeff,
    required this.hydrophoneUpdateFrequencyCoeff,
    required this.hydrophoneWaveSpeedCoeff,
    required this.pingerCritProb,
    required this.pingerRepairTime,
    required this.pingerWaveSpeedCoeff,
    required this.batteryCapacityCoeff,
    required this.asMaxHealthCoeff,
    required this.asReloadTimeCoeff,
    required this.dcAlphaDamageMultiplier,
    required this.dcNumPacksBonus,
    required this.buoyancyRudderResetTimeCoeff,
    required this.buoyancyRudderTimeCoeff,
    required this.skipBomberAimingTime,
  });

  final double planeEmptyReturnSpeed;
  final ModifierShipType gmRotationSpeed;
  final int planeExtraHangarSize;
  final double planeSpawnTime;
  final double gsIdealRadius;
  final double gsMaxDist;
  final double gmShotDelay;
  final double gtCritProb;
  final double gtShotDelay;
  final double gmMaxDist;
  final double planeSpeed;
  final double planeHealth;
  final double prioritySectorCooldownMultiplier;
  final double burnProb;
  final double floodProb;
  final double burnTime;
  final double floodTime;
  final double engineBackwardForsageMaxSpeed;
  final double engineBackwardForsagePower;
  final double engineBackwardUpTime;
  final double engineForwardForsageMaxSpeed;
  final double engineForwardForsagePower;
  final double engineForwardUpTime;
  final double sgRudderTime;
  final int visionXRayTorpedoDist;
  final double planeVisibilityFactor;
  final double shootShift;
  final ModifierShipType visibilityDistCoeff;
  final double visibilityForSubmarineCoeff;
  final double gmIdealRadius;
  final double gmCritProb;
  final double gmMaxHP;
  final double gmRepairTime;
  final double gtMaxHP;
  final double gtRepairTime;
  final double aaMaxHP;
  final double gsMaxHP;
  final double pmDetonationProb;
  final double gtRotationSpeed;
  final double sgRepairTime;
  final double speedBoostersWorkTimeCoeff;
  final double smokeGeneratorLifeTime;
  final double smokeGeneratorWorkTimeCoeff;
  final double scoutWorkTimeCoeff;
  final double crashCrewWorkTimeCoeff;
  final double airDefenseDispReloadCoeff;
  final double airDefenseDispWorkTimeCoeff;
  final double sonarWorkTimeCoeff;
  final double rlsWorkTimeCoeff;
  final double gsShotDelay;
  final ModifierShipType consumableReloadTime;
  final int additionalConsumables;
  final double consumablesWorkTime;
  final double torpedoVisibilityFactor;
  final double bombAlphaDamageMultiplier;
  final double diveBomberMaxSpeedMultiplier;
  final double diveBomberMinSpeedMultiplier;
  final double diveBomberSpeedMultiplier;
  final double planeForsageTimeCoeff;
  final double planeMaxSpeedMultiplier;
  final double fighterHealth;
  final double torpedoBomberHealth;
  final double diveBomberHealth;
  final int torpedoBomberAimingTime;
  final int fighterAimingTime;
  final double sgCritProb;
  final double engineCritProb;
  final double engineRepairTime;
  final double torpedoSpeedMultiplier;
  final double planeTorpedoSpeedMultiplier;
  final double planeConsumablesWorkTime;
  final ModifierShipType aaAuraDamage;
  final ModifierShipType aaBubbleDamage;
  final int aaInnerExtraBubbles;
  final double torpedoDamageCoeff;
  final double skipBomberHealth;
  final double batteryBurnRateCoeff;
  final double hydrophoneUpdateFrequencyCoeff;
  final double hydrophoneWaveSpeedCoeff;
  final double pingerCritProb;
  final double pingerRepairTime;
  final double pingerWaveSpeedCoeff;
  final double batteryCapacityCoeff;
  final double asMaxHealthCoeff;
  final double asReloadTimeCoeff;
  final ModifierShipType dcAlphaDamageMultiplier;
  final int dcNumPacksBonus;
  final double buoyancyRudderResetTimeCoeff;
  final double buoyancyRudderTimeCoeff;
  final double skipBomberAimingTime;

  factory ModernizationModifiers.fromJson(Map<String, dynamic> json) =>
      ModernizationModifiers(
        planeEmptyReturnSpeed: json['planeEmptyReturnSpeed'] ?? 1,
        gmRotationSpeed: ModifierShipType.fromJson(json['gmRotationSpeed']),
        planeExtraHangarSize: json['planeExtraHangarSize'] ?? 1,
        planeSpawnTime: json['planeSpawnTime'] ?? 1,
        gsIdealRadius: json['GSIdealRadius'] ?? 1,
        gsMaxDist: json['GSMaxDist'] ?? 1,
        gmShotDelay: json['GMShotDelay'] ?? 1,
        gtCritProb: json['GTCritProb'] ?? 1,
        gtShotDelay: json['GTShotDelay'] ?? 1,
        gmMaxDist: json['GMMaxDist'] ?? 1,
        planeSpeed: json['planeSpeed'] ?? 1,
        planeHealth: json['planeHealth'] ?? 1,
        prioritySectorCooldownMultiplier:
            json['prioritySectorCooldownMultiplier'] ?? 1,
        burnProb: json['burnProb'] ?? 1,
        floodProb: json['floodProb'] ?? 1,
        burnTime: json['burnTime'] ?? 1,
        floodTime: json['floodTime'] ?? 1,
        engineBackwardForsageMaxSpeed:
            json['engineBackwardForsageMaxSpeed'] ?? 1,
        engineBackwardForsagePower: json['engineBackwardForsagePower'] ?? 1,
        engineBackwardUpTime: json['engineBackwardUpTime'] ?? 1,
        engineForwardForsageMaxSpeed: json['engineForwardForsageMaxSpeed'] ?? 1,
        engineForwardForsagePower: json['engineForwardForsagePower'] ?? 1,
        engineForwardUpTime: json['engineForwardUpTime'] ?? 1,
        sgRudderTime: json['SGRudderTime'] ?? 1,
        visionXRayTorpedoDist: json['visionXRayTorpedoDist'] ?? 1,
        planeVisibilityFactor: json['planeVisibilityFactor'] ?? 1,
        shootShift: json['shootShift'] ?? 1,
        visibilityDistCoeff: ModifierShipType.fromJson(
          json['visibilityDistCoeff'],
        ),
        visibilityForSubmarineCoeff: json['visibilityForSubmarineCoeff'] ?? 1,
        gmIdealRadius: json['GMIdealRadius'] ?? 1,
        gmCritProb: json['GMCritProb'] ?? 1,
        gmMaxHP: json['GMMaxHP'] ?? 1,
        gmRepairTime: json['GMRepairTime'] ?? 1,
        gtMaxHP: json['GTMaxHP'] ?? 1,
        gtRepairTime: json['GTRepairTime'] ?? 1,
        aaMaxHP: json['AAMaxHP'] ?? 1,
        gsMaxHP: json['GSMaxHP'] ?? 1,
        pmDetonationProb: json['PMDetonationProb'] ?? 1,
        gtRotationSpeed: json['GTRotationSpeed'] ?? 1,
        sgRepairTime: json['SGRepairTime'] ?? 1,
        speedBoostersWorkTimeCoeff: json['speedBoostersWorkTimeCoeff'] ?? 1,
        smokeGeneratorLifeTime: json['smokeGeneratorLifeTime'] ?? 1,
        smokeGeneratorWorkTimeCoeff: json['smokeGeneratorWorkTimeCoeff'] ?? 1,
        scoutWorkTimeCoeff: json['scoutWorkTimeCoeff'] ?? 1,
        crashCrewWorkTimeCoeff: json['crashCrewWorkTimeCoeff'] ?? 1,
        airDefenseDispReloadCoeff: json['airDefenseDispReloadCoeff'] ?? 1,
        airDefenseDispWorkTimeCoeff: json['airDefenseDispWorkTimeCoeff'] ?? 1,
        sonarWorkTimeCoeff: json['sonarWorkTimeCoeff'] ?? 1,
        rlsWorkTimeCoeff: json['rlsWorkTimeCoeff'] ?? 1,
        gsShotDelay: json['GSShotDelay'] ?? 1,
        consumableReloadTime: ModifierShipType.fromJson(
          json['ConsumableReloadTime'],
        ),
        additionalConsumables: json['additionalConsumables'] ?? 1,
        consumablesWorkTime: json['ConsumablesWorkTime'] ?? 1,
        torpedoVisibilityFactor: json['torpedoVisibilityFactor'] ?? 1,
        bombAlphaDamageMultiplier: json['bombAlphaDamageMultiplier'] ?? 1,
        diveBomberMaxSpeedMultiplier: json['diveBomberMaxSpeedMultiplier'] ?? 1,
        diveBomberMinSpeedMultiplier: json['diveBomberMinSpeedMultiplier'] ?? 1,
        diveBomberSpeedMultiplier: json['diveBomberSpeedMultiplier'] ?? 1,
        planeForsageTimeCoeff: json['planeForsageTimeCoeff'] ?? 1,
        planeMaxSpeedMultiplier: json['planeMaxSpeedMultiplier'] ?? 1,
        fighterHealth: json['fighterHealth'] ?? 1,
        torpedoBomberHealth: json['torpedoBomberHealth'] ?? 1,
        diveBomberHealth: json['diveBomberHealth'] ?? 1,
        torpedoBomberAimingTime: json['torpedoBomberAimingTime'] ?? 1,
        fighterAimingTime: json['fighterAimingTime'] ?? 1,
        sgCritProb: json['SGCritProb'] ?? 1,
        engineCritProb: json['engineCritProb'] ?? 1,
        engineRepairTime: json['engineRepairTime'] ?? 1,
        torpedoSpeedMultiplier: json['torpedoSpeedMultiplier'] ?? 1,
        planeTorpedoSpeedMultiplier: json['planeTorpedoSpeedMultiplier'] ?? 1,
        planeConsumablesWorkTime: json['planeConsumablesWorkTime'] ?? 1,
        aaAuraDamage: ModifierShipType.fromJson(json['AAAuraDamage']),
        aaBubbleDamage: ModifierShipType.fromJson(json['AABubbleDamage']),
        aaInnerExtraBubbles: json['AAInnerExtraBubbles'] ?? 1,
        torpedoDamageCoeff: json['torpedoDamageCoeff'] ?? 1,
        skipBomberHealth: json['skipBomberHealth'] ?? 1,
        batteryBurnRateCoeff: json['batteryBurnRateCoeff'] ?? 1,
        hydrophoneUpdateFrequencyCoeff:
            json['hydrophoneUpdateFrequencyCoeff'] ?? 1,
        hydrophoneWaveSpeedCoeff: json['hydrophoneWaveSpeedCoeff'] ?? 1,
        pingerCritProb: json['pingerCritProb'] ?? 1,
        pingerRepairTime: json['pingerRepairTime'] ?? 1,
        pingerWaveSpeedCoeff: json['pingerWaveSpeedCoeff'] ?? 1,
        batteryCapacityCoeff: json['batteryCapacityCoeff'] ?? 1,
        asMaxHealthCoeff: json['asMaxHealthCoeff'] ?? 1,
        asReloadTimeCoeff: json['asReloadTimeCoeff'] ?? 1,
        dcAlphaDamageMultiplier: ModifierShipType.fromJson(
          json['dcAlphaDamageMultiplier'],
        ),
        dcNumPacksBonus: json['dcNumPacksBonus'] ?? 1,
        buoyancyRudderResetTimeCoeff: json['buoyancyRudderResetTimeCoeff'] ?? 1,
        buoyancyRudderTimeCoeff: json['buoyancyRudderTimeCoeff'] ?? 1,
        skipBomberAimingTime: json['skipBomberAimingTime'] ?? 1,
      );
}

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

  factory ModifierShipType.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ModifierShipType(
        airCarrier: 1,
        auxiliary: 1,
        battleship: 1,
        cruiser: 1,
        destroyer: 1,
        submarine: 1,
      );
    }

    return ModifierShipType(
      airCarrier: json['AirCarrier'].toDouble(),
      auxiliary: json['Auxiliary'].toDouble(),
      battleship: json['Battleship'].toDouble(),
      cruiser: json['Cruiser'].toDouble(),
      destroyer: json['Destroyer'].toDouble(),
      submarine: json['Submarine'].toDouble(),
    );
  }
}
