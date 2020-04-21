/// This is the `PvP` class
class PvP {
  int maxXp;
  int damageToBuilding;
  MainBattery mainBattery;
  int maxShipsSpottedShipId;
  int maxDamageScouting;
  int artAgro;
  int maxXpShipId;
  int shipsSpotted;
  SecondBattery secondBattery;
  int maxFragsShipId;
  int xp;
  int survivedBattle;
  int droppedCapturePoint;
  int maxDamageDealtToBuilding;
  int torpedoAgro;
  int draw;
  int controlCapturedPoint;
  int battlesSince510;
  int maxTotalAgroShipId;
  int planesKilled;
  int battle;
  int maxShipsSpotted;
  int maxSuppressionsShipId;
  int survivedWin;
  int frag;
  int damageScouting;
  int maxTotalAgro;
  int maxFragsBattle;
  int capturePoint;
  Ramming ramming;
  int suppressionsCount;
  int maxSuppressionsCount;
  Torpedoe torpedoe;
  int maxPlanesKilledShipId;
  Aircraft aircraft;
  int teamCapturePoint;
  int controlDroppedPoint;
  int maxDamageDealt;
  int maxDamageDealtToBuildingsShipId;
  int maxDamageDealtShipId;
  int win;
  int losse;
  int damageDealt;
  int maxPlanesKilled;
  int maxScoutingDamageShipId;
  int teamDroppedCapturePoint;
  int battlesSince512;

  String get battleString => '$battle';
  double get winrate => (win * 10000 / battle) / 100.0;
  String get winrateString => '${winrate.toStringAsFixed(1)}%';
  double get avgDamage => damageDealt / battle;
  String get avgDamageString => '${avgDamage.toStringAsFixed(0)}';
  double get avgExp => xp / battle;
  String get avgExpString => '${avgExp.toStringAsFixed(0)}';
  int get deadBattle => battle - survivedBattle;
  double get killDeath => frag / deadBattle;
  String get killDeathString => '${killDeath.toStringAsFixed(2)}';
  String get mainHitRatioString => '${mainBattery.hitRatio.toStringAsFixed(2)}%';

  String get maxDamage => '$maxDamageDealt';
  String get maxExp => '$maxXp';
  String get maxDamageToBuilding => '$maxDamageDealtToBuilding';
  String get maxSpottingDamage => '$maxDamageScouting';
  String get maxFrag => '$maxFragsBattle';
  String get maxPlane => '$maxPlanesKilled';
  String get maxSpotted => '$maxShipsSpotted';
  String get maxSupression => '$maxSuppressionsCount';
  String get maxPotential => '$maxTotalAgro';

