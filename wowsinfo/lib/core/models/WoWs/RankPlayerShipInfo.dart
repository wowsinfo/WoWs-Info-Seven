import 'PvP.dart';

/// This is the `RankPlayerShipInfo` class
class RankPlayerShipInfo {
  List<SeasonShipInfo> ships = [];
  List<SeasonShipInfo> getShipsFor({String season}) {
    return ships.where((e) => e.season[season] != null);
  }

  RankPlayerShipInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null) {
      json.forEach((item) => ships.add(SeasonShipInfo(item)));
    }
  }
}

/// This is the `SeasonShipInfo` class
class SeasonShipInfo {
  // If you used the same ship in two seasons, more entries will be shown. 
  // Therefore, this should be a map
  Map<String, Season> season;
  int accountId;
  int shipId;

  /// Get stats for a certain season
  RankPvP getPvP(String key) => season[key].RankPvP;

  SeasonShipInfo(json) {
    this.season = (json['seasons'] as Map).map((a, b) => MapEntry(a, Season(b)));
    this.accountId = json['account_id'];
    this.shipId = json['ship_id'];
  }
}

/// This is the `Season` class
class Season {
  RankPvP RankPvP;
  dynamic rankDiv2;
  dynamic rankDiv3;

  Season(json) {
    if (json['rank_solo'] != null) this.RankPvP = RankPvP(json['rank_solo']);
    this.rankDiv2 = json['rank_div2'];
    this.rankDiv3 = json['rank_div3'];
  }
}

/// This is the `RankPvP` class
class RankPvP {
  int maxFragsBattle;
  int draw;
  int maxXp;
  int win;
  int planesKilled;
  int loss;
  int battle;
  int maxDamageDealt;
  int damageDealt;
  int maxPlanesKilled;

  // Reuse classes in PvP.dart
  Torpedoe torpedoe;
  Aircraft aircraft;
  Ramming ramming;
  MainBattery mainBattery;
  SecondBattery secondBattery;
  
  int survivedWin;
  int frag;
  int xp;
  int survivedBattle;

  RankPvP(json) {
    this.maxFragsBattle = json['max_frags_battle'];
    this.draw = json['draws'];
    this.maxXp = json['max_xp'];
    this.win = json['wins'];
    this.planesKilled = json['planes_killed'];
    this.loss = json['losss'];
    if (json['torpedoes'] != null) this.torpedoe = Torpedoe(json['torpedoes']);
    this.battle = json['battles'];
    this.maxDamageDealt = json['max_damage_dealt'];
    this.damageDealt = json['damage_dealt'];
    this.maxPlanesKilled = json['max_planes_killed'];
    if (json['aircraft'] != null) this.aircraft = Aircraft(json['aircraft']);
    if (json['ramming'] != null) this.ramming = Ramming(json['ramming']);
    if (json['main_battery'] != null) this.mainBattery = MainBattery(json['main_battery']);
    if (json['second_battery'] != null) this.secondBattery = SecondBattery(json['second_battery']);
    this.survivedWin = json['survived_wins'];
    this.frag = json['frags'];
    this.xp = json['xp'];
    this.survivedBattle = json['survived_battles'];
  }
}
