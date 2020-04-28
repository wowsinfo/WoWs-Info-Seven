import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/core/extensions/NumberExtension.dart';

/// This is the `WikiShipModule` class
class WikiShipModule {
  Engine engine;
  TorpedoBomber torpedoBomber;
  AntiAircraft antiAircraft;
  Mobility mobility;
  Hull hull;
  Atba atba;
  Artillery artillery;
  Torpedoe torpedo;
  Fighter fighter;
  FireControl fireControl;
  Weaponry weaponry;
  int battleLevelRangeMax;
  int battleLevelRangeMin;
  FlightControl flightControl;
  Concealment concealment;
  Armour armour;
  DiveBomber diveBomber;

  // Make sure the second value is DOUBLE
  List<List<Object>> getParameter(BuildContext context) {
    final lang = AppLocalization.of(context);
    final cached = CachedData.shared;
    return [
      [lang.localised('warship_info_survivability'), armour?.total?.toDouble()],
      [cached.shipModule.artillery, weaponry?.artillery?.toDouble()],
      [cached.shipModule.torpedo, weaponry?.torpedo?.toDouble()],
      [lang.localised('warship_info_antiaircraft'), weaponry?.antiAircraft?.toDouble()],
      [lang.localised('warship_info_maneuverabilty'), mobility?.total?.toDouble()],
      [lang.localised('warship_info_aircraft'), weaponry?.aircraft?.toDouble()],
      [lang.localised('warship_info_concealment'), concealment?.total?.toDouble()],
    ];
  }

  WikiShipModule(Map<String, dynamic> json) {
    if (json['engine'] != null) this.engine = Engine(json['engine']);
    if (json['torpedo_bomber'] != null) this.torpedoBomber = TorpedoBomber(json['torpedo_bomber']);
    if (json['anti_aircraft'] != null) this.antiAircraft = AntiAircraft(json['anti_aircraft']);
    if (json['mobility'] != null) this.mobility = Mobility(json['mobility']);
    if (json['hull'] != null) this.hull = Hull(json['hull']);
    if (json['atbas'] != null) this.atba = Atba(json['atbas']);
    if (json['artillery'] != null) this.artillery = Artillery(json['artillery']);
    if (json['torpedoes'] != null) this.torpedo = Torpedoe(json['torpedoes']);
    if (json['fighters'] != null) this.fighter = Fighter(json['fighters']);
    if (json['fire_control'] != null) this.fireControl = FireControl(json['fire_control']);
    if (json['weaponry'] != null) this.weaponry = Weaponry(json['weaponry']);
    this.battleLevelRangeMax = json['battle_level_range_max'];
    this.battleLevelRangeMin = json['battle_level_range_min'];
    if (json['flight_control'] != null) this.flightControl = FlightControl(json['flight_control']);
    if (json['concealment'] != null) this.concealment = Concealment(json['concealment']);
    if (json['armour'] != null) this.armour = Armour(json['armour']);
    if (json['dive_bomber'] != null) this.diveBomber = DiveBomber(json['dive_bomber']);
  }
}

/// This is the `Engine` class
class Engine {
  String engineIdStr;
  double maxSpeed;
  int engineId;

