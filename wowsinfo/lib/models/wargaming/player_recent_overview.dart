import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/calculation.dart';

// TODO: we can save this data in the repository only for the main account
// With it, we can have better charts and more info about the main player

/// The recent overview of the player.
@immutable
class PlayerRecentOverview {
  const PlayerRecentOverview({
    this.pvp,
  });

  /// The key is the date in the format YYYYMMDD
  final Map<String, PlayerRecentPvP>? pvp;

  factory PlayerRecentOverview.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return const PlayerRecentOverview();

    final player = json.values.first;
    if (player is Map<String, dynamic>) {
      return PlayerRecentOverview(
        pvp: player['pvp'] is Map
            ? (player['pvp'] as Map).map(
                (key, value) => MapEntry(key, PlayerRecentPvP.fromJson(value)))
            : null,
      );
    }

    // Hidden accounts still has the account id but not data in it
    return const PlayerRecentOverview();
  }

  Map<String, dynamic> toJson() => {
        'pvp': pvp == null
            ? null
            : Map.from(pvp!).map((k, v) =>
                MapEntry<String, Map<String, dynamic>>(k, v.toJson())),
      };
}

/// The recent PvP data overview.
@immutable
class PlayerRecentPvP with Calculation {
  const PlayerRecentPvP({
    this.capturePoints,
    this.accountId,
    this.maxXp,
    this.wins,
    this.planesKilled,
    this.battles,
    this.damageDealt,
    this.battleType,
    this.date,
    this.xp,
    this.frags,
    this.survivedBattles,
    this.droppedCapturePoints,
  });

  final int? capturePoints;
  final int? accountId;
  final int? maxXp;
  final int? wins;
  final int? planesKilled;
  final int? battles;
  final int? damageDealt;
  final String? battleType;
  final String? date;
  final int? xp;
  final int? frags;
  final int? survivedBattles;
  final int? droppedCapturePoints;

  double get winrate => rate(wins, battles);
  double get avgDamage => average(damageDealt, battles);

  factory PlayerRecentPvP.fromJson(Map<String, dynamic> json) =>
      PlayerRecentPvP(
        capturePoints: json['capture_points'],
        accountId: json['account_id'],
        maxXp: json['max_xp'],
        wins: json['wins'],
        planesKilled: json['planes_killed'],
        battles: json['battles'],
        damageDealt: json['damage_dealt'],
        battleType: json['battle_type'],
        date: json['date'],
        xp: json['xp'],
        frags: json['frags'],
        survivedBattles: json['survived_battles'],
        droppedCapturePoints: json['dropped_capture_points'],
      );

  Map<String, dynamic> toJson() => {
        'capture_points': capturePoints,
        'account_id': accountId,
        'max_xp': maxXp,
        'wins': wins,
        'planes_killed': planesKilled,
        'battles': battles,
        'damage_dealt': damageDealt,
        'battle_type': battleType,
        'date': date,
        'xp': xp,
        'frags': frags,
        'survived_battles': survivedBattles,
        'dropped_capture_points': droppedCapturePoints,
      };
}
