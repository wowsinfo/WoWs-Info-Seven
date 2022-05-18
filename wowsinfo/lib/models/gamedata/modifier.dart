import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

@immutable
class Modifiers {
  const Modifiers({
    required this.raw,
    this.aaAuraDamage,
    this.aaAuraReceiveDamageCoeff,
    this.aaBubbleDamage,
    this.aaExtraBubbles,
    this.aaInnerExtraBubbles,
    this.aaMaxHp,
    this.consumableReloadTime,
    this.consumablesWorkTime,
    this.gmapDamageCoeff,
    this.gmBigGunVisibilityCoeff,
    this.gmCritProb,
    this.gmhecsDamageCoeff,
    this.gmHeavyCruiserCaliberDamageCoeff,
    this.gmIdealRadius,
    this.gmMaxDist,
    this.gmMaxHp,
    this.gmRepairTime,
    this.gmRotationSpeed,
    this.gmShotDelay,
    this.gsIdealRadius,
    this.gsMaxDist,
    this.gsMaxHp,
    this.gsShotDelay,
    this.gtCritProb,
    this.gtMaxHp,
    this.gtRepairTime,
    this.gtRotationSpeed,
    this.gtShotDelay,
    this.pmDetonationProb,
    this.sgCritProb,
    this.sgCritRudderTime,
    this.sgRepairTime,
    this.sgRudderTime,
    this.absoluteBuff,
    this.acousticWaveRadius,
    this.activationDelay,
    this.additionalConsumables,
    this.affectedClasses,
    this.afterBattleRepair,
    this.airDefenseDispReloadCoeff,
    this.airDefenseDispWorkTimeCoeff,
    this.allyAuraBuff,
    this.ammo,
    this.areaDamageMultiplier,
    this.artilleryAlertEnabled,
    this.artilleryAlertMinDistance,
    this.artilleryBoostersReloadCoeff,
    this.artilleryBurnChanceBonus,
    this.artilleryDistCoeff,
    this.asMaxHealthCoeff,
    this.asReloadTimeCoeff,
    this.backwardEngineForsag,
    this.backwardEngineForsagMaxSpeed,
    this.batteryCapacityCoeff,
    this.batteryRegenCoeff,
    this.bombAlphaDamageMultiplier,
    this.bombApAlphaDamageMultiplier,
    this.bombBurnChanceBonus,
    this.boostCoeff,
    this.bubbleDamageMultiplier,
    this.buoyancyRudderResetTimeCoeff,
    this.buoyancyRudderTimeCoeff,
    this.buoyancyState,
    this.burnChanceFactorBig,
    this.burnChanceFactorHighLevel,
    this.burnChanceFactorLowLevel,
    this.burnChanceFactorSmall,
    this.burnProb,
    this.burnTime,
    this.callFightersAdditionalConsumables,
    this.callFightersAirOnly,
    this.callFightersAppearDelay,
    this.callFightersRadiusCoeff,
    this.callFightersTimeDelayAttack,
    this.callFightersWorkTimeCoeff,
    this.canUseOnEmpty,
    this.climbAngle,
    this.collisionDamageApply,
    this.collisionDamageNerf,
    this.condition,
    this.conditionalBuff,
    this.consumableType,
    this.crashCrewAdditionalConsumables,
    this.crashCrewReloadCoeff,
    this.crashCrewWorkTimeCoeff,
    this.creditsFactor,
    this.crewExpFactor,
    this.critProbCoefficient,
    this.criticalChance,
    this.damagedEngineCoeff,
    this.dcAlphaDamageMultiplier,
    this.dcNumPacksBonus,
    this.dcSplashRadiusMultiplier,
    this.descIDs,
    this.distShip,
    this.distTorpedo,
    this.distanceToKill,
    this.diveBomberAccuracyIncRateCoeff,
    this.diveBomberHealth,
    this.diveBomberMaxSpeedMultiplier,
    this.diveBomberMinSpeedMultiplier,
    this.diveBomberSpeedMultiplier,
    this.dogFightTime,
    this.effectOnEndLongivity,
    this.engineBackwardForsageMaxSpeed,
    this.engineBackwardForsagePower,
    this.engineBackwardUpTime,
    this.engineCritProb,
    this.engineForwardForsageMaxSpeed,
    this.engineForwardForsagePower,
    this.engineForwardUpTime,
    this.engineRepairTime,
    this.expFactor,
    this.extraFighterCount,
    this.fighterAccuracyIncRateCoeff,
    this.fighterAimingTime,
    this.fighterHealth,
    this.fighterReloadCoeff,
    this.fightersName,
    this.fightersNum,
    this.fireResistanceEnabled,
    this.firstSectorTimeCoeff,
    this.floodChanceFactor,
    this.floodChanceFactorPlane,
    this.floodProb,
    this.floodTime,
    this.flyAwayTime,
    this.forwardEngineForsag,
    this.forwardEngineForsagMaxSpeed,
    this.freeExpFactor,
    this.healForsageReloadCoeff,
    this.healthPerLevel,
    this.height,
    this.hlCritTimeCoeff,
    this.hydrophoneUpdateFrequencyCoeff,
    this.hydrophoneWaveSpeedCoeff,
    this.iconIDs,
    this.ignorePtzBonus,
    this.lastChanceReloadCoefficient,
    this.lifeTime,
    this.logic,
    this.maxBuoyancySpeedCoeff,
    this.nearEnemyIntuitionEnabled,
    this.nearRlsEnabled,
    this.numConsumables,
    this.penetrationCoeffHe,
    this.pingerCritProb,
    this.pingerRepairTime,
    this.pingerWaveSpeedCoeff,
    this.planeBubbleArmorCoeff,
    this.planeConsumablesWorkTime,
    this.planeEmptyReturnSpeed,
    this.planeEscapeHeightCoeff,
    this.planeExtraHangarSize,
    this.planeForsageTimeCoeff,
    this.planeHealth,
    this.planeHealthPerLevel,
    this.planeMaxSpeedMultiplier,
    this.planeRegenerationRate,
    this.planeSpawnTime,
    this.planeSpeed,
    this.planeTorpedoArmingTimeCoeff,
    this.planeTorpedoSpeedMultiplier,
    this.planeVisibilityFactor,
    this.preparationTime,
    this.prioritySectorCooldownMultiplier,
    this.prioritySectorStrengthBonus,
    this.priorityTargetEnabled,
    this.radius,
    this.regenCrewAdditionalConsumables,
    this.regenCrewReloadCoeff,
    this.regenCrewWorkTimeCoeff,
    this.regenerateHealthAdditionalConsumables,
    this.regenerateHealthWorkTimeCoeff,
    this.regenerationHpSpeed,
    this.regenerationHpSpeedUnits,
    this.regenerationRate,
    this.reloadBoostCoeff,
    this.reloadTime,
    this.restoreForsage,
    this.rlsWorkTimeCoeff,
    this.rocketApAlphaDamageMultiplier,
    this.rocketBurnChanceBonus,
    this.scoutAdditionalConsumables,
    this.scoutReloadCoeff,
    this.scoutWorkTimeCoeff,
    this.secondSectorTimeCoeff,
    this.selfAuraBuff,
    this.shootShift,
    this.skipBomberAccuracyIncRateCoeff,
    this.skipBomberAimingTime,
    this.skipBomberHealth,
    this.skipBomberSpeedMultiplier,
    this.smokeGeneratorLifeTime,
    this.smokeGeneratorWorkTimeCoeff,
    this.softCriticalEnabled,
    this.sonarWorkTimeCoeff,
    this.source,
    this.spawnBackwardShift,
    this.speedBoostersWorkTimeCoeff,
    this.speedCoef,
    this.speedLimit,
    this.startDelayTime,
    this.startDistance,
    this.switchAmmoReloadCoef,
    this.target,
    this.targetBuff,
    this.timeDelayAttack,
    this.timeFromHeaven,
    this.timeToTryingCatch,
    this.timeWaitDelayAttack,
    this.titleIDs,
    this.torpedoBomberAccuracyIncRateCoeff,
    this.torpedoBomberAimingTime,
    this.torpedoBomberHealth,
    this.torpedoDamageCoeff,
    this.torpedoDetectionCoefficient,
    this.torpedoDetectionCoefficientByPlane,
    this.torpedoFullPingDamageCoeff,
    this.torpedoReloadTime,
    this.torpedoReloaderReloadCoeff,
    this.torpedoSpeedMultiplier,
    this.torpedoVisibilityFactor,
    this.underwaterMaxRudderAngleCoeff,
    this.updateFrequency,
    this.uwCoeffBonus,
    this.visibilityDistCoeff,
    this.visibilityFactor,
    this.visibilityForSubmarineCoeff,
    this.visionXRayTorpedoDist,
    this.waveDistance,
    this.waveParams,
    this.weaponTypes,
    this.workTime,
    this.zoneLifetime,
    this.zoneRadius,
  });

