import '../Meta.dart';

// TODO: This is based on Fubuki so she doesn't have secondary and cv related entries
// TODO: it is the best if I merge the data of fubuki, bb and cv

/// This is the `ShipWiki` class
class ShipWiki {
  Meta meta;
  Data data;

  ShipWiki(json) {
    this.meta = Meta(json["meta"]);
    this.data = Data(json["data"]);
  }
}

/// This is the `Data` class
class Data {
  ShipModuleInfo shipModule;

  Data(json) {
    this.shipModule = json["4183701200"];
  }
}

/// This is the `ShipModuleInfo` class
class ShipModuleInfo {
  String description;
  int priceGold;
  String shipIdStr;
  bool hasDemoProfile;
  Image image;
  Module module;
  Map<String, ModulesTree> modulesTree;
  String nation;
  bool isPremium;
  int shipId;
  int priceCredit;
  DefaultProfile defaultProfile;
  List<int> upgrade;
  int tier;
  NextShip nextShip;
  int modSlot;
  String type;
  bool isSpecial;
  String name;

  ShipModuleInfo(json) {
    this.description = json["description"];
    this.priceGold = json["price_gold"];
    this.shipIdStr = json["ship_id_str"];
    this.hasDemoProfile = json["has_demo_profile"];
    this.image = json["images"];
    this.module = json["modules"];
    this.modulesTree = json["modules_tree"];
    this.nation = json["nation"];
    this.isPremium = json["is_premium"];
    this.shipId = json["ship_id"];
    this.priceCredit = json["price_credit"];
    this.defaultProfile = json["default_profile"];
    this.upgrade = json["upgrades"];
    this.tier = json["tier"];
    this.nextShip = json["next_ships"];
    this.modSlot = json["mod_slots"];
    this.type = json["type"];
    this.isSpecial = json["is_special"];
    this.name = json["name"];
  }
}

/// This is the `Image` class
class Image {
  String small;
  String large;
  String medium;
  String contour;

  Image(json) {
    this.small = json["small"];
    this.large = json["large"];
    this.medium = json["medium"];
    this.contour = json["contour"];
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

  Module(json) {
    this.engine = json["engine"];
    this.torpedoBomber = json["torpedo_bomber"];
    this.fighter = json["fighter"];
    this.hull = json["hull"];
    this.artillery = json["artillery"];
    this.torpedoe = json["torpedoes"];
    this.fireControl = json["fire_control"];
    this.flightControl = json["flight_control"];
    this.diveBomber = json["dive_bomber"];
  }
}

/// This is the `TorpedoBomber` class
class TorpedoBomber {
  dynamic torpedoBomber;

  TorpedoBomber(json) {
    this.torpedoBomber = json["torpedoBomber"];
  }
}

/// This is the `Fighter` class
class Fighter {
  dynamic fighter;

  Fighter(json) {
    this.fighter = json["fighter"];
  }
}

/// This is the `FlightControl` class
class FlightControl {
  dynamic flightControl;

  FlightControl(json) {
    this.flightControl = json["flightControl"];
  }
}

/// This is the `DiveBomber` class
class DiveBomber {
  dynamic diveBomber;

  DiveBomber(json) {
    this.diveBomber = json["diveBomber"];
  }
}

/// This is the `ModulesTree` class, it has all info about a module
class ModulesTree {
  String name;
  List<int> nextModule;
  bool isDefault;
  int priceXp;
  int priceCredit;
  List<NextShip> nextShip;
  int moduleId;
  String type;
  String moduleIdStr;

  ModulesTree(json) {
    this.name = json["name"];
    this.nextModule = json["next_modules"];
    this.isDefault = json["is_default"];
    this.priceXp = json["price_xp"];
    this.priceCredit = json["price_credit"];
    this.nextShip = json["next_ships"];
    this.moduleId = json["module_id"];
    this.type = json["type"];
    this.moduleIdStr = json["module_id_str"];
  }
}

/// This is the `DefaultProfile` class
class DefaultProfile {
  Engine engine;
  Null torpedoBomber;
  AntiAircraft antiAircraft;
  Mobility mobility;
  Hull hull;
  Null atba;
  Artillery artillery;
  Torpedoe torpedoe;
  Null fighter;
  FireControl fireControl;
  Weaponry weaponry;
  int battleLevelRangeMax;
  int battleLevelRangeMin;
  Null flightControl;
  Concealment concealment;
  Armour armour;
  Null diveBomber;

