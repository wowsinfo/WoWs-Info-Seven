/// This is the `PlayerAchievement` class
class PlayerAchievement {
  Map<String, int> achievement;

  Iterable<MapEntry<String, int>> get sorted => achievement.entries
    .toList(growable: false)..sort((a, b) => b.value - a.value);

  PlayerAchievement(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null) {
      achievement = (json['battle'] as Map).cast<String, int>();
    }
  }
}
