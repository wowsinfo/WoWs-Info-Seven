import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiItem.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipInfo.dart';

/// This is the `Plugin` class
class Plugin implements Cacheable {
  Map<String, ShipConsumable> consumable;
  Map<String, Modernization> upgrade;
  Map<String, OldShip> oldShip;
  Map<String, ShipWiki> shipWiki;

  ShipConsumableData getConsumable(ShipConsumableValue v) =>
      consumable[v.name].getConsumable(v.type);
  OldShip getShip(int key) => oldShip[key.toString()];

  Plugin.fromJson(Map<String, dynamic> json) {
    this.consumable = (json['consumables'] as Map)
        .map((a, b) => MapEntry(a, ShipConsumable.fromJson(b)));
    this.upgrade = (json['upgrades'] as Map)
        .map((a, b) => MapEntry(a, Modernization.fromJson(b)));
    // Set ship id here
    this.oldShip = (json['old_ships'] as Map)
        .map((a, b) => MapEntry(a, OldShip.fromJson(b)..shipId = int.parse(a)));
    this.shipWiki = (json['ship_wiki'] as Map)
        .map((a, b) => MapEntry(a, ShipWiki.fromJson(b)));
  }

  Map<String, dynamic> toJson() {
    return {
      'consumables': this.consumable.cast<String, dynamic>(),
      'upgrades': this.upgrade.cast<String, dynamic>(),
      'old_ships': this.oldShip.cast<String, dynamic>(),
      'ship_wiki': this.shipWiki.cast<String, dynamic>(),
    };
  }

  @override
  bool isValid() =>
      consumable.isNotEmpty &&
      upgrade.isNotEmpty &&
      oldShip.isNotEmpty &&
      shipWiki.isNotEmpty;

  @override
  output() => jsonEncode(toJson());
}

/// This is the `ShipConsumable` class
class ShipConsumable {
  bool canBuy;
  int costCR;
  bool freeOfCharge;
  int id;
  String index;
  String name;
  Map<String, ShipConsumableData> data;

  ShipConsumableData getConsumable(String key) => data[key];

  ShipConsumable.fromJson(Map<String, dynamic> json) {
    this.canBuy = json['canBuy'];
    this.costCR = json['costCR'];
    this.freeOfCharge = json['freeOfCharge'];
    this.id = json['id'];
    this.index = json['index'];
    this.name = json['name'];
    // Set name to the key
    this.data = (json['data'] as Map)
        .map((a, b) => MapEntry(a, ShipConsumableData.fromJson(b)..name = a));
  }

  Map<String, dynamic> toJson() {
    return {
      'canBuy': this.canBuy,
      'costCR': this.costCR,
      'freeOfCharge': this.freeOfCharge,
      'id': this.id,
      'index': this.index,
      'name': this.name,
      // Make it dynamic and see if it works
      'data': this.data.cast<String, dynamic>(),
    };
  }
}

/// This is the `ShipConsumableData` class, `this is actual data for the consumable`
class ShipConsumableData extends WikiItem {
  String image;
  // All consumables has this
  String consumableType;
  double reloadTime;
  double workTime;

  // Optional, if null, it is unlimited
  int numConsumable;
  // Repair party, per second
  double regenerationHPSpeed;
  // Anti-AA
  double areaDamageMultiplier;
  num bubbleDamageMultiplier;
  // Fighter, there are too many info so I only take a few
  String fightersName;
  int fightersNum;
  double radius;
  // Spotter, the multiplier
  double artilleryDistCoeff;
  // Smoke, radius is also here
  double lifeTime;
  double speedLimit;
  // Engine boost
  double boostCoeff;
  // Sonar and radar, divide by 33.35 to km
  double distShip;
  double distTorpedo;
  List<String>
      affectedClasses; // this is for the radar that can only spots bb and cv
  // Torpedo reload booster
  double torpedoReloadTime;
  // Gun booster, boostCoeff is also here
  double criticalChance; // not idea what this is for

  String get spotShipDistance => '${_toKM(distShip)} km';
  String get spotTorpedoDistance => '${_toKM(distTorpedo)} km';

