import 'PvP.dart';

/// This is the `BasicPlayerInfo` class
class BasicPlayerInfo {
  int lastBattleTime;
  int accountId;
  int levelingTier;
  int createdAt;
  int levelingPoint;
  int updatedAt;
  bool hiddenProfile;
  bool get publicProfile => !hiddenProfile;
  int logoutAt;
  Statistic statistic;
  String nickname;
  int statsUpdatedAt;

  BasicPlayerInfo(Map<String, dynamic> data) {
    // There should be only one key inside
    final json = data.values.first;
    this.lastBattleTime = json['last_battle_time'];
    this.accountId = json['account_id'];
    this.createdAt = json['created_at'];
    // These are null if account is hidden so a default value is provided
    this.levelingTier = json['leveling_tier'] ?? 0;
    this.levelingPoint = json['leveling_points'] ?? 0;
    this.updatedAt = json['updated_at'];
    this.hiddenProfile = json['hidden_profile'];
    this.logoutAt = json['logout_at'];
    this.nickname = json['nickname'];
    this.statsUpdatedAt = json['stats_updated_at'];
    // statistic is only available if the account is public
    if (publicProfile) {
      this.statistic = Statistic(json['statistics']);
    }
  }
}

/// This is the `Statistic` class
class Statistic {
  int distance;
  int battle;
  PvP pvp;

  Statistic(Map<String, dynamic> json) {
    this.distance = json['distance'];
    this.battle = json['battles'];
    this.pvp = PvP(json['pvp']);
  }
}
