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
  DefaultProfile defaultProfile;
  List<int> upgrade;
  int tier;
  NextShip nextShip;
  int modSlot;
  String type;
  bool isSpecial;
  String name;

  WikiShipInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    this.description = json['description'];
    this.priceGold = json['price_gold'];
    this.shipIdStr = json['ship_id_str'];
    this.hasDemoProfile = json['has_demo_profile'];
    this.image = Image(json['images']);
    this.module = Module(json['modules']);
    this.modulesTree = ModulesTree(json['modules_tree']);
    this.nation = json['nation'];
    this.isPremium = json['is_premium'];
    this.shipId = json['ship_id'];
    this.priceCredit = json['price_credit'];
    this.defaultProfile = DefaultProfile(json['default_profile']);
    this.upgrade = (json['upgrades'] ?? []).cast<int>();
    this.tier = json['tier'];
    this.nextShip = NextShip(json['next_ships']);
    this.modSlot = json['mod_slots'];
    this.type = json['type'];
    this.isSpecial = json['is_special'];
    this.name = json['name'];
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

/// This is the `DefaultProfile` class
class DefaultProfile {
  Engine engine;
  TorpedoBomber torpedoBomber;
  AntiAircraft antiAircraft;
  Mobility mobility;
  Hull hull;
  Atba atba;
  Artillery artillery;
  Torpedoe torpedoe;
  Fighter fighter;
  FireControl fireControl;
  Weaponry weaponry;
  int battleLevelRangeMax;
  int battleLevelRangeMin;
  FlightControl flightControl;
  Concealment concealment;
  Armour armour;
  DiveBomber diveBomber;

  DefaultProfile(Map<String, dynamic> json) {
    this.engine = Engine(json['engine']);
    this.torpedoBomber = TorpedoBomber(json['torpedo_bomber']);
    this.antiAircraft = AntiAircraft(json['anti_aircraft']);
    this.mobility = Mobility(json['mobility']);
    this.hull = Hull(json['hull']);
    this.atba = Atba(json['atbas']);
    this.artillery = Artillery(json['artillery']);
    this.torpedoe = Torpedoe(json['torpedoes']);
    this.fighter = Fighter(json['fighters']);
    this.fireControl = FireControl(json['fire_control']);
    this.weaponry = Weaponry(json['weaponry']);
    this.battleLevelRangeMax = json['battle_level_range_max'];
    this.battleLevelRangeMin = json['battle_level_range_min'];
    this.flightControl = FlightControl(json['flight_control']);
    this.concealment = Concealment(json['concealment']);
    this.armour = Armour(json['armour']);
    this.diveBomber = DiveBomber(json['dive_bomber']);
  }
}

/// This is the `Engine` class
class Engine {
  String engineIdStr;
  double maxSpeed;
  int engineId;

  Engine(Map<String, dynamic> json) {
    if (json == null) return;
    this.engineIdStr = json['engine_id_str'];
    this.maxSpeed = json['max_speed'];
    this.engineId = json['engine_id'];
  }
}

/// This is the `TorpedoBomber` class
class TorpedoBomber {
  double torpedoDistance;
  int planeLevel;
  int squadron;
  String name;
  int cruiseSpeed;
  int prepareTime;
  int torpedoDamage;
  CountInSquadron countInSquadron;
  int torpedoMaxSpeed;
  String torpedoBomberIdStr;
  int gunnerDamage;
  int maxDamage;
  int maxHealth;
  int torpedoBomberId;
  String torpedoName;

