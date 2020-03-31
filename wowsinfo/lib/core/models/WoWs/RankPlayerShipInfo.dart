import '../Meta.dart';
import 'PvP.dart';

/// This is the `RankPlayerShipInfo` class
class RankPlayerShipInfo {
  Meta meta;
  Data data;

  RankPlayerShipInfo(json) {
    this.meta = Meta(json["meta"]);
    this.data = Data(json["data"]);
  }
}

/// This is the `Data` class
class Data {
  List<SeasonShipInfo> k2011774448;

  Data(json) {
    this.k2011774448 = json["2011774448"];
  }
}

/// This is the `SeasonShipInfo` class
class SeasonShipInfo {
  // If you used the same ship in two seasons, more entries will be shown. 
  // Therefore, this should be a map
  Map<String, Season> season;
  int accountId;
  int shipId;

  SeasonShipInfo(json) {
    this.season = json["seasons"];
    this.accountId = json["account_id"];
    this.shipId = json["ship_id"];
  }
}

/// This is the `Season` class
class Season {
  RankSolo rankSolo;

  Season(json) {
    this.rankSolo = RankSolo(json["rank_solo"]);
  }
}

/// This is the `RankSolo` class
class RankSolo {
  int maxFragsBattle;
  int draw;
  int maxXp;
  int win;
  int planesKilled;
  int losse;
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

  RankSolo(json) {
    this.maxFragsBattle = json["max_frags_battle"];
    this.draw = json["draws"];
    this.maxXp = json["max_xp"];
    this.win = json["wins"];
    this.planesKilled = json["planes_killed"];
    this.losse = json["losses"];
    this.torpedoe = json["torpedoes"];
    this.battle = json["battles"];
    this.maxDamageDealt = json["max_damage_dealt"];
    this.damageDealt = json["damage_dealt"];
    this.maxPlanesKilled = json["max_planes_killed"];
    this.aircraft = json["aircraft"];
    this.ramming = json["ramming"];
    this.mainBattery = json["main_battery"];
    this.secondBattery = json["second_battery"];
    this.survivedWin = json["survived_wins"];
    this.frag = json["frags"];
    this.xp = json["xp"];
    this.survivedBattle = json["survived_battles"];
  }
}
