import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/gamedata/modifier.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';

import 'consumable.dart';

const _premiumGroups = [
  'special',
];

const _specialGroups = [
  'ultimate',
  'specialUnsellable',
  'upgradeableUltimate',
  'upgradeableExclusive',
  // removed ships or not in game
  'unavailable',
  'disabled',
  'preserved',
  // clan copy,
  'clan',
  // others
  'earlyAccess',
  'demoWithoutStats',
  'demoWithStats'
];

const _specialShipGroups = [
  'preserved',
  'disabled',
  'clan',
  'unavailable',
  'coopOnly',
];

@immutable
class Ship implements ShipFilterInterface {
  const Ship({
    required this.name,
    required this.description,
    required this.year,
    required this.paperShip,
    required this.id,
    required this.index,
    required this.tier,
    required this.region,
    required this.type,
    required this.regionId,
    required this.typeId,
    required this.group,
    required this.consumables,
    required this.costXp,
    required this.costGold,
    required this.costCr,
    this.nextShips,
    required this.modules,
    required this.components,
    this.added,
  });

  @override
  final String name;
  final String description;
  final String year;
  final bool paperShip;
  final int id;
  final String index;
  @override
  final int tier;
  @override
  final String region;
  @override
  final String type;
  final String regionId;
  final String typeId;
  final String group;
  final List<List<Consumable>> consumables;
  final int costXp;
  final int costGold;
  final int costCr;
  final List<int>? nextShips;
  final Map<String, List<ShipModuleInfo>> modules;
  final Map<String, dynamic> components;
  final int? added;

  /// Convert to tier symbol, [tier] starts from 1.
  String get tierString => GameInfo.tiers[tier - 1];

  // TODO: we should move this to game data instead or not?
  bool get isSpecial => _specialGroups.contains(group);
  bool get isPremium => _premiumGroups.contains(group);
  bool get isSpecialGroup => _specialShipGroups.contains(group);

  @override
  String toString() {
    return 'Ship{name: $name, description: $description, year: $year, paperShip: $paperShip, id: $id, index: $index, tier: $tier, region: $region, type: $type, group: $group, consumables: $consumables, costXp: $costXp, costGold: $costGold, costCr: $costCr, nextShips: $nextShips, modules: $modules, components: $components}';
  }

  int greater(Ship other) {
    // sort by tier, type, nation
    if (tier == other.tier) {
      if (type == other.type) {
        if (region == other.region) {
          return id - other.id;
        }
        return region.compareTo(other.region);
      }
      // cv first
      return other.type.compareTo(type);
    }

    return tier - other.tier;
  }

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
        name: json['name'],
        description: json['description'],
        year: json['year'],
        paperShip: json['paperShip'],
        id: json['id'],
        index: json['index'],
        tier: json['tier'],
        region: json['region'],
        type: json['type'],
        regionId: json['regionID'],
        typeId: json['typeID'],
        group: json['group'],
        consumables: List<List<Consumable>>.from(json['consumables'].map((x) =>
            List<Consumable>.from(x.map((x) => Consumable.fromJson(x))))),
        costXp: json['costXP'],
        costGold: json['costGold'],
        costCr: json['costCR'],
        nextShips: json['nextShips'] == null
            ? null
            : List<int>.from(json['nextShips']),
        modules: Map<String, List<ShipModuleInfo>>.from(
          json['modules'].map(
            (x, y) => MapEntry<String, List<ShipModuleInfo>>(
              x,
              List<ShipModuleInfo>.from(
                  y.map((x) => ShipModuleInfo.fromJson(x))),
            ),
          ),
        ),
        components: Map.from(json['components']),
        added: json['added'],
      );
}

@immutable
class ShipModuleInfo {
  const ShipModuleInfo({
    required this.cost,
    required this.index,
    required this.name,
    required this.components,
  });

  final Cost cost;
  final int index;
  final String name;
  final Map<String, List<String>> components;

  factory ShipModuleInfo.fromJson(Map<String, dynamic> json) => ShipModuleInfo(
        cost: Cost.fromJson(json['cost']),
        index: json['index'],
        name: json['name'],
        components: Map.from(json['components']).map(
          (k, v) => MapEntry<String, List<String>>(k, List<String>.from(v)),
        ),
      );

