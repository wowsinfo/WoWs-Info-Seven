import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/localisation/localisation.dart';

/// Keys shouldn't be shown
const List<String> _blackList = [
  'affectedClasses',
];

/// Those keys contain values like 1.2, 0.7. The base line is 1.0.
/// All strings with coeff is considered as a percentage, they won't be added here.
/// `Coef`, `Multiplier`, `Factor`, `Time`, `Prob` are included by default
const List<String> _coeffList = [
  'AAAuraDamage',
  'AABubbleDamage',
  'AAMaxHP',
  'GMIdealRadius',
  'GMMaxDist',
  'GMMaxHP',
  'GMRotationSpeed',
  'GMShotDelay',
  'GSIdealRadius',
  'GSMaxDist',
  'GSMaxHP',
  'GSShotDelay',
  'GTMaxHP',
  'GTRotationSpeed',
  'GTShotDelay',
  'afterBattleRepair',
  'torpedoBomberHealth',
  'skipBomberHealth',
  'planeHealth',
  'fighterHealth',
  'diveBomberHealth',
  'planeSpeed',
  'planeSpawnTime',
  'planeRegenerationRate',
  'shootShift',
  'gmShotDelay', // custom reload booster modifier
];

/// Zero is the baseline, but it is a negative value.
const List<String> _negativeCoeff = [
  'SGRepairTime',
];

/// Similar to coeff, but the base line is 0.0.
/// Coeff strings are included here.
const List<String> _coeffListZero = [
  'buoyancyRudderResetTimeCoeff', // not sure about this one
  'damagedEngineCoeff', // not sure
  'lastChanceReloadCoefficient', // not sure
  'reloadBoostCoeff', // not sure
  'burnChanceFactorBig',
  'burnChanceFactorSmall',
  'rocketBurnChanceBonus',
  'regenerationRate',
  'boostCoeff', // engine boost
  'artilleryBurnChanceBonus',
];

// The value is a number meaning adding +7% for example
const List<String> _addPercent = [
  'uwCoeffBonus',
];

/// The value is like 0.005 but it should be 0.5%
const List<String> _rawPercent = [
  'regenerationHPSpeed',
];

/// Addtional count like +1 all consumables
/// `Additional`, `Extra` is included by default
const List<String> _additionalList = [
  'AAExtraBubbles',
  'AAInnerExtraBubbles',
  'additionalConsumables',
];

// `dist` is for distance
const List<String> _distList = [
  'radius',
];

/// raw distance like 7500.0 to 7.5km
const List<String> _rawDistList = [
  'acousticWaveRadius',
];