  DefaultProfile(json) {
    this.engine = json["engine"];
    this.torpedoBomber = json["torpedo_bomber"];
    this.antiAircraft = json["anti_aircraft"];
    this.mobility = json["mobility"];
    this.hull = json["hull"];
    this.atba = json["atbas"];
    this.artillery = json["artillery"];
    this.torpedoe = json["torpedoes"];
    this.fighter = json["fighters"];
    this.fireControl = json["fire_control"];
    this.weaponry = json["weaponry"];
    this.battleLevelRangeMax = json["battle_level_range_max"];
    this.battleLevelRangeMin = json["battle_level_range_min"];
    this.flightControl = json["flight_control"];
    this.concealment = json["concealment"];
    this.armour = json["armour"];
    this.diveBomber = json["dive_bomber"];
  }
}

/// This is the `Engine` class
class Engine {
  String engineIdStr;
  int maxSpeed;
  int engineId;

  Engine(json) {
    this.engineIdStr = json["engine_id_str"];
    this.maxSpeed = json["max_speed"];
    this.engineId = json["engine_id"];
  }
}

/// This is the `AntiAircraft` class
class AntiAircraft {
  Map<String, AASlot> slot;
  int defense;

  AntiAircraft(json) {
    this.slot = json["slots"];
    this.defense = json["defense"];
  }
}

/// This is the `AASlot` class only for the `AntiAircraft` class
class AASlot {
  double distance;
  int avgDamage;
  int caliber;
  String name;
  int gun;

  AASlot(json) {
    this.distance = json["distance"];
    this.avgDamage = json["avg_damage"];
    this.caliber = json["caliber"];
    this.name = json["name"];
    this.gun = json["guns"];
  }
}

/// This is the `Mobility` class
class Mobility {
  double rudderTime;
  int total;
  int turningRadiu;
  int maxSpeed;

  Mobility(json) {
    this.rudderTime = json["rudder_time"];
    this.total = json["total"];
    this.turningRadiu = json["turning_radius"];
    this.maxSpeed = json["max_speed"];
  }
}

/// This is the `Hull` class
class Hull {
  int hullId;
  String hullIdStr;
  int torpedoesBarrel;
  int antiAircraftBarrel;
  Range range;
  int health;
  int planesAmount;
  int artilleryBarrel;
  int atbaBarrel;

  Hull(json) {
    this.hullId = json["hull_id"];
    this.hullIdStr = json["hull_id_str"];
    this.torpedoesBarrel = json["torpedoes_barrels"];
    this.antiAircraftBarrel = json["anti_aircraft_barrels"];
    this.range = json["range"];
    this.health = json["health"];
    this.planesAmount = json["planes_amount"];
    this.artilleryBarrel = json["artillery_barrels"];
    this.atbaBarrel = json["atba_barrels"];
  }
}

/// This is the `Range` class
class Range {
  int max;
  int min;

  Range(json) {
    this.max = json["max"];
    this.min = json["min"];
  }
}

/// This is the `Artillery` class
class Artillery {
  int maxDispersion;
  Shell shell;
  int shotDelay;
  double rotationTime;
  double distance;
  int artilleryId;
  String artilleryIdStr;
  Slot slot;
  double gunRate;

  Artillery(json) {
    this.maxDispersion = json["max_dispersion"];
    this.shell = json["shells"];
    this.shotDelay = json["shot_delay"];
    this.rotationTime = json["rotation_time"];
    this.distance = json["distance"];
    this.artilleryId = json["artillery_id"];
    this.artilleryIdStr = json["artillery_id_str"];
    this.slot = json["slots"];
    this.gunRate = json["gun_rate"];
  }
}

/// This is the `Shell` class
class Shell {
  AP ap;
  HE he;

  Shell(json) {
    this.ap = json["AP"];
    this.he = json["HE"];
  }
}

/// This is the `AP` class
class AP {
  int burnProbability;
  int bulletSpeed;
  String name;
  int damage;
  int bulletMas;
  String type;

