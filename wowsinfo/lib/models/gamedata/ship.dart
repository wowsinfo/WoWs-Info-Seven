import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/gamedata/game_info.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';

import 'consumable.dart';

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
    this.airDefense,
    required this.modules,
    required this.components,
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
  final AirDefense? airDefense;
  final Map<String, List<ShipModuleInfo>> modules;
  final Map<String, dynamic> components;

  /// Convert to tier symbol, [tier] starts from 1.
  String get tierString => GameInfo.tiers[tier - 1];

  @override
  String toString() {
    return 'Ship{name: $name, description: $description, year: $year, paperShip: $paperShip, id: $id, index: $index, tier: $tier, region: $region, type: $type, group: $group, consumables: $consumables, costXp: $costXp, costGold: $costGold, costCr: $costCr, nextShips: $nextShips, airDefense: $airDefense, modules: $modules, components: $components}';
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
        airDefense: json['airDefense'] == null
            ? null
            : AirDefense.fromJson(json['airDefense']),
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
  });

  final double range;
  final double sigma;
  final List<WeaponInfo> guns;

  factory GunInfo.fromJson(Map<String, dynamic> json) => GunInfo(
        range: json['range'],
        sigma: json['sigma'],
        guns: List<WeaponInfo>.from(
            json['guns'].map((x) => WeaponInfo.fromJson(x))),
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
    required this.reload,
    required this.bombs,
    required this.range,
  });

  final String name;
  final num reload;
  final int bombs;
  final double range;

  factory AirSupportInfo.fromJson(Map<String, dynamic> json) => AirSupportInfo(
        name: json['name'],
        reload: json['reload'],
        bombs: json['bombs'],
        range: json['range'],
      );
}

class FireControlInfo {
  FireControlInfo({
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

class PingerInfo {
  PingerInfo({
    required this.reload,
    required this.range,
    required this.lifeTime1,
    required this.lifeTime2,
    required this.speed,
  });

  final double reload;
  final int range;
  final int lifeTime1;
  final int lifeTime2;
  final int speed;

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
    required this.visibility,
    required this.mobility,
  });

  final double health;
  final VisibilityInfo visibility;
  final MobilityInfo mobility;

  factory HullInfo.fromJson(Map<String, dynamic> json) => HullInfo(
        health: json['health'],
        visibility: VisibilityInfo.fromJson(json['visibility']),
        mobility: MobilityInfo.fromJson(json['mobility']),
      );
}

@immutable
class MobilityInfo {
  const MobilityInfo({
    required this.speed,
    required this.turningRadius,
    required this.rudderTime,
  });

  final double speed;
  final double turningRadius;
  final double rudderTime;

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
class WeaponInfo {
  const WeaponInfo({
    required this.reload,
    required this.rotation,
    required this.each,
    required this.ammo,
    required this.vertSector,
    required this.count,
  });

  final double reload;
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
    this.bubbles,
  });

  final AuraInfo? medium;
  final AuraInfo? near;
  final AuraInfo? far;
  final AirBubbles? bubbles;

  factory AirDefense.fromJson(Map<String, dynamic> json) => AirDefense(
        medium:
            json['medium'] == null ? null : AuraInfo.fromJson(json['medium']),
        near: json['near'] == null ? null : AuraInfo.fromJson(json['near']),
        far: json['far'] == null ? null : AuraInfo.fromJson(json['far']),
        bubbles: json['bubbles'] == null
            ? null
            : AirBubbles.fromJson(json['bubbles']),
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
    required this.damage,
  });

  final int inner;
  final int outer;
  final num rof;
  final double minRange;
  final double maxRange;
  final double spawnTime;
  final num damage;

  factory AirBubbles.fromJson(Map<String, dynamic> json) => AirBubbles(
        inner: json['inner'],
        outer: json['outer'],
        rof: json['rof'],
        minRange: json['minRange'],
        maxRange: json['maxRange'],
        spawnTime: json['spawnTime'],
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
  });

  final double minRange;
  final double maxRange;
  final double hitChance;
  final num damage;
  final double rof;
  final num dps;

  factory AuraInfo.fromJson(Map<String, dynamic> json) => AuraInfo(
        minRange: json['minRange'],
        maxRange: json['maxRange'],
        hitChance: json['hitChance'],
        damage: json['damage'],
        rof: json['rof'],
        dps: json['dps'],
      );
}