  PvP(Map<String, dynamic> json) {
    if (json['main_battery'] != null) this.mainBattery =  MainBattery(json['main_battery']);
    if (json['second_battery'] != null) this.secondBattery = SecondBattery(json['second_battery']);
    if (json['ramming'] != null) this.ramming = Ramming(json['ramming']);
    if (json['torpedoes'] != null) this.torpedoe = Torpedoe(json['torpedoes']);
    if (json['aircraft'] != null) this.aircraft = Aircraft(json['aircraft']);
    this.maxXp = json["max_xp"];
    this.damageToBuilding = json["damage_to_buildings"];
    this.maxShipsSpottedShipId = json["max_ships_spotted_ship_id"];
    this.maxDamageScouting = json["max_damage_scouting"];
    this.artAgro = json["art_agro"];
    this.maxXpShipId = json["max_xp_ship_id"];
    this.shipsSpotted = json["ships_spotted"];
    this.maxFragsShipId = json["max_frags_ship_id"];
    this.xp = json["xp"];
    this.survivedBattle = json["survived_battles"];
    this.droppedCapturePoint = json["dropped_capture_points"];
    this.maxDamageDealtToBuilding = json["max_damage_dealt_to_buildings"];
    this.torpedoAgro = json["torpedo_agro"];
    this.draw = json["draws"];
    this.controlCapturedPoint = json["control_captured_points"];
    this.battlesSince510 = json["battles_since_510"];
    this.maxTotalAgroShipId = json["max_total_agro_ship_id"];
    this.planesKilled = json["planes_killed"];
    this.battle = json["battles"];
    this.maxShipsSpotted = json["max_ships_spotted"];
    this.maxSuppressionsShipId = json["max_suppressions_ship_id"];
    this.survivedWin = json["survived_wins"];
    this.frag = json["frags"];
    this.damageScouting = json["damage_scouting"];
    this.maxTotalAgro = json["max_total_agro"];
    this.maxFragsBattle = json["max_frags_battle"];
    this.capturePoint = json["capture_points"];
    this.suppressionsCount = json["suppressions_count"];
    this.maxSuppressionsCount = json["max_suppressions_count"];
    this.maxPlanesKilledShipId = json["max_planes_killed_ship_id"];
    this.teamCapturePoint = json["team_capture_points"];
    this.controlDroppedPoint = json["control_dropped_points"];
    this.maxDamageDealt = json["max_damage_dealt"];
    this.maxDamageDealtToBuildingsShipId = json["max_damage_dealt_to_buildings_ship_id"];
    this.maxDamageDealtShipId = json["max_damage_dealt_ship_id"];
    this.win = json["wins"];
    this.losse = json["losses"];
    this.damageDealt = json["damage_dealt"];
    this.maxPlanesKilled = json["max_planes_killed"];
    this.maxScoutingDamageShipId = json["max_scouting_damage_ship_id"];
    this.teamDroppedCapturePoint = json["team_dropped_capture_points"];
    this.battlesSince512 = json["battles_since_512"];
  }
}

/// Ramming can be a weapon I guess
abstract class Weapon {
  int maxFragsBattle;
  int frag;
  int hit;
  int maxFragsShipId;
  int shot;

  /// Hit ratio only applies for some weapon
  bool get hasHitRatio => shot != null;
  double get hitRatio => hasHitRatio ? hit * 10000 / shot / 100.0 : 0;
  String get maxFrag => '$maxFragsBattle';
  String get totalFrag => '$frag';
}

/// This is the `MainBattery` class
class MainBattery extends Weapon {
  MainBattery(Map<String, dynamic> json) {
    this.maxFragsBattle = json['max_frags_battle'];
    this.frag = json['frags'];
    this.hit = json['hits'];
    this.maxFragsShipId = json['max_frags_ship_id'];
    this.shot = json['shots'];
  }
}

/// This is the `SecondBattery` class
class SecondBattery extends Weapon {
  SecondBattery(Map<String, dynamic> json) {
    this.maxFragsBattle = json['max_frags_battle'];
    this.frag = json['frags'];
    this.hit = json['hits'];
    this.maxFragsShipId = json['max_frags_ship_id'];
    this.shot = json['shots'];
  }
}

/// This is the `Ramming` class
class Ramming extends Weapon {
  Ramming(Map<String, dynamic> json) {
    this.maxFragsBattle = json['max_frags_battle'];
    this.frag = json['frags'];
    this.maxFragsShipId = json['max_frags_ship_id'];
  }
}

/// This is the `Torpedoe` class
class Torpedoe extends Weapon {
  Torpedoe(Map<String, dynamic> json) {
    this.maxFragsBattle = json['max_frags_battle'];
    this.frag = json['frags'];
    this.hit = json['hits'];
    this.maxFragsShipId = json['max_frags_ship_id'];
    this.shot = json['shots'];
  }
}

/// This is the `Aircraft` class
class Aircraft extends Weapon  {
  Aircraft(Map<String, dynamic> json) {
    this.maxFragsBattle = json['max_frags_battle'];
    this.frag = json['frags'];
    this.maxFragsShipId = json['max_frags_ship_id'];
  }
}
