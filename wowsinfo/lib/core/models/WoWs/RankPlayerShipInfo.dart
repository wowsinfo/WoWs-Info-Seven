import 'package:wowsinfo/core/models/JsonModel.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/extensions/NumberExtension.dart';
import 'package:wowsinfo/core/providers/CachedData.dart';

import 'PvP.dart';

/// This is the `RankPlayerShipInfo` class
class RankPlayerShipInfo {
  List<SeasonShipInfo> ships = [];
  List<Season> getShipsFor({String season}) {
    return ships.where((e) => e.season[season] != null)
      .map((e) => e.season[season])
      .toList(growable: false);
  }

  RankPlayerShipInfo(Map<String, dynamic> data, CachedData cached) {
    final json = data.values.first;
    if (json != null) {
      json.forEach((item) => ships.add(SeasonShipInfo(item, cached)));
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
  RankPvP getPvP(String key) => season[key].rankSolo;

  SeasonShipInfo(json, CachedData cached) {
    this.shipId = json['ship_id'];
    this.season = (json['seasons'] as Map).map((a, b) => MapEntry(a, Season(b, cached)..shipId = shipId));
    this.accountId = json['account_id'];
  }
}

/// This is the `Season` class
class Season {
  PvP rankSolo;
  dynamic rankDiv2;
  dynamic rankDiv3;
  int shipId;
  ShipInfo shipInfo;

  Season(json, CachedData cached) {
    if (json['rank_solo'] != null) this.rankSolo = PvP(json['rank_solo']);
    this.rankDiv2 = json['rank_div2'];
    this.rankDiv3 = json['rank_div3'];
    this.shipInfo = ShipInfo(json, cached);
  }

  bool get played => rankSolo != null;
}

/// This is the `RankPvP` class
class RankPvP extends JsonModel {
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
  Torpedoe torpedo;
  Aircraft aircraft;
  Ramming ramming;
  MainBattery mainBattery;
  SecondBattery secondBattery;
  
  int survivedWin;
  int frag;
  int xp;
  int survivedBattle;

  bool get hasBattle => battle > 0;

  int get deadBattle => battle - survivedBattle;

  double get winrate => (win * 10000 / battle) / 100.0;
  double get survivedWinrate => (survivedWin * 10000 / battle) / 100.0;
  double get survivedRate => (survivedBattle * 10000 / battle) / 100.0;
  double get killDeath => frag / deadBattle;

  double get avgExp => xp / battle;
  double get avgDamage => damageDealt / battle;
  double get avgFrag => frag / battle;
  double get avgPlaneDestroyed => planesKilled / battle;

  String get battleString => '$battle';
  String get winrateString => '${winrate.myFixedString(1)}%';
  String get avgDamageString => '${avgDamage.myFixedString(0)}';
  String get avgExpString => '${avgExp.myFixedString(0)}';
  String get killDeathString => '${killDeath.myFixedString(2)}';
  String get mainHitRatioString => '${mainBattery.hitRatio.myFixedString(2)}%';
  bool get canHit => mainBattery.shot > 0;

  String get maxDamage => '$maxDamageDealt';
  String get maxExp => '$maxXp';
  String get maxFrag => '$maxFragsBattle';
  String get maxPlane => '$maxPlanesKilled';

  RankPvP(Map<String, dynamic> json) : super(json) {
    this.maxFragsBattle = json['max_frags_battle'];
    this.draw = json['draws'];
    this.maxXp = json['max_xp'];
    this.win = json['wins'];
    this.planesKilled = json['planes_killed'];
    this.loss = json['losss'];
    if (json['torpedoes'] != null) this.torpedo = Torpedoe(json['torpedoes']);
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
