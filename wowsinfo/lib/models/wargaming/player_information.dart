import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/wargaming/statistics.dart';
import 'package:wowsinfo/models/wowsinfo/timestamp.dart';

/// The information about a player including statistics.
@immutable
class PlayerInformation {
  const PlayerInformation({
    this.lastBattleTime,
    this.accountId,
    this.levelingTier,
    this.createdAt,
    this.levelingPoints,
    this.updatedAt,
    this.hiddenProfile,
    this.logoutAt,
    this.statistics,
    this.nickname,
    this.statsUpdatedAt,
  });

  final int? lastBattleTime;
  final int? accountId;
  final int? levelingTier;
  final TimeStampDate? createdAt;
  final int? levelingPoints;
  final int? updatedAt;
  final bool? hiddenProfile;
  final int? logoutAt;
  final PlayerStatistics? statistics;
  final String? nickname;
  final int? statsUpdatedAt;

  factory PlayerInformation.fromJson(Map<String, dynamic> json) {
    final player = json.values.first;
    if (player is Map<String, dynamic>) {
      return PlayerInformation(
        lastBattleTime: player['last_battle_time'],
        accountId: player['account_id'],
        levelingTier: player['leveling_tier'],
        createdAt: player['created_at'] == null
            ? null
            : TimeStampDate(player['created_at']),
        levelingPoints: player['leveling_points'],
        updatedAt: player['updated_at'],
        hiddenProfile: player['hidden_profile'],
        logoutAt: player['logout_at'],
        statistics: player['statistics'] == null
            ? null
            : PlayerStatistics.fromJson(player['statistics']),
        nickname: player['nickname'],
        statsUpdatedAt: player['stats_updated_at'],
      );
    }

    assert(false, 'json does not contain player information');
    return const PlayerInformation();
  }
}

/// All modes' statistics of a player.
@immutable
class PlayerStatistics {
  const PlayerStatistics({
    this.battles,
    this.distance,
    this.pvp,
    this.pve,
    this.rankSolo,
    this.pvpDiv2,
    this.pvpDiv3,
  });

  /// The total distance travelled by the player.
  final int? battles;
  final int? distance;
  final PvP? pvp;
  final PvE? pve;
  final Rank? rankSolo;
  final PvPDiv2? pvpDiv2;
  final PvPDiv3? pvpDiv3;

  factory PlayerStatistics.fromJson(Map<String, dynamic> json) =>
      PlayerStatistics(
        distance: json['distance'],
        pvp: json['pvp'] == null ? null : PvP.fromJson(json['pvp']),
        battles: json['battles'],
        pve: json['pve'] == null ? null : PvE.fromJson(json['pve']),
        rankSolo:
            json['rank_solo'] == null ? null : Rank.fromJson(json['rank_solo']),
        pvpDiv2: json['pvp_div2'] == null
            ? null
            : PvPDiv2.fromJson(json['pvp_div2']),
        pvpDiv3: json['pvp_div3'] == null
            ? null
            : PvPDiv3.fromJson(json['pvp_div3']),
      );
}
