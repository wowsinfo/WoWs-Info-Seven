import '../Meta.dart';
import 'PvP.dart';

/// This is the `BasicPlayerInfo` class
class BasicPlayerInfo {
  Meta meta;
  Data data;

  BasicPlayerInfo(json) {
    this.meta = Meta(json["meta"]);
    this.data = Data(json["data"]);
  }
}

/// This is the `Data` class, there should only be one player info here
class Data {
  PlayerDetail k2011774448;

  Data(json) {
    this.k2011774448 = json["2011774448"];
  }
}

/// This is the `PlayerDetail` class
class PlayerDetail {
  int lastBattleTime;
  int accountId;
  int levelingTier;
  int createdAt;
  int levelingPoint;
  int updatedAt;
  dynamic private;
  bool hiddenProfile;
  int logoutAt;
  dynamic karma;
  Statistic statistic;
  String nickname;
  int statsUpdatedAt;

  PlayerDetail(json) {
    this.lastBattleTime = json["last_battle_time"];
    this.accountId = json["account_id"];
    this.levelingTier = json["leveling_tier"];
    this.createdAt = json["created_at"];
    this.levelingPoint = json["leveling_points"];
    this.updatedAt = json["updated_at"];
    this.private = json["private"];
    this.hiddenProfile = json["hidden_profile"];
    this.logoutAt = json["logout_at"];
    this.karma = json["karma"];
    this.statistic = json["statistics"];
    this.nickname = json["nickname"];
    this.statsUpdatedAt = json["stats_updated_at"];
  }
}

/// This is the `Statistic` class
class Statistic {
  int distance;
  int battle;
  PvP pvp;

  Statistic(json) {
    this.distance = json["distance"];
    this.battle = json["battles"];
    this.pvp = PvP(json["pvp"]);
  }
}