  int compareTo(ShipModuleInfo other) {
    return index - other.index;
  }

  @override
  String toString() {
    return 'ShipModule{cost: $cost, index: $index, components: $components}';
  }
}

@immutable
class ShipComponent {}

@immutable
class GunInfo {
  const GunInfo({
    required this.range,
    required this.sigma,
    required this.guns,
    this.far,
    this.bubbles,
    this.burst,
  });

  final double range;
  final double sigma;
  final List<WeaponInfo> guns;
  final List<AuraInfo>? far;
  final AirBubbles? bubbles;
  final Burst? burst;

  factory GunInfo.fromJson(Map<String, dynamic> json) => GunInfo(
        range: json['range'],
        sigma: json['sigma'],
        guns: List<WeaponInfo>.from(
            json['guns'].map((x) => WeaponInfo.fromJson(x))),
        far: json['far'] == null
            ? null
            : List<AuraInfo>.from(json['far'].map((x) => AuraInfo.fromJson(x))),
        bubbles: json['bubbles'] == null
            ? null
            : AirBubbles.fromJson(json['bubbles']),
        burst: json['burst'] == null ? null : Burst.fromJson(json['burst']),
      );
}

@immutable
class Burst {
  const Burst({
    required this.burstReloadTime,
    required this.fullReloadTime,
    this.modifiers,
    required this.shotIntensity,
    required this.shotsCount,
  });

  final double burstReloadTime;
  final double fullReloadTime;
  final Modifiers? modifiers;
  final double shotIntensity;
  final int shotsCount;

  factory Burst.fromJson(Map<String, dynamic> json) => Burst(
        burstReloadTime: json['burstReloadTime'],
        fullReloadTime: json['fullReloadTime'],
        // This is just an empty {} for some burst fires
        modifiers: (json['modifiers'] as Map).isNotEmpty
            ? Modifiers.fromJson(json['modifiers'])
            : null,
        shotIntensity: json['shotIntensity'],
        shotsCount: json['shotsCount'],
      );
}

@immutable
class TorpedoInfo {
  const TorpedoInfo({
    required this.singleShot,
    required this.launchers,
  });

  final bool singleShot;
  final List<WeaponInfo> launchers;

  factory TorpedoInfo.fromJson(Map<String, dynamic> json) => TorpedoInfo(
        singleShot: json['singleShot'],
        launchers: List<WeaponInfo>.from(
            json['launchers'].map((x) => WeaponInfo.fromJson(x))),
      );
}

@immutable
class DepthChargeInfo {
  const DepthChargeInfo({
    required this.reload,
    required this.ammo,
    required this.bombs,
    required this.groups,
  });

  final num reload;
  final String ammo;
  final int bombs;
  final int groups;

  factory DepthChargeInfo.fromJson(Map<String, dynamic> json) =>
      DepthChargeInfo(
        reload: json['reload'],
        ammo: json['ammo'],
        bombs: json['bombs'],
        groups: json['groups'],
      );
}

@immutable
class AirSupportInfo {
  const AirSupportInfo({
    required this.name,
    required this.chargesNum,
    required this.plane,
    required this.reload,
    required this.range,
  });

  final String name;
  final num chargesNum;
  final String plane;
  final num reload;
  final double range;

  factory AirSupportInfo.fromJson(Map<String, dynamic> json) => AirSupportInfo(
        name: json['name'],
        chargesNum: json['chargesNum'],
        plane: json['plane'],
        reload: json['reload'],
        range: json['range'],
      );
}

@immutable
class FireControlInfo {
  const FireControlInfo({
    required this.maxDistCoef,
    required this.sigmaCountCoef,
  });

  final double maxDistCoef;
  final double sigmaCountCoef;

  factory FireControlInfo.fromJson(Map<String, dynamic> json) =>
      FireControlInfo(
        maxDistCoef: json['maxDistCoef'],
        sigmaCountCoef: json['sigmaCountCoef'],
      );
}

@immutable
class SpecialsInfo {
  const SpecialsInfo({
    required this.rageMode,
  });

  final RageMode rageMode;

  factory SpecialsInfo.fromJson(Map<String, dynamic> json) => SpecialsInfo(
        rageMode: RageMode.fromJson(json['rageMode']),
      );
}

