/// This is the `Plugin` class
class Plugin {
  Map<String, Consumable> consumable;
  Map<String, Upgrade> upgrade;
  Map<String, OldShip> oldShip;
  Map<String, ShipWiki> shipWiki;

  Plugin.fromJson(Map<String, dynamic> json) {
    this.consumable = json['consumables'];
    this.upgrade = json['upgrades'];
    this.oldShip = json['old_ships'];
    this.shipWiki = json['ship_wiki'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumables': this.consumable,
      'upgrades': this.upgrade,
      'old_ships': this.oldShip,
      'ship_wiki': this.shipWiki,
    };
  }
}

/// This is the `Consumable` class
class Consumable {
  bool canBuy;
  int costCR;
  bool freeOfCharge;
  int id;
  String index;
  String name;
  List<Map<String, ConsumableData>> data;

  Consumable.fromJson(Map<String, dynamic> json) {
    this.canBuy = json['canBuy'];
    this.costCR = json['costCR'];
    this.freeOfCharge = json['freeOfCharge'];
    this.id = json['id'];
    this.index = json['index'];
    this.name = json['name'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    return {
      'canBuy': this.canBuy,
      'costCR': this.costCR,
      'freeOfCharge': this.freeOfCharge,
      'id': this.id,
      'index': this.index,
      'name': this.name,
      'data': this.data,
    };
  }
}

/// This is the `ConsumableData` class
class ConsumableData {
  // All consumables has this
  String consumableType;
  int reloadTime;
  int workTime;

  // Optional, if null, it is unlimited
  int numConsumable;
  // Repair party, per second
  double regenerationHPSpeed;
  // Anti-AA
  int areaDamageMultiplier;
  int bubbleDamageMultiplier;
  // Fighter, there are too many info so I only take a few
  String fightersName;
  int fightersNum;
  int radius;
  // Spotter, the multiplier
  double artilleryDistCoeff;
  // Smoke, radius is also here
  int lifeTime;
  double speedLimit;
  // Engine boost
  double boostCoeff;
  // Sonar and radar, divide by 33.35 to km
  int distShip;
  int distTorpedo;
  List<String> affectedClasses; // this is for the radar that can only spots bb and cv
  // Torpedo reload booster
  int torpedoReloadTime;
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
  String _convertToKM(int dist) => (dist / 33.35).toStringAsFixed(2);
  /// Convert Multiplier to a string, +0.5%, +20.0%
  String _convertMultiplier(double coeff) => '+ ${(coeff * 100).toStringAsFixed(1)}%';

  ConsumableData.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Upgrade` class
class Upgrade {
  int slot;
  // This is the top priority, if it is in it, stop checking
  List<String> ship;
  // Then, we need to check the level, type and nation if exists
  List<int> shiplevel;
  List<String> shiptype;
  List<String> nation;

  Upgrade.fromJson(Map<String, dynamic> json) {
    this.slot = json['slot'];
    this.shiplevel = json['shiplevel'];
    this.ship = json['ships'];
    this.shiptype = json['shiptype'];
    this.nation = json['nation'];
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
  List<ShipConsumable> consumable;
  bool isPaperShip;
  List<int> permoflage;
  int battle;

  ShipWiki.fromJson(Map<String, dynamic> json) {
    this.alphaPiercingHE = json['alphaPiercingHE'];
    this.ap = json['ap'];
    this.sigma = json['sigma'];
    this.consumable = json['consumables'];
    this.isPaperShip = json['isPaperShip'];
    this.permoflage = json['permoflages'];
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

/// This is the `ShipConsumable` class
class ShipConsumable {
  String name;
  String type;

  ShipConsumable.fromJson(Map<String, dynamic> json) {
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