  TorpedoBomber(Map<String, dynamic> json) {
    if (json == null) return;
    this.torpedoDistance = json['torpedo_distance'];
    this.planeLevel = json['plane_level'];
    this.squadron = json['squadrons'];
    this.name = json['name'];
    this.cruiseSpeed = json['cruise_speed'];
    this.prepareTime = json['prepare_time'];
    this.torpedoDamage = json['torpedo_damage'];
    this.countInSquadron = CountInSquadron(json['count_in_squadron']);
    this.torpedoMaxSpeed = json['torpedo_max_speed'];
    this.torpedoBomberIdStr = json['torpedo_bomber_id_str'];
    this.gunnerDamage = json['gunner_damage'];
    this.maxDamage = json['max_damage'];
    this.maxHealth = json['max_health'];
    this.torpedoBomberId = json['torpedo_bomber_id'];
    this.torpedoName = json['torpedo_name'];
  }
}

/// This is the `CountInSquadron` class
class CountInSquadron {
  int max;
  int min;

  CountInSquadron(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `AntiAircraft` class
class AntiAircraft {
  Map<String, AASlot> slot;
  int defense;

  AntiAircraft(Map<String, dynamic> json) {
    if (json == null) return;
    this.slot = (json['slots'] as Map).map((key, value) => MapEntry(key, AASlot(value)));
    this.defense = json['defense'];
  }
}

/// This is the `AASlot` class
class AASlot {
  double distance;
  int avgDamage;
  int caliber;
  String name;
  int guns;

  AASlot(Map<String, dynamic> json) {
    this.distance = json['distance'];
    this.avgDamage = json['avg_damage'];
    this.caliber = json['caliber'];
    this.name = json['name'];
    this.guns = json['guns'];
  }
}

/// This is the `MainGunSlot` class
class MainGunSlot {
  int barrels;
  String name;
  int guns;

  MainGunSlot(Map<String, dynamic> json) {
    this.barrels = json['barrels'];
    this.name = json['name'];
    this.guns = json['guns'];
  }
}

/// This is the `SecondarySlot` class
class SecondarySlot {
  double burnProbability;
  int bulletSpeed;
  String name;
  double shotDelay;
  int damage;
  int bulletMass;
  String type;
  double gunRate;

  SecondarySlot(Map<String, dynamic> json) {
    this.name = json['name'];
    this.burnProbability = json['burn_probability'];
    this.bulletSpeed = json['bullet_speed'];
    this.shotDelay = json['shot_delay'];
    this.damage = json['damage'];
    this.bulletMass = json['bullet_mass'];
    this.type = json['type'];
    this.gunRate = json['gun_rate'];
  }
}

/// This is the `TorpedoeSlot` class
class TorpedoeSlot {
  int barrels;
  int caliber;
  String name;
  int guns;

  TorpedoeSlot(Map<String, dynamic> json) {
    this.barrels = json['barrels'];
    this.caliber = json['caliber'];
    this.name = json['name'];
    this.guns = json['guns'];
  }
}

/// This is the `Mobility` class
class Mobility {
  double rudderTime;
  int total;
  int turningRadiu;
  double maxSpeed;

  Mobility(Map<String, dynamic> json) {
    if (json == null) return;
    this.rudderTime = json['rudder_time'];
    this.total = json['total'];
    this.turningRadiu = json['turning_radius'];
    this.maxSpeed = json['max_speed'];
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

  Hull(Map<String, dynamic> json) {
    if (json == null) return;
    this.hullId = json['hull_id'];
    this.hullIdStr = json['hull_id_str'];
    this.torpedoesBarrel = json['torpedoes_barrels'];
    this.antiAircraftBarrel = json['anti_aircraft_barrels'];
    this.range = Range(json['range']);
    this.health = json['health'];
    this.planesAmount = json['planes_amount'];
    this.artilleryBarrel = json['artillery_barrels'];
    this.atbaBarrel = json['atba_barrels'];
  }
}

/// This is the `Range` class
class Range {
  int max;
  int min;

  Range(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `Atba` class
class Atba {
  double distance;
  Map<String, SecondarySlot> slot;

  Atba(Map<String, dynamic> json) {
    if (json == null) return;
    this.distance = json['distance'];
    this.slot = (json['slots'] as Map).map((key, value) => MapEntry(key, SecondarySlot(value)));
  }
}

/// This is the `Artillery` class
class Artillery {
  int maxDispersion;
  Map<String, Shell> shell;
  double shotDelay;
  double rotationTime;
  double distance;
  int artilleryId;
  String artilleryIdStr;
  Map<String, MainGunSlot> slot;
  double gunRate;

  Artillery(Map<String, dynamic> json) {
    if (json == null) return;
    this.maxDispersion = json['max_dispersion'];
    this.shell = (json['shells'] as Map).map((key, value) => MapEntry(key, Shell(value)));
    this.shotDelay = json['shot_delay'];
    this.rotationTime = json['rotation_time'];
    this.distance = json['distance'];
    this.artilleryId = json['artillery_id'];
    this.artilleryIdStr = json['artillery_id_str'];
    this.slot = (json['slots'] as Map).map((key, value) => MapEntry(key, MainGunSlot(value)));
    this.gunRate = json['gun_rate'];
  }
}

/// This is the `Shell` class
class Shell {
  double burnProbability;
  int bulletSpeed;
  String name;
  int damage;
  int bulletMass;
  String type;

  Shell(Map<String, dynamic> json) {
    if (json == null) return;
    this.burnProbability = json['burn_probability'];
    this.bulletSpeed = json['bullet_speed'];
    this.name = json['name'];
    this.damage = json['damage'];
    this.bulletMass = json['bullet_mass'];
    this.type = json['type'];
  }
}

/// This is the `Torpedoe` class
class Torpedoe {
  double visibilityDist;
  double distance;
  int torpedoesId;
  String torpedoName;
  int reloadTime;
  int torpedoSpeed;
  double rotationTime;
  String torpedoesIdStr;
  Map<String, TorpedoeSlot> slot;
  int maxDamage;

  Torpedoe(Map<String, dynamic> json) {
    if (json == null) return;
    this.visibilityDist = json['visibility_dist'];
    this.distance = json['distance'];
    this.torpedoesId = json['torpedoes_id'];
    this.torpedoName = json['torpedo_name'];
    this.reloadTime = json['reload_time'];
    this.torpedoSpeed = json['torpedo_speed'];
    this.rotationTime = json['rotation_time'];
    this.torpedoesIdStr = json['torpedoes_id_str'];
    this.slot = (json['slots'] as Map).map((key, value) => MapEntry(key, TorpedoeSlot(value)));
    this.maxDamage = json['max_damage'];
  }
}

/// This is the `Fighter` class
class Fighter {
  int fightersId;
  int squadron;
  String name;
  int cruiseSpeed;
  int prepareTime;
  int gunnerDamage;
  String fightersIdStr;
  CountInSquadron countInSquadron;
  int maxAmmo;
  int planeLevel;
  int avgDamage;
  int maxHealth;

  Fighter(Map<String, dynamic> json) {
    if (json == null) return;
    this.fightersId = json['fighters_id'];
    this.squadron = json['squadrons'];
    this.name = json['name'];
    this.cruiseSpeed = json['cruise_speed'];
    this.prepareTime = json['prepare_time'];
    this.gunnerDamage = json['gunner_damage'];
    this.fightersIdStr = json['fighters_id_str'];
    this.countInSquadron = CountInSquadron(json['count_in_squadron']);
    this.maxAmmo = json['max_ammo'];
    this.planeLevel = json['plane_level'];
    this.avgDamage = json['avg_damage'];
    this.maxHealth = json['max_health'];
  }
}

/// This is the `FireControl` class
class FireControl {
  int fireControlId;
  double distance;
  int distanceIncrease;
  String fireControlIdStr;

  FireControl(Map<String, dynamic> json) {
    if (json == null) return;
    this.fireControlId = json['fire_control_id'];
    this.distance = json['distance'];
    this.distanceIncrease = json['distance_increase'];
    this.fireControlIdStr = json['fire_control_id_str'];
  }
}

/// This is the `Weaponry` class
class Weaponry {
  int antiAircraft;
  int aircraft;
  int artillery;
  int torpedoe;

  Weaponry(Map<String, dynamic> json) {
    if (json == null) return;
    this.antiAircraft = json['anti_aircraft'];
    this.aircraft = json['aircraft'];
    this.artillery = json['artillery'];
    this.torpedoe = json['torpedoes'];
  }
}

/// This is the `FlightControl` class
class FlightControl {
  String flightControlIdStr;
  int bomberSquadron;
  int torpedoSquadron;
  int flightControlId;
  int fighterSquadron;

  FlightControl(Map<String, dynamic> json) {
    if (json == null) return;
    this.flightControlIdStr = json['flight_control_id_str'];
    this.bomberSquadron = json['bomber_squadrons'];
    this.torpedoSquadron = json['torpedo_squadrons'];
    this.flightControlId = json['flight_control_id'];
    this.fighterSquadron = json['fighter_squadrons'];
  }
}

/// This is the `Concealment` class
class Concealment {
  int total;
  double detectDistanceByPlane;
  double detectDistanceByShip;

  Concealment(Map<String, dynamic> json) {
    if (json == null) return;
    this.total = json['total'];
    this.detectDistanceByPlane = json['detect_distance_by_plane'];
    this.detectDistanceByShip = json['detect_distance_by_ship'];
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

  Armour(Map<String, dynamic> json) {
    if (json == null) return;
    this.casemate = Casemate(json['casemate']);
    this.floodProb = json['flood_prob'];
    this.deck = Deck(json['deck']);
    this.floodDamage = json['flood_damage'];
    this.range = Range(json['range']);
    this.health = json['health'];
    this.extremitie = Extremitie(json['extremities']);
    this.total = json['total'];
    this.citadel = Citadel(json['citadel']);
  }
}

/// This is the `Casemate` class
class Casemate {
  int max;
  int min;

  Casemate(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `Deck` class
class Deck {
  int max;
  int min;

  Deck(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `Extremitie` class
class Extremitie {
  int max;
  int min;

  Extremitie(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `Citadel` class
class Citadel {
  int max;
  int min;

  Citadel(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `DiveBomber` class
class DiveBomber {
  int squadron;
  String name;
  int cruiseSpeed;
  int diveBomberId;
  int prepareTime;
  int gunnerDamage;
  int bombDamage;
  CountInSquadron countInSquadron;
  String bombName;
  int bombBulletMas;
  int planeLevel;
  double bombBurnProbability;
  int maxDamage;
  int maxHealth;
  String diveBomberIdStr;
  Accuracy accuracy;

  DiveBomber(Map<String, dynamic> json) {
    if (json == null) return;
    this.squadron = json['squadrons'];
    this.name = json['name'];
    this.cruiseSpeed = json['cruise_speed'];
    this.diveBomberId = json['dive_bomber_id'];
    this.prepareTime = json['prepare_time'];
    this.gunnerDamage = json['gunner_damage'];
    this.bombDamage = json['bomb_damage'];
    this.countInSquadron = CountInSquadron(json['count_in_squadron']);
    this.bombName = json['bomb_name'];
    this.bombBulletMas = json['bomb_bullet_mass'];
    this.planeLevel = json['plane_level'];
    this.bombBurnProbability = json['bomb_burn_probability'];
    this.maxDamage = json['max_damage'];
    this.maxHealth = json['max_health'];
    this.diveBomberIdStr = json['dive_bomber_id_str'];
    this.accuracy = Accuracy(json['accuracy']);
  }
}

/// This is the `Accuracy` class
class Accuracy {
  double max;
  double min;

  Accuracy(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `NextShip` class
class NextShip {
  Map<String, int> ships;

  NextShip(Map<String, dynamic> json) {
    ships = json.cast<String, int>();
  }
}