/// The F key for tier 11s
@immutable
class RageMode {
  const RageMode({
    required this.boostDuration,
    required this.decrementCount,
    required this.decrementDelay,
    required this.decrementPeriod,
    required this.gunsForSalvo,
    this.modifiers,
    required this.radius,
    required this.rageModeName,
    required this.requiredHits,
  });

  final num boostDuration;
  final int decrementCount;
  final num decrementDelay;
  final num decrementPeriod;
  final int gunsForSalvo;
  final Modifiers? modifiers;
  final num radius;
  final String rageModeName;
  final int requiredHits;

  factory RageMode.fromJson(Map<String, dynamic> json) => RageMode(
        boostDuration: json['boostDuration'],
        decrementCount: json['decrementCount'],
        decrementDelay: json['decrementDelay'],
        decrementPeriod: json['decrementPeriod'],
        gunsForSalvo: json['gunsForSalvo'],
        modifiers: json['modifiers'] == null
            ? null
            : Modifiers.fromJson(json['modifiers']),
        radius: json['radius'],
        rageModeName: json['rageModeName'],
        requiredHits: json['requiredHits'],
      );
}

@immutable
class EngineInfo {
  const EngineInfo({
    required this.speedCoef,
  });

  final double speedCoef;

  factory EngineInfo.fromJson(Map<String, dynamic>? json) {
    // when it is 1, it is not specified
    if (json == null) return const EngineInfo(speedCoef: 1.0);
    return EngineInfo(speedCoef: json['speedCoef']);
  }
}

@immutable
class PingerInfo {
  const PingerInfo({
    required this.reload,
    required this.range,
    required this.lifeTime1,
    required this.lifeTime2,
    required this.speed,
  });

  final double reload;
  final num range;
  final num lifeTime1;
  final num lifeTime2;
  final num speed;

  num get rangeInKm => range / 1000;

  factory PingerInfo.fromJson(Map<String, dynamic> json) => PingerInfo(
        reload: json['reload'],
        range: json['range'],
        lifeTime1: json['lifeTime1'],
        lifeTime2: json['lifeTime2'],
        speed: json['speed'],
      );
}

@immutable
class HullInfo {
  const HullInfo({
    required this.health,
    this.protection,
    required this.visibility,
    required this.mobility,
    this.submarineBattery,
  });

  final num health;
  final double? protection;
  final VisibilityInfo visibility;
  final MobilityInfo mobility;
  final SubmarineBatteryInfo? submarineBattery;

  factory HullInfo.fromJson(Map<String, dynamic> json) => HullInfo(
        health: json['health'],
        protection: json['protection'],
        visibility: VisibilityInfo.fromJson(json['visibility']),
        mobility: MobilityInfo.fromJson(json['mobility']),
        submarineBattery: json['submarineBattery'] == null
            ? null
            : SubmarineBatteryInfo.fromJson(json['submarineBattery']),
      );
}

@immutable
class MobilityInfo {
  const MobilityInfo({
    required this.speed,
    required this.turningRadius,
    required this.rudderTime,
  });

  final num speed;
  final num turningRadius;
  final num rudderTime;

  factory MobilityInfo.fromJson(Map<String, dynamic> json) => MobilityInfo(
        speed: json['speed'],
        turningRadius: json['turningRadius'],
        rudderTime: json['rudderTime'],
      );
}

@immutable
class VisibilityInfo {
  const VisibilityInfo({
    required this.sea,
    required this.plane,
    required this.seaInSmoke,
    required this.planeInSmoke,
    required this.submarine,
    required this.seaFireCoeff,
    required this.planeFireCoeff,
  });

  final double sea;
  final double plane;
  final double seaInSmoke;
  final double planeInSmoke;
  final double submarine;
  final double seaFireCoeff;
  final double planeFireCoeff;

  factory VisibilityInfo.fromJson(Map<String, dynamic> json) => VisibilityInfo(
        sea: json['sea'],
        plane: json['plane'],
        seaInSmoke: json['seaInSmoke'],
        planeInSmoke: json['planeInSmoke'],
        submarine: json['submarine'],
        seaFireCoeff: json['seaFireCoeff'],
        planeFireCoeff: json['planeFireCoeff'],
      );
}

