import 'WikiShipModule.dart';

/// This is the `WikiShipInfo` class
class WikiShipInfo {
  String description;
  int priceGold;
  String shipIdStr;
  bool hasDemoProfile;
  Image image;
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

  WikiShipInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null) {
      this.description = json['description'];
      this.priceGold = json['price_gold'];
      this.shipIdStr = json['ship_id_str'];
      this.hasDemoProfile = json['has_demo_profile'];
      if (json['images'] != null) this.image = Image(json['images']);
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

/// This is the `Image` class
class Image {
  String small;
  String large;
  String medium;
  String contour;

  Image(Map<String, dynamic> json) {
    this.small = json['small'];
    this.large = json['large'];
    this.medium = json['medium'];
    this.contour = json['contour'];
  }
}

/// This is the `Module` class
class Module {
  List<int> engine;
  List<int> torpedoBomber;
  List<int> fighter;
  List<int> hull;
  List<int> artillery;
  List<int> torpedoe;
  List<int> fireControl;
  List<int> flightControl;
  List<int> diveBomber;

  Module(Map<String, dynamic> json) {
    this.engine = (json['engine'] ?? []).cast<int>();
    this.torpedoBomber = (json['torpedo_bomber'] ?? []).cast<int>();
    this.fighter = (json['fighter'] ?? []).cast<int>();
    this.hull = (json['hull'] ?? []).cast<int>();
    this.artillery = (json['artillery'] ?? []).cast<int>();
    this.torpedoe = (json['torpedoes'] ?? []).cast<int>();
    this.fireControl = (json['fire_control'] ?? []).cast<int>();
    this.flightControl = (json['flight_control'] ?? []).cast<int>();
    this.diveBomber = (json['dive_bomber'] ?? []).cast<int>();
  }
}

/// This is the `ModulesTree` class
class ModulesTree {
  Map<String, Part> parts;

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
}

/// This is the `NextShip` class
class NextShip {
  Map<String, int> ships;

  NextShip(Map<String, dynamic> json) {
    ships = json.cast<String, int>();
  }
}
