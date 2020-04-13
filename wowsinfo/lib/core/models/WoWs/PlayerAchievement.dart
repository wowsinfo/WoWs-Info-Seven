/// This is the `PlayerAchievement` class
class PlayerAchievement {
  Map<String, int> achievement;

  PlayerAchievement(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null) {
      achievement = (json['battle'] as Map).cast<String, int>();
    }
  }
}
