import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipInfo.dart';

/// This is the `Plugin` class
class Plugin extends Cacheable {
  Map<String, ShipConsumable> consumable;
  Map<String, Modernization> upgrade;
  Map<String, OldShip> oldShip;
  Map<String, ShipWiki> shipWiki;

  ShipConsumableData getConsumable(ShipConsumableValue v) => consumable[v.name].getConsumable(v.type);

  Plugin.fromJson(Map<String, dynamic> json) {
    this.consumable = (json['consumables'] as Map).map((a, b) => MapEntry(a, ShipConsumable.fromJson(b)));
    this.upgrade = (json['upgrades'] as Map).map((a, b) => MapEntry(a, Modernization.fromJson(b)));
    this.oldShip = (json['old_ships'] as Map).map((a, b) => MapEntry(a, OldShip.fromJson(b)));
    this.shipWiki = (json['ship_wiki'] as Map).map((a, b) => MapEntry(a, ShipWiki.fromJson(b)));
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
  void save() => cached.savePlugin(this);
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
    // This is crazy...
    this.data = (json['data'] as Map).map((a, b) => MapEntry(a, ShipConsumableData.fromJson(b)));
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
class ShipConsumableData {
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
  List<String> affectedClasses; // this is for the radar that can only spots bb and cv
  // Torpedo reload booster
  double torpedoReloadTime;
  // Gun booster, boostCoeff is also here
  double criticalChance; // not idea what this is for

  String get spotShipDistance => '${_convertToKM(distShip)} km';
  String get spotTorpedoDistance => '${_convertToKM(distTorpedo)} km';

  String get hpRegeneration => '${_convertMultiplier(regenerationHPSpeed)}';
  String get artilleryDistance => '${_convertMultiplier(artilleryDistCoeff)}';
  /// For both engine boost and gun booster
  String get boostPercentage => '${_convertMultiplier(boostCoeff)}';

  // Some utils
  /// WG doesn't use km in the game
  String _convertToKM(double dist) => (dist / 33.35).toStringAsFixed(2);
  /// Convert Multiplier to a string, +0.5%, +20.0%
  String _convertMultiplier(double coeff) => '+ ${(coeff * 100).toStringAsFixed(1)}%';

  ShipConsumableData.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];

    this.numConsumable = json['numConsumables'];
    
    this.regenerationHPSpeed = json['regenerationHPSpeed'];

    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    // It can be int sometimes
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

    this.torpedoReloadTime = json['regenerationHPSpeed'];

    this.criticalChance = json['criticalChance'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Modernization` class
class Modernization {
  int slot;
  // This is the top priority, if it is in it, stop checking
  List<String> ship;
  // Then, we need to check the level, type and nation if exists
  List<int> shiplevel;
  List<String> shiptype;
  List<String> nation;

  bool get nationOnly => nation.length > 0;

  bool compatible(WikiShipInfo info) {
    if (ship.contains(info.shipIdStr)) return true;
    else if (shiplevel.contains(info.tier) && shiptype.contains(info.type)) {
      if (nationOnly) return nation.contains(info.nation);
      return true;
    }

    return false;
  }

  Modernization.fromJson(Map<String, dynamic> json) {
    this.slot = json['slot'];
    this.ship = (json['ships'] ?? []).cast<String>();
    this.shiplevel = (json['shiplevel'] ?? []).cast<int>();
    this.shiptype = (json['shiptype'] ?? []).cast<String>();
    this.nation = (json['nation'] ?? []).cast<String>();
  }

  Map<String, dynamic> toJson() {
    return {
      'slot': this.slot,
      'shiplevel': this.shiplevel,
      'ships': this.ship,
      'shiptype': this.shiptype,
      'nation': this.nation,
    };
  }
}

/// This is the `OldShip` class, for removed ship name and tier
class OldShip {
  String name;
  int tier;

  OldShip.fromJson(Map<String, dynamic> json) {
    // Add this letter to mark that it has been removed
    this.name = json['name'] + ' 𐌈';
    this.tier = json['tier'];
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
  APCurve ap;
  double sigma;
  /// First list is the slot but then one slot can have 2 consumables
  List<List<ShipConsumableValue>> consumable;
  bool isPaperShip;
  List<int> permoflage;
  int battle;

  String get sigmaString => '${sigma.toStringAsFixed(2)}';
  String get hePenString => '${alphaPiercingHE.toStringAsFixed(0)} mm';

  ShipWiki.fromJson(Map<String, dynamic> json) {
    this.alphaPiercingHE = json['alphaPiercingHE'];
    if (json['ap'] != null) this.ap = APCurve.fromJson(json['ap']);
    this.sigma = json['sigma'];
    // Another crazy one
    this.consumable = (json['consumables'] as List).map((slot) {
      return (slot as List).map((c) => ShipConsumableValue.fromJson(c)).toList(growable: false);
    }).toList(growable: false);
      
    this.isPaperShip = json['isPaperShip'] ?? false;
    this.permoflage = (json['permoflages'] ?? []).cast<int>();
    this.battle = json['battles'];
  }

  Map<String, dynamic> toJson() {
    return {
      'alphaPiercingHE': this.alphaPiercingHE,
      'ap': this.ap,
      'sigma': this.sigma,
      'consumables': this.consumable,
      'isPaperShip': this.isPaperShip,
      'permoflages': this.permoflage,
      'battles': this.battle,
    };
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
