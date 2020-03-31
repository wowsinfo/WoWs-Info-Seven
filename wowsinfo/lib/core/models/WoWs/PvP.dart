/// This is the `PvP` class
class PvP {
  int maxXp;
  int damageToBuilding;
  MainBattery mainBattery;
  int suppressionsCount;
  int maxDamageScouting;
  int artAgro;
  int shipsSpotted;
  SecondBattery secondBattery;
  int xp;
  int survivedBattle;
  int droppedCapturePoint;
  int maxDamageDealtToBuilding;
  int torpedoAgro;
  int draw;
  int battlesSince510;
  int planesKilled;
  int battle;
  int maxShipsSpotted;
  int teamCapturePoint;
  int frag;
  int damageScouting;
  int maxTotalAgro;
  int maxFragsBattle;
  int capturePoint;
  Ramming ramming;
  Torpedoe torpedoe;
  Aircraft aircraft;
  int survivedWin;
  int maxDamageDealt;
  int win;
  int losse;
  int damageDealt;
  int maxPlanesKilled;
  int maxSuppressionsCount;
  int teamDroppedCapturePoint;
  int battlesSince512;

  PvP(json) {
    this.maxXp = json["max_xp"];
    this.damageToBuilding = json["damage_to_buildings"];
    this.mainBattery = json["main_battery"];
    this.suppressionsCount = json["suppressions_count"];
    this.maxDamageScouting = json["max_damage_scouting"];
    this.artAgro = json["art_agro"];
    this.shipsSpotted = json["ships_spotted"];
    this.secondBattery = json["second_battery"];
    this.xp = json["xp"];
    this.survivedBattle = json["survived_battles"];
    this.droppedCapturePoint = json["dropped_capture_points"];
    this.maxDamageDealtToBuilding = json["max_damage_dealt_to_buildings"];
    this.torpedoAgro = json["torpedo_agro"];
    this.draw = json["draws"];
    this.battlesSince510 = json["battles_since_510"];
    this.planesKilled = json["planes_killed"];
    this.battle = json["battles"];
    this.maxShipsSpotted = json["max_ships_spotted"];
    this.teamCapturePoint = json["team_capture_points"];
    this.frag = json["frags"];
    this.damageScouting = json["damage_scouting"];
    this.maxTotalAgro = json["max_total_agro"];
    this.maxFragsBattle = json["max_frags_battle"];
    this.capturePoint = json["capture_points"];
    this.ramming = json["ramming"];
    this.torpedoe = json["torpedoes"];
    this.aircraft = json["aircraft"];
    this.survivedWin = json["survived_wins"];
    this.maxDamageDealt = json["max_damage_dealt"];
    this.win = json["wins"];
    this.losse = json["losses"];
    this.damageDealt = json["damage_dealt"];
    this.maxPlanesKilled = json["max_planes_killed"];
    this.maxSuppressionsCount = json["max_suppressions_count"];
    this.teamDroppedCapturePoint = json["team_dropped_capture_points"];
    this.battlesSince512 = json["battles_since_512"];
  }
}

/// This is the `MainBattery` class
class MainBattery {
  int maxFragsBattle;
  int frag;
  int hit;
  int shot;

  MainBattery(json) {
    this.maxFragsBattle = json["max_frags_battle"];
    this.frag = json["frags"];
    this.hit = json["hits"];
    this.shot = json["shots"];
  }
}

/// This is the `SecondBattery` class
class SecondBattery {
  int maxFragsBattle;
  int frag;
  int hit;
  int shot;

  SecondBattery(json) {
    this.maxFragsBattle = json["max_frags_battle"];
    this.frag = json["frags"];
    this.hit = json["hits"];
    this.shot = json["shots"];
  }
}

/// This is the `Ramming` class
class Ramming {
  int maxFragsBattle;
  int frag;

  Ramming(json) {
    this.maxFragsBattle = json["max_frags_battle"];
    this.frag = json["frags"];
  }
}

/// This is the `Torpedoe` class
class Torpedoe {
  int maxFragsBattle;
  int frag;
  int hit;
  int shot;

  Torpedoe(json) {
    this.maxFragsBattle = json["max_frags_battle"];
    this.frag = json["frags"];
    this.hit = json["hits"];
    this.shot = json["shots"];
  }
}

/// This is the `Aircraft` class
class Aircraft {
  int maxFragsBattle;
  int frag;

  Aircraft(json) {
    this.maxFragsBattle = json["max_frags_battle"];
    this.frag = json["frags"];
  }
}