  AP(json) {
    // AP has 0 burn probability
    this.burnProbability = json["burn_probability"] ?? 0;
    this.bulletSpeed = json["bullet_speed"];
    this.name = json["name"];
    this.damage = json["damage"];
    this.bulletMas = json["bullet_mass"];
    this.type = json["type"];
  }
}

/// This is the `HE` class
class HE {
  int burnProbability;
  int bulletSpeed;
  String name;
  int damage;
  int bulletMas;
  String type;

  HE(json) {
    this.burnProbability = json["burn_probability"];
    this.bulletSpeed = json["bullet_speed"];
    this.name = json["name"];
    this.damage = json["damage"];
    this.bulletMas = json["bullet_mass"];
    this.type = json["type"];
  }
}

/// This is the `Slot` class shared by both `Artillery` and `Torpedoe` classes
class Slot {
  int barrel;
  int caliber;
  String name;
  int gun;

  Slot(json) {
    this.barrel = json["barrels"];
    this.caliber = json["caliber"];
    this.name = json["name"];
    this.gun = json["guns"];
  }

  // TODO: get calibar here
}

/// This is the `Torpedoe` class
class Torpedoe {
  double visibilityDist;
  int distance;
  int torpedoesId;
  String torpedoName;
  int reloadTime;
  int torpedoSpeed;
  double rotationTime;
  String torpedoesIdStr;
  Slot slot;
  int maxDamage;

  Torpedoe(json) {
    this.visibilityDist = json["visibility_dist"];
    this.distance = json["distance"];
    this.torpedoesId = json["torpedoes_id"];
    this.torpedoName = json["torpedo_name"];
    this.reloadTime = json["reload_time"];
    this.torpedoSpeed = json["torpedo_speed"];
    this.rotationTime = json["rotation_time"];
    this.torpedoesIdStr = json["torpedoes_id_str"];
    this.slot = json["slots"];
    this.maxDamage = json["max_damage"];
  }
}

/// This is the `FireControl` class
class FireControl {
  int fireControlId;
  double distance;
  int distanceIncrease;
  String fireControlIdStr;

  FireControl(json) {
    this.fireControlId = json["fire_control_id"];
    this.distance = json["distance"];
    this.distanceIncrease = json["distance_increase"];
    this.fireControlIdStr = json["fire_control_id_str"];
  }
}

/// This is the `Weaponry` class
class Weaponry {
  int antiAircraft;
  int aircraft;
  int artillery;
  int torpedoe;

  Weaponry(json) {
    this.antiAircraft = json["anti_aircraft"];
    this.aircraft = json["aircraft"];
    this.artillery = json["artillery"];
    this.torpedoe = json["torpedoes"];
  }
}

/// This is the `Concealment` class
class Concealment {
  int total;
  int detectDistanceByPlane;
  int detectDistanceByShip;

  Concealment(json) {
    this.total = json["total"];
    this.detectDistanceByPlane = json["detect_distance_by_plane"];
    this.detectDistanceByShip = json["detect_distance_by_ship"];
  }
}

/// This is the `Armour` class
class Armour {
  Casemate casemate;
  int floodProb;
  Deck deck;
  int floodDamage;
  Range range;
  int health;
  Extremitie extremitie;
  int total;
  Citadel citadel;

  Armour(json) {
    this.casemate = json["casemate"];
    this.floodProb = json["flood_prob"];
    this.deck = json["deck"];
    this.floodDamage = json["flood_damage"];
    this.range = json["range"];
    this.health = json["health"];
    this.extremitie = json["extremities"];
    this.total = json["total"];
    this.citadel = json["citadel"];
  }
}

/// This is the `Casemate` class
class Casemate {
  int max;
  int min;

  Casemate(json) {
    this.max = json["max"];
    this.min = json["min"];
  }
}

/// This is the `Deck` class
class Deck {
  int max;
  int min;

  Deck(json) {
    this.max = json["max"];
    this.min = json["min"];
  }
}

/// This is the `Extremitie` class
class Extremitie {
  int max;
  int min;

  Extremitie(json) {
    this.max = json["max"];
    this.min = json["min"];
  }
}

/// This is the `Citadel` class
class Citadel {
  int max;
  int min;

  Citadel(json) {
    this.max = json["max"];
    this.min = json["min"];
  }
}

/// This is the `NextShip` class
class NextShip {
  int k4182652624;

  NextShip(json) {
    this.k4182652624 = json["4182652624"];
  }
}