@immutable
class SubmarineBatteryInfo {
  const SubmarineBatteryInfo({
    required this.capacity,
    required this.regen,
  });

  final int capacity;
  final num regen;

  factory SubmarineBatteryInfo.fromJson(Map<String, dynamic> json) =>
      SubmarineBatteryInfo(
        capacity: json['capacity'],
        regen: json['regen'],
      );
}

@immutable
class WeaponInfo {
  const WeaponInfo({
    required this.reload,
    required this.rotation,
    required this.each,
    required this.ammo,
    required this.vertSector,
    required this.count,
  });

  final num reload;
  final double rotation;
  final int each;
  final List<String> ammo;
  final double vertSector;
  final int count;

  factory WeaponInfo.fromJson(Map<String, dynamic> json) => WeaponInfo(
        reload: json['reload'],
        rotation: json['rotation'],
        each: json['each'],
        ammo: List<String>.from(json['ammo']),
        vertSector: json['vertSector'],
        count: json['count'],
      );
}

@immutable
class Cost {
  const Cost({
    required this.costCr,
    required this.costXp,
  });

  final int costCr;
  final int costXp;

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        costCr: json['costCR'],
        costXp: json['costXP'],
      );

  @override
  String toString() {
    return 'Cost{costCr: $costCr, costXp: $costXp}';
  }
}

@immutable
class AirDefense {
  const AirDefense({
    this.medium,
    this.near,
    this.far,
  });

  final List<AuraInfo>? medium;
  final List<AuraInfo>? near;
  final List<AuraInfo>? far;

  factory AirDefense.fromJson(Map<String, dynamic> json) => AirDefense(
        medium: json['medium'] == null
            ? null
            : List<AuraInfo>.from(
                json['medium'].map((x) => AuraInfo.fromJson(x))),
        near: json['near'] == null
            ? null
            : List<AuraInfo>.from(
                json['near'].map((x) => AuraInfo.fromJson(x))),
        far: json['far'] == null
            ? null
            : List<AuraInfo>.from(json['far'].map((x) => AuraInfo.fromJson(x))),
      );
}

@immutable
class AirBubbles {
  const AirBubbles({
    required this.inner,
    required this.outer,
    required this.rof,
    required this.minRange,
    required this.maxRange,
    required this.spawnTime,
    required this.hitChance,
    required this.damage,
  });

  final int inner;
  final int outer;
  final num rof;
  final double minRange;
  final double maxRange;
  final double spawnTime;
  final double hitChance;
  final num damage;

  factory AirBubbles.fromJson(Map<String, dynamic> json) => AirBubbles(
        inner: json['inner'],
        outer: json['outer'],
        rof: json['rof'],
        minRange: json['minRange'],
        maxRange: json['maxRange'],
        spawnTime: json['spawnTime'],
        hitChance: json['hitChance'],
        damage: json['damage'],
      );
}

@immutable
class AuraInfo {
  const AuraInfo({
    required this.minRange,
    required this.maxRange,
    required this.hitChance,
    required this.damage,
    required this.rof,
    required this.dps,
    required this.guns,
  });

  final double minRange;
  final double maxRange;
  final double hitChance;
  final num damage;
  final double rof;
  final num dps;
  final List<AuraGuns> guns;

  factory AuraInfo.fromJson(Map<String, dynamic> json) => AuraInfo(
        minRange: json['minRange'],
        maxRange: json['maxRange'],
        hitChance: json['hitChance'],
        damage: json['damage'],
        rof: json['rof'],
        dps: json['dps'],
        guns:
            List<AuraGuns>.from(json['guns'].map((x) => AuraGuns.fromJson(x))),
      );
}

@immutable
class AuraGuns {
  const AuraGuns({
    required this.ammo,
    required this.name,
    required this.each,
    required this.count,
    required this.reload,
  });

  final String ammo;
  final String name;
  final int each;
  final int count;
  final double reload;

  factory AuraGuns.fromJson(Map<String, dynamic> json) => AuraGuns(
        ammo: json['ammo'],
        name: json['name'],
        each: json['each'],
        count: json['count'],
        reload: json['reload'],
      );
}