  Engine(Map<String, dynamic> json) {
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

  String get nameWithLevel => '$levelString $name';
  String get damageString => '$torpedoDamage';
  String get torpSpeed => '$torpedoMaxSpeed kt';
  String get planeSpeed => '$cruiseSpeed kt';
  String get squadronSize => '${countInSquadron.max} x';
  String get torpRange => '${torpedoDistance.myFixedString(1)} km';
  String get levelString => 'Lv$planeLevel';
  String get healthString => '$maxHealth';

  TorpedoBomber(Map<String, dynamic> json) {
    this.torpedoDistance = json['torpedo_distance'];
    this.planeLevel = json['plane_level'];
    this.squadron = json['squadrons'];
    this.name = json['name'];
    this.cruiseSpeed = json['cruise_speed'];
    this.prepareTime = json['prepare_time'];
    this.torpedoDamage = json['torpedo_damage'];
    if (json['count_in_squadron'] != null) this.countInSquadron = CountInSquadron(json['count_in_squadron']);
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

  Iterable<AASlot> get slots => slot.values;

  AntiAircraft(Map<String, dynamic> json) {
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

  String get configuration => '$guns x';
  String get damageString => '$avgDamage';
  String get rangeString => '${distance.myFixedString(1)} km';

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

  String get fireChance => '${burnProbability ?? 0} %';
  String get damageString => '$damage';
  String get speedString => '$bulletMass m/s';
  String get reloadTime => '${(60 / gunRate).myFixedString(1)} s';
  String get nameWithShellType => '$type - $name';

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

  String get gunBarrel => '$guns x $barrels';

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
  int turningRadius;
  double maxSpeed;

  String get rudderString => '${rudderTime.myFixedString(1)} s';
  String get speedString => '${maxSpeed.myFixedString(1)} kt';
  String get radiusString => '$turningRadius m';

  Mobility(Map<String, dynamic> json) {
    this.rudderTime = json['rudder_time'];
    this.total = json['total'];
    this.turningRadius = json['turning_radius'];
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
    this.hullId = json['hull_id'];
    this.hullIdStr = json['hull_id_str'];
    this.torpedoesBarrel = json['torpedoes_barrels'];
    this.antiAircraftBarrel = json['anti_aircraft_barrels'];
    if (json['range'] != null) this.range = Range(json['range']);
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

  String get armourString => '$min - $max mm';

  Range(Map<String, dynamic> json) {
    this.max = json['max'];
    this.min = json['min'];
  }
}

/// This is the `Atba` class
class Atba {
  double distance;
  Map<String, SecondarySlot> slot;

  String get rangeString => '${distance.myFixedString(1)} km';
  Iterable<SecondarySlot> get slots => slot.values;

  Atba(Map<String, dynamic> json) {
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

  String get dispersionString => '$maxDispersion m';
  String get rotationString => '$rotationTime s';
  String get rangeString => '${distance.myFixedString(1)} km';
  double get reloadTime => 60 / gunRate;
  /// This is how many guns does she have, 2x3 1x2
  String get configurationString => slot.values.map((e) => '${e.barrels} x ${e.guns}').join(' | ');
  /// HE, AP, CS -> reverse it to put HE first
  Iterable<Shell> get shellReversed => shell.values.toList(growable: false).reversed;
  Iterable<Shell> get shells => shellReversed;

  Artillery(Map<String, dynamic> json) {
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
  
  double get fireChance => burnProbability ?? 0;
  String get massString => '$bulletMass kg';
  String get damageString => '$damage (${(damage / 3).myFixedString(0)})';
  String get speed => '$bulletSpeed m/s';
  String get shellNameWithType => '$type - $name';

  Shell(Map<String, dynamic> json) {
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

  String get damageString => '$maxDamage';
  String get torpSpeed => '$torpedoSpeed kt';
  String get detection => '${visibilityDist.myFixedString(1)} km';
  String get range => '$distance km';
  String get reloadString => '$reloadTime s';
  String get configuration => slot.values.map((e) => e.gunBarrel).join(' | ');

  Torpedoe(Map<String, dynamic> json) {
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
    this.fightersId = json['fighters_id'];
    this.squadron = json['squadrons'];
    this.name = json['name'];
    this.cruiseSpeed = json['cruise_speed'];
    this.prepareTime = json['prepare_time'];
    this.gunnerDamage = json['gunner_damage'];
    this.fightersIdStr = json['fighters_id_str'];
    if (json['count_in_squadron'] != null) this.countInSquadron = CountInSquadron(json['count_in_squadron']);
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
  int torpedo;

  Weaponry(Map<String, dynamic> json) {
    this.antiAircraft = json['anti_aircraft'];
    this.aircraft = json['aircraft'];
    this.artillery = json['artillery'];
    this.torpedo = json['torpedoes'];
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

  String get planeDetection => '${detectDistanceByPlane.myFixedString(1)} km';
  String get shipDetection => '${detectDistanceByShip.myFixedString(1)} km';

  Concealment(Map<String, dynamic> json) {
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

  /// Reduce torpedo damage by ??%
  String get protectionString => '$floodDamage%';
  String get armourString => range?.armourString;

  Armour(Map<String, dynamic> json) {
    this.casemate = Casemate(json['casemate']);
    this.floodProb = json['flood_prob'];
    if (json['deck'] != null) this.deck = Deck(json['deck']);
    this.floodDamage = json['flood_damage'];
    if (json['range'] != null) this.range = Range(json['range']);
    this.health = json['health'];
    if (json['extremities'] != null) this.extremitie = Extremitie(json['extremities']);
    this.total = json['total'];
    if (json['citadel'] != null) this.citadel = Citadel(json['citadel']);
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

  String get levelString => 'Lv$planeLevel';
  String get nameWithLevel => '$levelString $name';
  String get fireChance => '${bombBurnProbability.myFixedString(0)}%';
  String get damageString => '$maxDamage';
  String get healthString => '$maxHealth';
  String get planeSpeed => '$cruiseSpeed kt';
  String get squadronSize => '${countInSquadron.max} x';

  DiveBomber(Map<String, dynamic> json) {
    this.squadron = json['squadrons'];
    this.name = json['name'];
    this.cruiseSpeed = json['cruise_speed'];
    this.diveBomberId = json['dive_bomber_id'];
    this.prepareTime = json['prepare_time'];
    this.gunnerDamage = json['gunner_damage'];
    this.bombDamage = json['bomb_damage'];
    if (json['count_in_squadron'] != null) this.countInSquadron = CountInSquadron(json['count_in_squadron']);
    this.bombName = json['bomb_name'];
    this.bombBulletMas = json['bomb_bullet_mass'];
    this.planeLevel = json['plane_level'];
    this.bombBurnProbability = json['bomb_burn_probability'];
    this.maxDamage = json['max_damage'];
    this.maxHealth = json['max_health'];
    this.diveBomberIdStr = json['dive_bomber_id_str'];
    if (json['accuracy'] != null) this.accuracy = Accuracy(json['accuracy']);
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
