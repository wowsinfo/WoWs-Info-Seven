import 'package:wowsinfo/core/models/UI/WoWsDate.dart';

import 'PvP.dart';

/// This is the `BasicPlayerInfo` class
class BasicPlayerInfo {
  WoWsDate lastBattleTime;
  int accountId;
  int levelingTier;
  WoWsDate createdAt;
  int levelingPoint;
  int updatedAt;
  bool hiddenProfile;
  int logoutAt;
  Statistic statistic;
  String nickname;
  int statsUpdatedAt;

  bool get publicProfile => !(hiddenProfile ?? true);
  String get level => 'Lv $levelingTier';
  String get createdDate => createdAt.dateString;
  String get lastBattleDate => lastBattleTime?.dateString;
  String get distanceString => statistic?.distanceString ?? '0 km';
  String get totalBattleString => statistic?.totalBattleString ?? '0';


  BasicPlayerInfo(Map<String, dynamic> data) {
    // There should be only one key inside
    final json = data.values.first;
    if (json != null) {
      this.lastBattleTime = WoWsDate(json['last_battle_time']);
      this.accountId = json['account_id'];
      this.createdAt = WoWsDate(json['created_at']);
      // These are null if account is hidden so a default value is provided
      this.levelingTier = json['leveling_tier'] ?? 0;
      this.levelingPoint = json['leveling_points'] ?? 0;
      this.updatedAt = json['updated_at'];
      this.hiddenProfile = json['hidden_profile'];
      this.logoutAt = json['logout_at'];
      this.nickname = json['nickname'];
      this.statsUpdatedAt = json['stats_updated_at'];
      // statistic is only available if the account is public
      if (json['statistics'] != null) this.statistic = Statistic(json['statistics']);
    }
  }
}

/// This is the `Statistic` class
class Statistic {
  int distance;
  int battle;
  PvP pvp;
  PvP div2;
  PvP div3;
  PvP solo;
  PvP pve;
  PvP rank;

  String get distanceString => '$distance km';
  String get totalBattleString => '$battle';

  Statistic(Map<String, dynamic> json) {
    this.distance = json['distance'];
    this.battle = json['battles'];
    if (json['pvp'] != null) this.pvp = PvP(json['pvp']);
    if (json['pvp_solo'] != null) this.solo = PvP(json['pvp_solo']);
    if (json['pvp_div2'] != null) this.div2 = PvP(json['pvp_div2']);
    if (json['pvp_div3'] != null) this.div3 = PvP(json['pvp_div3']);
    if (json['pve'] != null) this.pve = PvP(json['pve']);
    if (json['rank_solo'] != null) this.rank = PvP(json['rank_solo']);
  }
}