  // Save a copy of the raw data for the desciption
  final Map<String, dynamic> raw;

  @override
  String toString() {
    final _logger = Logger('Modifiers');

    var description = '';
    for (final entry in raw.entries) {
      final key = entry.key.toLowerCase();
      if (key == 'preparationtime') continue;

      final langString = GameRepository.instance.stringOf(
        'IDS_PARAMS_MODIFIER_' + key.toUpperCase(),
      );

      if (langString == ' ') continue;

      final value = entry.value;
      if (value == null) continue;
      _logger.fine('$key: $value');

      var valueString = '';

      // format to string first
      if (value is num) {
        if (value == -1) {
          // -1 means infinite
          valueString = '∞';
        } else {
          // coeff has the highest priority
          if (key.contains('coeff')) {
            valueString = _formatNumber(value);
          } else if (key.contains('time')) {
            valueString = value.toDecimalString() + 's';
          } else if (key.contains('dist')) {
            valueString = (value / 33.35).toDecimalString() + 'km';
          } else if (value < 2) {
            valueString = _formatNumber(value);
          } else {
            valueString = value.toDecimalString();
          }
        }
      } else if (value is List) {
        if (value.isEmpty) continue;
        valueString = value.join(', ');
      }

      description += '$langString: $valueString\n';
    }

    return description;
  }

