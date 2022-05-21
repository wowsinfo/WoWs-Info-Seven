import 'package:flutter/foundation.dart';

/// The player's achievements.
@immutable
class PlayerAchievement {
  const PlayerAchievement({
    this.battle,
    this.progress,
  });

  final Map<String, int>? battle;
  final Map<String, int>? progress;

  factory PlayerAchievement.fromJson(Map<String, dynamic> json) {
    // this is a hidden account
    if (json.isEmpty) return const PlayerAchievement();

    final player = json.values.first;
    if (player is Map<String, dynamic>) {
      return PlayerAchievement(
        battle: player['battle'] == null
            ? null
            : Map<String, int>.from(player['battle']),
        progress: player['progress'] == null
            ? null
            : Map<String, int>.from(player['progress']),
      );
    }

    assert(false, 'Not a hidden account but data is missing');
    return const PlayerAchievement();
  }
}
