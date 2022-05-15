class Ability {
  Ability({
    required this.nation,
    required this.name,
    required this.description,
    required this.filter,
    required this.type,
    required this.abilities,
  });

  String nation;
  String name;
  String description;
  String filter;
  String type;
  Map<String, AbilityInfo> abilities;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        nation: json['nation'],
        name: json['name'],
        description: json['description'],
        filter: json['filter'],
        type: json['type'],
        abilities: Map.from(json['abilities']).map((k, v) =>
            MapEntry<String, AbilityInfo>(k, AbilityInfo.fromJson(v))),
      );
}

// TODO: too many fields but consumables are all different, what to do?
// TODO: we should probably use dynamic for this one I guess
class AbilityInfo {
  AbilityInfo({
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

  int? numConsumables;
  num? preparationTime;
  num? reloadTime;
  num? workTime;
  num? regenerationHPSpeed;
  num? regenerationHPSpeedUnits;
  num? areaDamageMultiplier;
  num? bubbleDamageMultiplier;
  int? climbAngle;
  num? distanceToKill;
  num? dogFightTime;
  String? fightersName;
  int? fightersNum;
  num? flyAwayTime;
  num? radius;
  num? timeDelayAttack;
  num? timeFromHeaven;
  num? timeToTryingCatch;
  num? timeWaitDelayAttack;
  num? artilleryDistCoeff;
  num? activationDelay;
  num? height;
  num? lifeTime;
  num? spawnBackwardShift;
  num? speedLimit;
  num? startDelayTime;
  String? descIDs;
  String? iconIDs;
  String? titleIDs;
  num? backwardEngineForsag;
  num? backwardEngineForsagMaxSpeed;
  num? boostCoeff;
  num? forwardEngineForsag;
  num? forwardEngineForsagMaxSpeed;
  num? distShip;
  num? distTorpedo;
  Map<String, num>? targetBuoyancyCoefficients;
  num? torpedoReloadTime;
  List<String>? affectedClasses;
  num? regenerationRate;
  String? ammo;
  num? acousticWaveRadius;
  num? updateFrequency;
  num? zoneLifetime;
  num? buoyancyRudderResetTimeCoeff;
  num? buoyancyRudderTimeCoeff;
  num? maxBuoyancySpeedCoeff;
  num? underwaterMaxRudderAngleCoeff;
  bool? canUseOnEmpty;
  String? logic;
  num? criticalChance;
  List<String>? source;
  List<String>? target;
  num? zoneRadius;
  String? allyAuraBuff;
  String? selfAuraBuff;
  num? startDistance;
  int? waveDistance;
  String? waveParams;
  String? absoluteBuff;
  String? condition;
  String? conditionalBuff;
  String? targetBuff;
  int? buoyancyState;
  num? effectOnEndLongivity;
  num? reloadBoostCoeff;
  List<String>? weaponTypes;

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