  String _formatNumber(num value) {
    if (value == 1) return '+1';
    var adjustedValue = value;
    // TODO: need to find a better way, this is more or less a hack
    // TODO: we shouldn't adjust the value based on its value
    if (value < 0.35) {
      // if the number is too small, we need to add 1 to make it positive
      adjustedValue = value + 1;
    }
    final positive = adjustedValue > 1;
    final offset = ((adjustedValue - 1).abs() * 100).toDecimalString();
    return '${positive ? '+' : '-'}$offset%';
  }

  final ModifierShipType? aaAuraDamage;
  final double? aaAuraReceiveDamageCoeff;
  final ModifierShipType? aaBubbleDamage;
  final num? aaExtraBubbles;
  final num? aaInnerExtraBubbles;
  final num? aaMaxHp;
  final ModifierShipType? consumableReloadTime;
  final double? consumablesWorkTime;
  final double? gmapDamageCoeff;
  final double? gmBigGunVisibilityCoeff;
  final double? gmCritProb;
  final double? gmhecsDamageCoeff;
  final double? gmHeavyCruiserCaliberDamageCoeff;
  final double? gmIdealRadius;
  final double? gmMaxDist;
  final double? gmMaxHp;
  final double? gmRepairTime;
  final ModifierShipType? gmRotationSpeed;
  final double? gmShotDelay;
  final double? gsIdealRadius;
  final double? gsMaxDist;
  final num? gsMaxHp;
  final double? gsShotDelay;
  final double? gtCritProb;
  final double? gtMaxHp;
  final double? gtRepairTime;
  final double? gtRotationSpeed;
  final double? gtShotDelay;
  final double? pmDetonationProb;
  final double? sgCritProb;
  final num? sgCritRudderTime;
  final double? sgRepairTime;
  final double? sgRudderTime;
  final String? absoluteBuff;
  final num? acousticWaveRadius;
  final num? activationDelay;
  final num? additionalConsumables;
  final List<String>? affectedClasses;
  final double? afterBattleRepair;
  final double? airDefenseDispReloadCoeff;
  final double? airDefenseDispWorkTimeCoeff;
  final String? allyAuraBuff;
  final String? ammo;
  final num? areaDamageMultiplier;
  final bool? artilleryAlertEnabled;
  final num? artilleryAlertMinDistance;
  final double? artilleryBoostersReloadCoeff;
  final ModifierShipType? artilleryBurnChanceBonus;
  final double? artilleryDistCoeff;
  final double? asMaxHealthCoeff;
  final double? asReloadTimeCoeff;
  final num? backwardEngineForsag;
  final num? backwardEngineForsagMaxSpeed;
  final double? batteryCapacityCoeff;
  final double? batteryRegenCoeff;
  final double? bombAlphaDamageMultiplier;
  final double? bombApAlphaDamageMultiplier;
  final double? bombBurnChanceBonus;
  final num? boostCoeff;
  final num? bubbleDamageMultiplier;
  final double? buoyancyRudderResetTimeCoeff;
  final double? buoyancyRudderTimeCoeff;
  final num? buoyancyState;
  final double? burnChanceFactorBig;
  final double? burnChanceFactorHighLevel;
  final double? burnChanceFactorLowLevel;
  final double? burnChanceFactorSmall;
  final double? burnProb;
  final double? burnTime;
  final num? callFightersAdditionalConsumables;
  final bool? callFightersAirOnly;
  final double? callFightersAppearDelay;
  final double? callFightersRadiusCoeff;
  final double? callFightersTimeDelayAttack;
  final double? callFightersWorkTimeCoeff;
  final bool? canUseOnEmpty;
  final num? climbAngle;
  final double? collisionDamageApply;
  final double? collisionDamageNerf;
  final String? condition;
  final String? conditionalBuff;
  final String? consumableType;
  final num? crashCrewAdditionalConsumables;
  final double? crashCrewReloadCoeff;
  final double? crashCrewWorkTimeCoeff;
  final double? creditsFactor;
  final double? crewExpFactor;
  final double? critProbCoefficient;
  final num? criticalChance;
  final double? damagedEngineCoeff;
  final ModifierShipType? dcAlphaDamageMultiplier;
  final num? dcNumPacksBonus;
  final double? dcSplashRadiusMultiplier;
  final String? descIDs;
  final num? distShip;
  final num? distTorpedo;
  final num? distanceToKill;
  final double? diveBomberAccuracyIncRateCoeff;
  final double? diveBomberHealth;
  final double? diveBomberMaxSpeedMultiplier;
  final double? diveBomberMinSpeedMultiplier;
  final double? diveBomberSpeedMultiplier;
  final num? dogFightTime;
  final num? effectOnEndLongivity;
  final num? engineBackwardForsageMaxSpeed;
  final double? engineBackwardForsagePower;
  final double? engineBackwardUpTime;
  final double? engineCritProb;
  final double? engineForwardForsageMaxSpeed;
  final double? engineForwardForsagePower;
  final double? engineForwardUpTime;
  final double? engineRepairTime;
  final double? expFactor;
  final num? extraFighterCount;
  final double? fighterAccuracyIncRateCoeff;
  final num? fighterAimingTime;
  final double? fighterHealth;
  final double? fighterReloadCoeff;
  final String? fightersName;
  final num? fightersNum;
  final bool? fireResistanceEnabled;
  final double? firstSectorTimeCoeff;
  final double? floodChanceFactor;
  final double? floodChanceFactorPlane;
  final double? floodProb;
  final double? floodTime;
  final num? flyAwayTime;
  final num? forwardEngineForsag;
  final num? forwardEngineForsagMaxSpeed;
  final num? freeExpFactor;
  final double? healForsageReloadCoeff;
  final ModifierShipType? healthPerLevel;
  final num? height;
  final double? hlCritTimeCoeff;
  final double? hydrophoneUpdateFrequencyCoeff;
  final num? hydrophoneWaveSpeedCoeff;
  final String? iconIDs;
  final num? ignorePtzBonus;
  final double? lastChanceReloadCoefficient;
  final num? lifeTime;
  final String? logic;
  final double? maxBuoyancySpeedCoeff;
  final bool? nearEnemyIntuitionEnabled;
  final bool? nearRlsEnabled;
  final num? numConsumables;
  final double? penetrationCoeffHe;
  final double? pingerCritProb;
  final double? pingerRepairTime;
  final double? pingerWaveSpeedCoeff;
  final double? planeBubbleArmorCoeff;
  final double? planeConsumablesWorkTime;
  final double? planeEmptyReturnSpeed;
  final double? planeEscapeHeightCoeff;
  final num? planeExtraHangarSize;
  final double? planeForsageTimeCoeff;
  final double? planeHealth;
  final num? planeHealthPerLevel;
  final double? planeMaxSpeedMultiplier;
  final double? planeRegenerationRate;
  final double? planeSpawnTime;
  final double? planeSpeed;
  final double? planeTorpedoArmingTimeCoeff;
  final double? planeTorpedoSpeedMultiplier;
  final double? planeVisibilityFactor;
  final num? preparationTime;
  final double? prioritySectorCooldownMultiplier;
  final num? prioritySectorStrengthBonus;
  final bool? priorityTargetEnabled;
  final num? radius;
  final num? regenCrewAdditionalConsumables;
  final double? regenCrewReloadCoeff;
  final double? regenCrewWorkTimeCoeff;
  final num? regenerateHealthAdditionalConsumables;
  final double? regenerateHealthWorkTimeCoeff;
  final num? regenerationHpSpeed;
  final num? regenerationHpSpeedUnits;
  final double? regenerationRate;
  final double? reloadBoostCoeff;
  final num? reloadTime;
  final bool? restoreForsage;
  final double? rlsWorkTimeCoeff;
  final double? rocketApAlphaDamageMultiplier;
  final double? rocketBurnChanceBonus;
  final num? scoutAdditionalConsumables;
  final double? scoutReloadCoeff;
  final double? scoutWorkTimeCoeff;
  final double? secondSectorTimeCoeff;
  final String? selfAuraBuff;
  final double? shootShift;
  final double? skipBomberAccuracyIncRateCoeff;
  final num? skipBomberAimingTime;
  final double? skipBomberHealth;
  final double? skipBomberSpeedMultiplier;
  final double? smokeGeneratorLifeTime;
  final double? smokeGeneratorWorkTimeCoeff;
  final bool? softCriticalEnabled;
  final double? sonarWorkTimeCoeff;
  final List<String>? source;
  final double? spawnBackwardShift;
  final double? speedBoostersWorkTimeCoeff;
  final double? speedCoef;
  final double? speedLimit;
  final num? startDelayTime;
  final num? startDistance;
  final double? switchAmmoReloadCoef;
  final List<String>? target;
  final String? targetBuff;
  final num? timeDelayAttack;
  final num? timeFromHeaven;
  final num? timeToTryingCatch;
  final num? timeWaitDelayAttack;
  final String? titleIDs;
  final double? torpedoBomberAccuracyIncRateCoeff;
  final num? torpedoBomberAimingTime;
  final double? torpedoBomberHealth;
  final double? torpedoDamageCoeff;
  final double? torpedoDetectionCoefficient;
  final num? torpedoDetectionCoefficientByPlane;
  final double? torpedoFullPingDamageCoeff;
  final num? torpedoReloadTime;
  final double? torpedoReloaderReloadCoeff;
  final double? torpedoSpeedMultiplier;
  final double? torpedoVisibilityFactor;
  final num? underwaterMaxRudderAngleCoeff;
  final num? updateFrequency;
  final num? uwCoeffBonus;
  final ModifierShipType? visibilityDistCoeff;
  final double? visibilityFactor;
  final double? visibilityForSubmarineCoeff;
  final num? visionXRayTorpedoDist;
  final num? waveDistance;
  final String? waveParams;
  final List<String>? weaponTypes;
  final num? workTime;
  final double? zoneLifetime;
  final double? zoneRadius;

