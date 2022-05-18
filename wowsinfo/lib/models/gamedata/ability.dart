import 'package:flutter/foundation.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/models/gamedata/modifier.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

@immutable
class Ability {
  const Ability({
    required this.nation,
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.filter,
    required this.type,
    required this.abilities,
    required this.abilityList,
  });

  final String nation;
  final int id;
  final String name;
  final String icon;
  final String description;
  final String filter;
  final String type;
  // final Map<String, AbilityInfo> abilities;
  // TODO: we shouldn't do this because in the future, we need the actual value
  final Map<String, Modifiers> abilities;
  final List<Modifiers> abilityList;

  String descriptionOf(int index) {
    final ability = abilityList[index];
    return ability.toString();
  }

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        nation: json['nation'],
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        description: json['description'],
        filter: json['filter'],
        type: json['type'],
        // abilities: Map.from(json['abilities']).map((k, v) =>
        //     MapEntry<String, AbilityInfo>(k, AbilityInfo.fromJson(v))),
        abilities: Map.from(json['abilities']).map((key, value) =>
            MapEntry<String, Modifiers>(key, Modifiers.fromJson(value))),
        abilityList: List.from(
            json['abilities'].values.map((e) => Modifiers.fromJson(e))),
      );
}

// TODO: too many fields but consumables are all different, what to do?
// TODO: we should probably use dynamic for this one I guess
// TODO: we can default everything to 1??
@immutable
class AbilityInfo {
  const AbilityInfo({
    this.numConsumables,
    this.preparationTime,
    this.reloadTime,
    this.workTime,
    this.regenerationHPSpeed,
    this.regenerationHPSpeedUnits,
    this.areaDamageMultiplier,
    this.bubbleDamageMultiplier,
    this.climbAngle,
    this.distanceToKill,
    this.dogFightTime,
    this.fightersName,
    this.fightersNum,
    this.flyAwayTime,
    this.radius,
    this.timeDelayAttack,
    this.timeFromHeaven,
    this.timeToTryingCatch,
    this.timeWaitDelayAttack,
    this.artilleryDistCoeff,
    this.activationDelay,
    this.height,
    this.lifeTime,
    this.spawnBackwardShift,
    this.speedLimit,
    this.startDelayTime,
    this.descIDs,
    this.iconIDs,
    this.titleIDs,
    this.backwardEngineForsag,
    this.backwardEngineForsagMaxSpeed,
    this.boostCoeff,
    this.forwardEngineForsag,
    this.forwardEngineForsagMaxSpeed,
    this.distShip,
    this.distTorpedo,
    this.targetBuoyancyCoefficients,
    this.torpedoReloadTime,
    this.affectedClasses,
    this.regenerationRate,
    this.ammo,
    this.acousticWaveRadius,
    this.updateFrequency,
    this.zoneLifetime,
    this.buoyancyRudderResetTimeCoeff,
    this.buoyancyRudderTimeCoeff,
    this.maxBuoyancySpeedCoeff,
    this.underwaterMaxRudderAngleCoeff,
    this.canUseOnEmpty,
    this.logic,
    this.criticalChance,
    this.source,
    this.target,
    this.zoneRadius,
    this.allyAuraBuff,
    this.selfAuraBuff,
    this.startDistance,
    this.waveDistance,
    this.waveParams,
    this.absoluteBuff,
    this.condition,
    this.conditionalBuff,
    this.targetBuff,
    this.buoyancyState,
    this.effectOnEndLongivity,
    this.reloadBoostCoeff,
    this.weaponTypes,
  });

  final int? numConsumables;
  final num? preparationTime;
  final num? reloadTime;
  final num? workTime;
  final num? regenerationHPSpeed;
  final num? regenerationHPSpeedUnits;
  final num? areaDamageMultiplier;
  final num? bubbleDamageMultiplier;
  final int? climbAngle;
  final num? distanceToKill;
  final num? dogFightTime;
  final String? fightersName;
  final int? fightersNum;
  final num? flyAwayTime;
  final num? radius;
  final num? timeDelayAttack;
  final num? timeFromHeaven;
  final num? timeToTryingCatch;
  final num? timeWaitDelayAttack;
  final num? artilleryDistCoeff;
  final num? activationDelay;
  final num? height;
  final num? lifeTime;
  final num? spawnBackwardShift;
  final num? speedLimit;
  final num? startDelayTime;
  final String? descIDs;
  final String? iconIDs;
  final String? titleIDs;
  final num? backwardEngineForsag;
  final num? backwardEngineForsagMaxSpeed;
  final num? boostCoeff;
  final num? forwardEngineForsag;
  final num? forwardEngineForsagMaxSpeed;
  final num? distShip;
  final num? distTorpedo;
  final Map<String, num>? targetBuoyancyCoefficients;
  final num? torpedoReloadTime;
  final List<String>? affectedClasses;
  final num? regenerationRate;
  final String? ammo;
  final num? acousticWaveRadius;
  final num? updateFrequency;
  final num? zoneLifetime;
  final num? buoyancyRudderResetTimeCoeff;
  final num? buoyancyRudderTimeCoeff;
  final num? maxBuoyancySpeedCoeff;
  final num? underwaterMaxRudderAngleCoeff;
  final bool? canUseOnEmpty;
  final String? logic;
  final num? criticalChance;
  final List<String>? source;
  final List<String>? target;
  final num? zoneRadius;
  final String? allyAuraBuff;
  final String? selfAuraBuff;
  final num? startDistance;
  final int? waveDistance;
  final String? waveParams;
  final String? absoluteBuff;
  final String? condition;
  final String? conditionalBuff;
  final String? targetBuff;
  final int? buoyancyState;
  final num? effectOnEndLongivity;
  final num? reloadBoostCoeff;
  final List<String>? weaponTypes;