// `time` is for time
const List<String> _timeList = [
  'workTime',
  'torpedoReloadTime',
  'reloadTime',
  'preparationTime',
  'lifeTime',
];

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

  String? get consumableCount {
    final count = numConsumables;
    if (count == null) return null;
    if (count == -1) return '∞';
    return count.toString();
  }

  /// Join two modifiers together.
  Modifiers merge(Modifiers other) {
    final Map<String, dynamic> output = {...raw};
    for (final entry in other.raw.entries) {
      final key = entry.key;
      final value = entry.value;
      if (output[key] != null) {
        // only add up if it is a number
        if (value is num) output[key] *= value;
      } else {
        // add this value
        output[key] = value;
      }
    }
    return Modifiers.fromJson(output);
  }

  @override
  String toString() {
    final logger = Logger('Modifiers');

    String description = '';
    for (final entry in raw.entries) {
      // the original key is needed for checking in a predefined list
      final keyOriginal = entry.key;
      if (_blackList.contains(keyOriginal)) continue;

      logger.fine('keyOriginal: $keyOriginal');
      final key = keyOriginal.toLowerCase();

      final value = entry.value;
      if (value == null) continue;
      logger.fine('$keyOriginal: $value');

      final List<ModifierShipTypeHolder> valueMap;

      if (value is Map) {
        // we can have multiple modifiers in a single key
        final types = ModifierShipType.fromJson(value as Map<String, dynamic>);
        if (types.isEmpty()) continue;
        valueMap = types.generateList(key.toUpperCase());
      } else {
        valueMap = [
          ModifierShipTypeHolder(
            key: key.toUpperCase(),
            value: value,
            type: null,
          ),
        ];
      }

      // check all modifiers are the same string
      final stringSet = valueMap
          .map((e) {
            final valueKey = e.fullKey;
            return Localisation.instance.stringOf(
              valueKey,
              prefix: 'IDS_PARAMS_MODIFIER_',
            );
          })
          .toSet()
          .toList();

      // check if all values are the same as well
      final valueSet = valueMap.map((e) => e.value).toSet().toList();

      for (final item in valueMap) {
        final valueKey = item.fullKey;
        final langString = Localisation.instance.stringOf(
          valueKey,
          prefix: 'IDS_PARAMS_MODIFIER_',
        );

        // this might be some missing event modifiers
        if (langString == null) continue;

        final value = item.value;
        final shipType = item.type;
        final String valueString;

        if (value == 0) continue;

        if (_timeList.contains(keyOriginal)) {
          final double time = value.toDouble();
          valueString =
              '$langString: ${time.toDecimalString()} ${Localisation.instance.second}\n';
        } else if (_additionalList.contains(keyOriginal) ||
            key.contains('additional') ||
            key.contains('extra')) {
          final double extra = value.toDouble();
          // although it is `additional`, it can be NEGATIVE
          final sign = extra >= 0 ? '+' : '-';
          valueString = '$langString: $sign${extra.abs().toDecimalString()}\n';
        } else if (_coeffListZero.contains(keyOriginal)) {
          final double coeff = value.toDouble();
          valueString = '$langString: +${coeff.toPercentString()}\n';
        } else if (_coeffList.contains(keyOriginal) ||
            key.contains('coef') ||
            key.contains('factor') ||
            key.contains('multiplier') ||
            key.contains('time') ||
            key.contains('prob')) {
          final double coeff = value.toDouble();
          final positive = coeff > 1.0;
          final percent = (coeff - 1).abs().toPercentString();
          valueString = '$langString: ${positive ? '+' : '-'}$percent\n';
        } else if (key.contains('dist') || _distList.contains(keyOriginal)) {
          final double dist = value.toDouble();
          valueString =
              '$langString: ${(dist / 33.35).toDecimalString()} ${Localisation.instance.kilometer}\n';
        } else if (_rawPercent.contains(keyOriginal)) {
          final double percent = value.toDouble();
          valueString = '$langString: ${percent.toPercentString()}\n';
        } else if (_rawDistList.contains(keyOriginal)) {
          final double dist = value.toDouble();
          valueString =
              '$langString: ${(dist / 1000).toDecimalString()} ${Localisation.instance.kilometer}\n';
        } else {
          logger.warning('Unknown modifier: $keyOriginal');
          if (value == -1) {
            valueString = '$langString: ∞\n';
          } else {
            valueString = '$langString: $value\n';
          }
        }

        // logger.info('Ship type: $shipType');
        final sameForAll = (stringSet.length == 1 && valueSet.length == 1);
        if (shipType == null ||
            (sameForAll && !description.contains(valueString.trim()))) {
          // make sure there is no duplications and add only one
          // if this modifier for all ship types are the same, don't add things like [Battleship]
          description += valueString;
        } else if (sameForAll) {
          // don't add the same string multiple times
          continue;
        } else {
          final shipTypeString =
              Localisation.instance.stringOf(shipType, prefix: 'IDS_');
          description += '${valueString.trim()} ($shipTypeString)\n';
        }
      }
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

@immutable
class ModifierShipTypeHolder {
  const ModifierShipTypeHolder({
    required this.key,
    required this.type,
    required this.value,
  });

  final String key;
  final String? type;
  final dynamic value;

  String get fullKey => type == null ? key : '${key}_$type';
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

  final num? airCarrier;
  final num? auxiliary;
  final num? battleship;
  final num? cruiser;
  final num? destroyer;
  final num? submarine;

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

  /// Generate a list containing all types with key and value
  List<ModifierShipTypeHolder> generateList(String key) {
    return [
      ModifierShipTypeHolder(
        key: key,
        type: 'AIRCARRIER',
        value: _validate(airCarrier),
      ),
      ModifierShipTypeHolder(
        key: key,
        type: 'AUXILIARY',
        value: _validate(auxiliary),
      ),
      ModifierShipTypeHolder(
        key: key,
        type: 'BATTLESHIP',
        value: _validate(battleship),
      ),
      ModifierShipTypeHolder(
        key: key,
        type: 'CRUISER',
        value: _validate(cruiser),
      ),
      ModifierShipTypeHolder(
        key: key,
        type: 'DESTROYER',
        value: _validate(destroyer),
      ),
    ];
  }

  // Make sure 1.0 is not passed in here, it can cause some issues.
  // When it is 0, +0% or -0% will be displayed. This isn't expected.
  /// TODO: move this to game data?
  num? _validate(num? value) {
    if (value == null) return 0;
    if (value == 1) return 0;
    return value;
  }

  bool isEmpty() {
    return airCarrier == null &&
        auxiliary == null &&
        battleship == null &&
        cruiser == null &&
        destroyer == null &&
        submarine == null;
  }

  @override
  String toString() {
    return 'ModifierShipType{airCarrier: $airCarrier, auxiliary: $auxiliary, battleship: $battleship, cruiser: $cruiser, destroyer: $destroyer, submarine: $submarine}';
  }
}