  factory Modifiers.fromJson(Map<String, dynamic> json) => Modifiers(
        raw: json,
        aaAuraDamage: ModifierShipType.fromJson(json['AAAuraDamage']),
        aaAuraReceiveDamageCoeff: json['AAAuraReceiveDamageCoeff'],
        aaBubbleDamage: ModifierShipType.fromJson(json['AABubbleDamage']),
        aaExtraBubbles: json['AAExtraBubbles'],
        aaInnerExtraBubbles: json['AAInnerExtraBubbles'],
        aaMaxHp: json['AAMaxHP'],
        consumableReloadTime:
            ModifierShipType.fromJson(json['ConsumableReloadTime']),
        consumablesWorkTime: json['ConsumablesWorkTime'],
        gmapDamageCoeff: json['GMAPDamageCoeff'],
        gmBigGunVisibilityCoeff: json['GMBigGunVisibilityCoeff'],
        gmCritProb: json['GMCritProb'],
        gmhecsDamageCoeff: json['GMHECSDamageCoeff'],
        gmHeavyCruiserCaliberDamageCoeff:
            json['GMHeavyCruiserCaliberDamageCoeff'],
        gmIdealRadius: json['GMIdealRadius'],
        gmMaxDist: json['GMMaxDist'],
        gmMaxHp: json['GMMaxHP'],
        gmRepairTime: json['GMRepairTime'],
        gmRotationSpeed: ModifierShipType.fromJson(json['GMRotationSpeed']),
        gmShotDelay: json['GMShotDelay'],
        gsIdealRadius: json['GSIdealRadius'],
        gsMaxDist: json['GSMaxDist'],
        gsMaxHp: json['GSMaxHP'],
        gsShotDelay: json['GSShotDelay'],
        gtCritProb: json['GTCritProb'],
        gtMaxHp: json['GTMaxHP'],
        gtRepairTime: json['GTRepairTime'],
        gtRotationSpeed: json['GTRotationSpeed'],
        gtShotDelay: json['GTShotDelay'],
        pmDetonationProb: json['PMDetonationProb'],
        sgCritProb: json['SGCritProb'],
        sgCritRudderTime: json['SGCritRudderTime'],
        sgRepairTime: json['SGRepairTime'],
        sgRudderTime: json['SGRudderTime'],
        absoluteBuff: json['absoluteBuff'],
        acousticWaveRadius: json['acousticWaveRadius'],
        activationDelay: json['activationDelay'],
        additionalConsumables: json['additionalConsumables'],
        affectedClasses: json['affectedClasses'] == null
            ? null
            : List<String>.from(json['affectedClasses']),
        afterBattleRepair: json['afterBattleRepair'],
        airDefenseDispReloadCoeff: json['airDefenseDispReloadCoeff'],
        airDefenseDispWorkTimeCoeff: json['airDefenseDispWorkTimeCoeff'],
        allyAuraBuff: json['allyAuraBuff'],
        ammo: json['ammo'],
        areaDamageMultiplier: json['areaDamageMultiplier'],
        artilleryAlertEnabled: json['artilleryAlertEnabled'],
        artilleryAlertMinDistance: json['artilleryAlertMinDistance'],
        artilleryBoostersReloadCoeff: json['artilleryBoostersReloadCoeff'],
        artilleryBurnChanceBonus:
            ModifierShipType.fromJson(json['artilleryBurnChanceBonus']),
        artilleryDistCoeff: json['artilleryDistCoeff'],
        asMaxHealthCoeff: json['asMaxHealthCoeff'],
        asReloadTimeCoeff: json['asReloadTimeCoeff'],
        backwardEngineForsag: json['backwardEngineForsag'],
        backwardEngineForsagMaxSpeed: json['backwardEngineForsagMaxSpeed'],
        batteryCapacityCoeff: json['batteryCapacityCoeff'],
        batteryRegenCoeff: json['batteryRegenCoeff'],
        bombAlphaDamageMultiplier: json['bombAlphaDamageMultiplier'],
        bombApAlphaDamageMultiplier: json['bombApAlphaDamageMultiplier'],
        bombBurnChanceBonus: json['bombBurnChanceBonus'],
        boostCoeff: json['boostCoeff'],
        bubbleDamageMultiplier: json['bubbleDamageMultiplier'],
        buoyancyRudderResetTimeCoeff: json['buoyancyRudderResetTimeCoeff'],
        buoyancyRudderTimeCoeff: json['buoyancyRudderTimeCoeff'],
        buoyancyState: json['buoyancyState'],
        burnChanceFactorBig: json['burnChanceFactorBig'],
        burnChanceFactorHighLevel: json['burnChanceFactorHighLevel'],
        burnChanceFactorLowLevel: json['burnChanceFactorLowLevel'],
        burnChanceFactorSmall: json['burnChanceFactorSmall'],
        burnProb: json['burnProb'],
        burnTime: json['burnTime'],
        callFightersAdditionalConsumables:
            json['callFightersAdditionalConsumables'],
        callFightersAirOnly: json['callFightersAirOnly'],
        callFightersAppearDelay: json['callFightersAppearDelay'],
        callFightersRadiusCoeff: json['callFightersRadiusCoeff'],
        callFightersTimeDelayAttack: json['callFightersTimeDelayAttack'],
        callFightersWorkTimeCoeff: json['callFightersWorkTimeCoeff'],
        canUseOnEmpty: json['canUseOnEmpty'],
        climbAngle: json['climbAngle'],
        collisionDamageApply: json['collisionDamageApply'],
        collisionDamageNerf: json['collisionDamageNerf'],
        condition: json['condition'],
        conditionalBuff: json['conditionalBuff'],
        consumableType: json['consumableType'],
        crashCrewAdditionalConsumables: json['crashCrewAdditionalConsumables'],
        crashCrewReloadCoeff: json['crashCrewReloadCoeff'],
        crashCrewWorkTimeCoeff: json['crashCrewWorkTimeCoeff'],
        creditsFactor: json['creditsFactor'],
        crewExpFactor: json['crewExpFactor'],
        critProbCoefficient: json['critProbCoefficient'],
        criticalChance: json['criticalChance'],
        damagedEngineCoeff: json['damagedEngineCoeff'],
        dcAlphaDamageMultiplier:
            ModifierShipType.fromJson(json['dcAlphaDamageMultiplier']),
        dcNumPacksBonus: json['dcNumPacksBonus'],
        dcSplashRadiusMultiplier: json['dcSplashRadiusMultiplier'],
        descIDs: json['descIDs'],
        distShip: json['distShip'],
        distTorpedo: json['distTorpedo'],
        distanceToKill: json['distanceToKill'],
        diveBomberAccuracyIncRateCoeff: json['diveBomberAccuracyIncRateCoeff'],
        diveBomberHealth: json['diveBomberHealth'],
        diveBomberMaxSpeedMultiplier: json['diveBomberMaxSpeedMultiplier'],
        diveBomberMinSpeedMultiplier: json['diveBomberMinSpeedMultiplier'],
        diveBomberSpeedMultiplier: json['diveBomberSpeedMultiplier'],
        dogFightTime: json['dogFightTime'],
        effectOnEndLongivity: json['effectOnEndLongivity'],
        engineBackwardForsageMaxSpeed: json['engineBackwardForsageMaxSpeed'],
        engineBackwardForsagePower: json['engineBackwardForsagePower'],
        engineBackwardUpTime: json['engineBackwardUpTime'],
        engineCritProb: json['engineCritProb'],
        engineForwardForsageMaxSpeed: json['engineForwardForsageMaxSpeed'],
        engineForwardForsagePower: json['engineForwardForsagePower'],
        engineForwardUpTime: json['engineForwardUpTime'],
        engineRepairTime: json['engineRepairTime'],
        expFactor: json['expFactor'],
        extraFighterCount: json['extraFighterCount'],
        fighterAccuracyIncRateCoeff: json['fighterAccuracyIncRateCoeff'],
        fighterAimingTime: json['fighterAimingTime'],
        fighterHealth: json['fighterHealth'],
        fighterReloadCoeff: json['fighterReloadCoeff'],
        fightersName: json['fightersName'],
        fightersNum: json['fightersNum'],
        fireResistanceEnabled: json['fireResistanceEnabled'],
        firstSectorTimeCoeff: json['firstSectorTimeCoeff'],
        floodChanceFactor: json['floodChanceFactor'],
        floodChanceFactorPlane: json['floodChanceFactorPlane'],
        floodProb: json['floodProb'],
        floodTime: json['floodTime'],
        flyAwayTime: json['flyAwayTime'],
        forwardEngineForsag: json['forwardEngineForsag'],
        forwardEngineForsagMaxSpeed: json['forwardEngineForsagMaxSpeed'],
        freeExpFactor: json['freeExpFactor'],
        healForsageReloadCoeff: json['healForsageReloadCoeff'],
        healthPerLevel: ModifierShipType.fromJson(json['healthPerLevel']),
        height: json['height'],
        hlCritTimeCoeff: json['hlCritTimeCoeff'],
        hydrophoneUpdateFrequencyCoeff: json['hydrophoneUpdateFrequencyCoeff'],
        hydrophoneWaveSpeedCoeff: json['hydrophoneWaveSpeedCoeff'],
        iconIDs: json['iconIDs'],
        ignorePtzBonus: json['ignorePTZBonus'],
        lastChanceReloadCoefficient: json['lastChanceReloadCoefficient'],
        lifeTime: json['lifeTime'],
        logic: json['logic'],
        maxBuoyancySpeedCoeff: json['maxBuoyancySpeedCoeff'],
        nearEnemyIntuitionEnabled: json['nearEnemyIntuitionEnabled'],
        nearRlsEnabled: json['nearRLSEnabled'],
        numConsumables: json['numConsumables'],
        penetrationCoeffHe: json['penetrationCoeffHE'],
        pingerCritProb: json['pingerCritProb'],
        pingerRepairTime: json['pingerRepairTime'],
        pingerWaveSpeedCoeff: json['pingerWaveSpeedCoeff'],
        planeBubbleArmorCoeff: json['planeBubbleArmorCoeff'],
        planeConsumablesWorkTime: json['planeConsumablesWorkTime'],
        planeEmptyReturnSpeed: json['planeEmptyReturnSpeed'],
        planeEscapeHeightCoeff: json['planeEscapeHeightCoeff'],
        planeExtraHangarSize: json['planeExtraHangarSize'],
        planeForsageTimeCoeff: json['planeForsageTimeCoeff'],
        planeHealth: json['planeHealth'],
        planeHealthPerLevel: json['planeHealthPerLevel'],
        planeMaxSpeedMultiplier: json['planeMaxSpeedMultiplier'],
        planeRegenerationRate: json['planeRegenerationRate'],
        planeSpawnTime: json['planeSpawnTime'],
        planeSpeed: json['planeSpeed'],
        planeTorpedoArmingTimeCoeff: json['planeTorpedoArmingTimeCoeff'],
        planeTorpedoSpeedMultiplier: json['planeTorpedoSpeedMultiplier'],
        planeVisibilityFactor: json['planeVisibilityFactor'],
        preparationTime: json['preparationTime'],
        prioritySectorCooldownMultiplier:
            json['prioritySectorCooldownMultiplier'],
        prioritySectorStrengthBonus: json['prioritySectorStrengthBonus'],
        priorityTargetEnabled: json['priorityTargetEnabled'],
        radius: json['radius'],
        regenCrewAdditionalConsumables: json['regenCrewAdditionalConsumables'],
        regenCrewReloadCoeff: json['regenCrewReloadCoeff'],
        regenCrewWorkTimeCoeff: json['regenCrewWorkTimeCoeff'],
        regenerateHealthAdditionalConsumables:
            json['regenerateHealthAdditionalConsumables'],
        regenerateHealthWorkTimeCoeff: json['regenerateHealthWorkTimeCoeff'],
        regenerationHpSpeed: json['regenerationHPSpeed'],
        regenerationHpSpeedUnits: json['regenerationHPSpeedUnits'],
        regenerationRate: json['regenerationRate'],
        reloadBoostCoeff: json['reloadBoostCoeff'],
        reloadTime: json['reloadTime'],
        restoreForsage: json['restoreForsage'],
        rlsWorkTimeCoeff: json['rlsWorkTimeCoeff'],
        rocketApAlphaDamageMultiplier: json['rocketApAlphaDamageMultiplier'],
        rocketBurnChanceBonus: json['rocketBurnChanceBonus'],
        scoutAdditionalConsumables: json['scoutAdditionalConsumables'],
        scoutReloadCoeff: json['scoutReloadCoeff'],
        scoutWorkTimeCoeff: json['scoutWorkTimeCoeff'],
        secondSectorTimeCoeff: json['secondSectorTimeCoeff'],
        selfAuraBuff: json['selfAuraBuff'],
        shootShift: json['shootShift'],
        skipBomberAccuracyIncRateCoeff: json['skipBomberAccuracyIncRateCoeff'],
        skipBomberAimingTime: json['skipBomberAimingTime'],
        skipBomberHealth: json['skipBomberHealth'],
        skipBomberSpeedMultiplier: json['skipBomberSpeedMultiplier'],
        smokeGeneratorLifeTime: json['smokeGeneratorLifeTime'],
        smokeGeneratorWorkTimeCoeff: json['smokeGeneratorWorkTimeCoeff'],
        softCriticalEnabled: json['softCriticalEnabled'],
        sonarWorkTimeCoeff: json['sonarWorkTimeCoeff'],
        source:
            json['source'] == null ? null : List<String>.from(json['source']),
        spawnBackwardShift: json['spawnBackwardShift'],
        speedBoostersWorkTimeCoeff: json['speedBoostersWorkTimeCoeff'],
        speedCoef: json['speedCoef'],
        speedLimit: json['speedLimit'],
        startDelayTime: json['startDelayTime'],
        startDistance: json['startDistance'],
        switchAmmoReloadCoef: json['switchAmmoReloadCoef'],
        target:
            json['target'] == null ? null : List<String>.from(json['target']),
        targetBuff: json['targetBuff'],
        timeDelayAttack: json['timeDelayAttack'],
        timeFromHeaven: json['timeFromHeaven'],
        timeToTryingCatch: json['timeToTryingCatch'],
        timeWaitDelayAttack: json['timeWaitDelayAttack'],
        titleIDs: json['titleIDs'],
        torpedoBomberAccuracyIncRateCoeff:
            json['torpedoBomberAccuracyIncRateCoeff'],
        torpedoBomberAimingTime: json['torpedoBomberAimingTime'],
        torpedoBomberHealth: json['torpedoBomberHealth'],
        torpedoDamageCoeff: json['torpedoDamageCoeff'],
        torpedoDetectionCoefficient: json['torpedoDetectionCoefficient'],
        torpedoDetectionCoefficientByPlane:
            json['torpedoDetectionCoefficientByPlane'],
        torpedoFullPingDamageCoeff: json['torpedoFullPingDamageCoeff'],
        torpedoReloadTime: json['torpedoReloadTime'],
        torpedoReloaderReloadCoeff: json['torpedoReloaderReloadCoeff'],
        torpedoSpeedMultiplier: json['torpedoSpeedMultiplier'],
        torpedoVisibilityFactor: json['torpedoVisibilityFactor'],
        underwaterMaxRudderAngleCoeff: json['underwaterMaxRudderAngleCoeff'],
        updateFrequency: json['updateFrequency'],
        uwCoeffBonus: json['uwCoeffBonus'],
        visibilityDistCoeff:
            ModifierShipType.fromJson(json['visibilityDistCoeff']),
        visibilityFactor: json['visibilityFactor'],
        visibilityForSubmarineCoeff: json['visibilityForSubmarineCoeff'],
        visionXRayTorpedoDist: json['visionXRayTorpedoDist'],
        waveDistance: json['waveDistance'],
        waveParams: json['waveParams'],
        weaponTypes: json['weaponTypes'] == null
            ? null
            : List<String>.from(json['weaponTypes']),
        workTime: json['workTime'],
        zoneLifetime: json['zoneLifetime'],
        zoneRadius: json['zoneRadius'],
      );
}

/// Different values for different ship types.
@immutable
class ModifierShipType {
  const ModifierShipType({
    this.airCarrier,
    this.auxiliary,
    this.battleship,
    this.cruiser,
    this.destroyer,
    this.submarine,
  });

  final double? airCarrier;
  final double? auxiliary;
  final double? battleship;
  final double? cruiser;
  final double? destroyer;
  final double? submarine;

  factory ModifierShipType.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ModifierShipType();
    }

    return ModifierShipType(
      airCarrier: json['AirCarrier'],
      auxiliary: json['Auxiliary'],
      battleship: json['Battleship'],
      cruiser: json['Cruiser'],
      destroyer: json['Destroyer'],
      submarine: json['Submarine'],
    );
  }
}
