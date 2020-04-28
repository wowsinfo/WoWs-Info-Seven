import 'package:wowsinfo/core/data/CachedData.dart';

import 'WikiShipModule.dart';

/// This is the `WikiShipInfo` class
class WikiShipInfo {
  String description;
  int priceGold;
  String shipIdStr;
  bool hasDemoProfile;
  Module module;
  ModulesTree modulesTree;
  String nation;
  bool isPremium;
  int shipId;
  int priceCredit;
  WikiShipModule defaultProfile;
  List<int> upgrade;
  int tier;
  NextShip nextShip;
  int modSlot;
  String type;
  bool isSpecial;
  String name;

  bool get hasOtherModules => module.hasOtherModules;

  WikiShipInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null) {
      this.description = json['description'];
      this.priceGold = json['price_gold'];
      this.shipIdStr = json['ship_id_str'];
      this.hasDemoProfile = json['has_demo_profile'];
      if (json['modules'] != null) this.module = Module(json['modules']);
      if (json['modules_tree'] != null) this.modulesTree = ModulesTree(json['modules_tree']);
      this.nation = json['nation'];
      this.isPremium = json['is_premium'];
      this.shipId = json['ship_id'];
      this.priceCredit = json['price_credit'];
      if (json['default_profile'] != null) this.defaultProfile = WikiShipModule(json['default_profile']);
      this.upgrade = (json['upgrades'] ?? []).cast<int>();
      this.tier = json['tier'];
      if (json['next_ships'] != null) this.nextShip = NextShip(json['next_ships']);
      this.modSlot = json['mod_slots'];
      this.type = json['type'];
      this.isSpecial = json['is_special'];
      this.name = json['name'];
    }
  }
}

/// This is the `Module` class
class Module {
  List<int> engine;
  List<int> torpedoBomber;
  List<int> fighter;
  List<int> hull;
  List<int> artillery;
  List<int> torpedo;
  List<int> fireControl;
  List<int> flightControl;
  List<int> diveBomber;
  final _module = CachedData.shared.shipModule;

  // at least two items in it
  bool get hasOtherModules => moduleMap.values.any((element) => element.length > 1);
  Map<String, List<int>> get moduleMap => {
    _module.engine: engine,
    _module.torpedoBomber: torpedoBomber,
    _module.fighter: fighter,
    _module.hull: hull,
    _module.artillery: artillery,
    _module.torpedo: torpedo,
    _module.suo: fireControl,
    _module.flightControl: flightControl,
    _module.diveBomber: diveBomber,
  };

  Module(Map<String, dynamic> json) {
    this.engine = (json['engine'] ?? []).cast<int>();
    this.torpedoBomber = (json['torpedo_bomber'] ?? []).cast<int>();
    this.fighter = (json['fighter'] ?? []).cast<int>();
    this.hull = (json['hull'] ?? []).cast<int>();
    this.artillery = (json['artillery'] ?? []).cast<int>();
    this.torpedo = (json['torpedoes'] ?? []).cast<int>();
    this.fireControl = (json['fire_control'] ?? []).cast<int>();
    this.flightControl = (json['flight_control'] ?? []).cast<int>();
    this.diveBomber = (json['dive_bomber'] ?? []).cast<int>();
  }
}

/// This is the `ModulesTree` class
class ModulesTree {
  Map<String, Part> parts;

  Part getPart(int id) => parts[id.toString()];

  ModulesTree(Map<String, dynamic> json) {
    parts = json.map((key, value) => MapEntry(key, Part(value)));
  }
}

/// This is the `Part` class
class Part {
  String name;
  List<int> nextModule;
  bool isDefault;
  int priceXp;
  int priceCredit;
  List<int> nextShip;
  int moduleId;
  String type;
  String moduleIdStr;

  bool get hasNextModule => nextModule.length > 0;
  String get xpString => '$priceXp xp';
  String get creditString => '$priceCredit';

  Part(Map<String, dynamic> json) {
    this.name = json['name'];
    this.nextModule = (json['next_modules'] ?? []).cast<int>();
    this.isDefault = json['is_default'];
    this.priceXp = json['price_xp'];
    this.priceCredit = json['price_credit'];
    this.nextShip = (json['next_ships'] ?? []).cast<int>();
    this.moduleId = json['module_id'];
    this.type = json['type'];
    this.moduleIdStr = json['module_id_str'];
  }

  int compareTo(Part other) {
    // Copied from https://github.com/HenryQuan/WoWs-Info-Future/blob/legacy_version/WoWsInfo/src/page/wiki/WarshipModule.js
    if (this.priceXp != other.priceXp) {
      return this.priceXp.compareTo(other.priceXp);      
    } else if (this.hasNextModule && other.hasNextModule) {
      // Check if the next module of this is actually other
      return (this.nextModule.first == other.moduleId) ? -1 : 1;
    } else {
      return this.hasNextModule ? -1 : 1;
    }
  }
}

/// This is the `NextShip` class
class NextShip {
  Map<String, int> ships;

  NextShip(Map<String, dynamic> json) {
    ships = json.cast<String, int>();
  }
}