  String get hpRegeneration => '${_toPercent(regenerationHPSpeed)}';
  String get artilleryDistance => '${_toPercent(artilleryDistCoeff)}';

  /// For both engine boost and gun booster
  String get boostPercentage => '${_toPercent(boostCoeff)}';

  // Some utils
  /// WG doesn't use km in the game
  String _toKM(double v) =>
      v != null ? '${(v / 33.35).toStringAsFixed(1)} km' : null;

  /// Convert Multiplier to a string, +0.5%, +20.0%
  String _toPercent(double v) =>
      v != null ? '+${(v * 100).toStringAsFixed(1)}%' : null;
  String _toTime(num v) => v != null ? '$v s' : null;
  String _toKnot(num v) => v != null ? '$v kt' : null;
  String _toMeter(num v) => v != null ? '$v m' : null;

  ///
  String _getDescription(BuildContext context) {
    // final lang = AppLocalizationService.of(context);
    final list = {
      'type': consumableType,
      'reload time': _toTime(reloadTime),
      'active time': _toTime(workTime),
      'number of charge': numConsumable ?? '∞',
      'HP regeneration/s': _toPercent(regenerationHPSpeed),
      'area damage': _toPercent(areaDamageMultiplier),
      'bubble damage': _toPercent(bubbleDamageMultiplier),
      'fighter name': fightersName,
      'number of fighters': fightersNum,
      'radius': _toMeter(radius),
      'artillery range boost': _toPercent(artilleryDistCoeff),
      'life time': _toTime(lifeTime),
      'speed limit': _toKnot(speedLimit),
      'boost': _toPercent(boostCoeff),
      'detect ship distance': _toKM(distShip),
      'detect torpedo distance': _toKM(distTorpedo),
      'torpedo reload time': _toTime(torpedoReloadTime),
    }..removeWhere((_, v) => v == null);

    return list.entries
        .map((e) => e.key + ': ' + e.value.toString())
        .join(('\n'));
  }

  ShipConsumableData.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];

    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];

    this.numConsumable = json['numConsumables'];

    this.regenerationHPSpeed = json['regenerationHPSpeed'];

    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];

    this.fightersName = json['fightersName'];
    this.fightersNum = json['fightersNum'];
    this.radius = json['radius'];

    this.artilleryDistCoeff = json['artilleryDistCoeff'];

    this.lifeTime = json['lifeTime'];
    this.speedLimit = json['speedLimit'];

    this.boostCoeff = json['boostCoeff'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.affectedClasses = (json['affectedClasses'] ?? []).cast<String>();

    this.torpedoReloadTime = json['torpedoReloadTime'];

    this.criticalChance = json['criticalChance'];

    /// Setup field for `wiki item`
    this.image = 'assets/consumables/$consumableType.png';
  }

  Map<String, dynamic> toJson() {
    // This is why I don't want to do this
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'fightersName': this.fightersName,
      'fightersNum': this.fightersNum,
      'radius': this.radius,
      'artilleryDistCoeff': this.artilleryDistCoeff,
      'lifeTime': this.lifeTime,
      'speedLimit': this.speedLimit,
      'boostCoeff': this.boostCoeff,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'affectedClasses': this.affectedClasses,
      'torpedoReloadTime': this.torpedoReloadTime,
      'criticalChance': this.criticalChance,
    }..removeWhere((key, value) => value == null);
  }

  @override
  Future displayDialog(BuildContext context) {
    final info = _getDescription(context);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          contentPadding: const EdgeInsets.all(2),
          isThreeLine: true,
          title: Text('$consumableType $name'),
          subtitle: Text(info),
          leading: Image.asset(image),
        ),
      ),
    );
  }
}

/// This is the `Modernization` class
class Modernization {
  int slot;
  // This is the top priority, if it is in it, stop checking
  List<String> ship;
  List<String> exclude;
  // Then, we need to check the level, type and nation if exists
  List<int> shiplevel;
  List<String> shiptype;
  List<String> nation;