  @override
  String toString() {
    var description = '';

    return description;
  }

  String _format(String key, num value) {
    final langKey = 'IDS_PARAMS_MODIFIER_' + key.toUpperCase();
    final description = GameRepository.instance.stringOf(langKey);
    if (description == ' ') return '';

    final valueString = value.toDecimalString();

    if (key.contains('time')) {
      return valueString + 's';
    }

    return valueString;
  }

  factory AbilityInfo.fromJson(Map<String, dynamic> json) => AbilityInfo(
        numConsumables: json['numConsumables'],
        preparationTime: json['preparationTime'],
        reloadTime: json['reloadTime'],
        workTime: json['workTime'],
        regenerationHPSpeed: json['regenerationHPSpeed'],
        regenerationHPSpeedUnits: json['regenerationHPSpeedUnits'],
        areaDamageMultiplier: json['areaDamageMultiplier'],
        bubbleDamageMultiplier: json['bubbleDamageMultiplier'],
        climbAngle: json['climbAngle'],
        distanceToKill: json['distanceToKill'],
        dogFightTime: json['dogFightTime'],
        fightersName: json['fightersName'],
        fightersNum: json['fightersNum'],
        flyAwayTime: json['flyAwayTime'],
        radius: json['radius'],
        timeDelayAttack: json['timeDelayAttack'],
        timeFromHeaven: json['timeFromHeaven'],
        timeToTryingCatch: json['timeToTryingCatch'],
        timeWaitDelayAttack: json['timeWaitDelayAttack'],
        artilleryDistCoeff: json['artilleryDistCoeff'],
        activationDelay: json['activationDelay'],
        height: json['height'],
        lifeTime: json['lifeTime'],
        spawnBackwardShift: json['spawnBackwardShift'],
        speedLimit: json['speedLimit'],
        startDelayTime: json['startDelayTime'],
        descIDs: json['descIDs'],
        iconIDs: json['iconIDs'],
        titleIDs: json['titleIDs'],
        backwardEngineForsag: json['backwardEngineForsag'],
        backwardEngineForsagMaxSpeed: json['backwardEngineForsagMaxSpeed'],
        boostCoeff: json['boostCoeff'],
        forwardEngineForsag: json['forwardEngineForsag'],
        forwardEngineForsagMaxSpeed: json['forwardEngineForsagMaxSpeed'],
        distShip: json['distShip'],
        distTorpedo: json['distTorpedo'],
        targetBuoyancyCoefficients: json['targetBuoyancyCoefficients'] == null
            ? null
            : Map.from(json['targetBuoyancyCoefficients'])
                .map((k, v) => MapEntry<String, num>(k, v as num)),
        torpedoReloadTime: json['torpedoReloadTime'],
        affectedClasses: json['affectedClasses'] == null
            ? null
            : List<String>.from(json['affectedClasses']),
        regenerationRate: json['regenerationRate'],
        ammo: json['ammo'],
        acousticWaveRadius: json['acousticWaveRadius'],
        updateFrequency: json['updateFrequency'],
        zoneLifetime: json['zoneLifetime'],
        buoyancyRudderResetTimeCoeff: json['buoyancyRudderResetTimeCoeff'],
        buoyancyRudderTimeCoeff: json['buoyancyRudderTimeCoeff'],
        maxBuoyancySpeedCoeff: json['maxBuoyancySpeedCoeff'],
        underwaterMaxRudderAngleCoeff: json['underwaterMaxRudderAngleCoeff'],
        canUseOnEmpty: json['canUseOnEmpty'],
        logic: json['logic'],
        criticalChance: json['criticalChance'],
        source:
            json['source'] == null ? null : List<String>.from(json['source']),
        target:
            json['target'] == null ? null : List<String>.from(json['target']),
        zoneRadius: json['zoneRadius'],
        allyAuraBuff: json['allyAuraBuff'],
        selfAuraBuff: json['selfAuraBuff'],
        startDistance: json['startDistance'],
        waveDistance: json['waveDistance'],
        waveParams: json['waveParams'],
        absoluteBuff: json['absoluteBuff'],
        condition: json['condition'],
        conditionalBuff: json['conditionalBuff'],
        targetBuff: json['targetBuff'],
        buoyancyState: json['buoyancyState'],
        effectOnEndLongivity: json['effectOnEndLongivity'],
        reloadBoostCoeff: json['reloadBoostCoeff'],
        weaponTypes: json['weaponTypes'] == null
            ? null
            : List<String>.from(json['weaponTypes']),
      );
}