  bool get nationOnly => nation.length > 0;

  bool compatible(WikiShipInfo info) {
    if (exclude.contains(info.shipIdStr))
      return false;
    else if (ship.contains(info.shipIdStr))
      return true;
    else if (shiplevel.contains(info.tier) && shiptype.contains(info.type)) {
      if (nationOnly) return nation.contains(info.nation);
      return true;
    }

    return false;
  }

  Modernization.fromJson(Map<String, dynamic> json) {
    this.slot = json['slot'];
    this.ship = (json['ships'] ?? []).cast<String>();
    this.exclude = (json['excludes'] ?? []).cast<String>();
    this.shiplevel = (json['shiplevel'] ?? []).cast<int>();
    this.shiptype = (json['shiptype'] ?? []).cast<String>();
    this.nation = (json['nation'] ?? []).cast<String>();
  }

  Map<String, dynamic> toJson() {
    return {
      'slot': this.slot,
      'ships': this.ship,
      'excludes': this.exclude,
      'shiplevel': this.shiplevel,
      'shiptype': this.shiptype,
      'nation': this.nation,
    };
  }
}

/// This is the `OldShip` class, for removed ship name and tier
class OldShip extends Warship {
  String name;
  int tier;

  OldShip.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    // Add a marker
    this.name += ' 𐌈';
    this.isPremium = false;
    this.isSpecial = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'tier': this.tier,
    };
  }
}

/// This is the `ShipWiki` class
class ShipWiki {
  double alphaPiercingHE;
  double alphaPiercingCS;
  APCurve ap;
  double sigma;

  /// First list is the slot but then one slot can have 2 consumables
  List<List<ShipConsumableValue>> consumable;
  bool isPaperShip;
  List<int> permoflage;
  int battle;

  String get sigmaString => '${sigma.toStringAsFixed(2)}';
  String get hePenString => '${alphaPiercingHE.toStringAsFixed(1)} mm';
  String get csPenString => '${alphaPiercingCS.toStringAsFixed(1)} mm';

  ShipWiki.fromJson(Map<String, dynamic> json) {
    if (json['alphaPiercingHE'] != null)
      this.alphaPiercingHE = json['alphaPiercingHE'];
    if (json['alphaPiercingCS'] != null)
      this.alphaPiercingCS = json['alphaPiercingCS'];
    if (json['ap'] != null) this.ap = APCurve.fromJson(json['ap']);
    this.sigma = json['sigma'];
    // Another crazy one
    this.consumable = (json['consumables'] as List).map((slot) {
      return (slot as List)
          .map((c) => ShipConsumableValue.fromJson(c))
          .toList(growable: false);
    }).toList(growable: false);

    this.isPaperShip = json['isPaperShip'] ?? false;
    this.permoflage = (json['permoflages'] ?? []).cast<int>();
    this.battle = json['battles'];
  }

  Map<String, dynamic> toJson() {
    return {
      'alphaPiercingHE': this.alphaPiercingHE,
      'alphaPiercingCS': this.alphaPiercingCS,
      'ap': this.ap,
      'sigma': this.sigma,
      'consumables': this.consumable,
      'isPaperShip': this.isPaperShip,
      'permoflages': this.permoflage,
      'battles': this.battle,
    }..removeWhere((_, v) => v == null);
  }
}

/// This is the `ShipConsumableValue` class, it has the type and name
class ShipConsumableValue {
  String name;
  String type;

  ShipConsumableValue.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'type': this.type,
    };
  }
}

/// This is the `APCurve` class
class APCurve {
  double weight;
  double diameter;
  double drag;
  double velocity;
  double krupp;

  APCurve.fromJson(Map<String, dynamic> json) {
    this.weight = json['weight'];
    this.diameter = json['diameter'];
    this.drag = json['drag'];
    this.velocity = json['velocity'];
    this.krupp = json['krupp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': this.weight,
      'diameter': this.diameter,
      'drag': this.drag,
      'velocity': this.velocity,
      'krupp': this.krupp,
    };
  }

  // Get chart data here?
}
