import '../Meta.dart';

/// This is the `PlayerAchievement` class
class PlayerAchievement {
  Meta meta;
  Data data;

  PlayerAchievement(json) {
    this.meta = Meta(json["data"]);
    this.data = Data(json["data"]);
  }
}

/// This is the `Data` class
class Data {
  AchievementBattle battle;

  Data(json) {
    this.battle = AchievementBattle(json["2011774448"]);
  }
}

/// This is the `K2011774448` class
class AchievementBattle {
  Map<String, int> battle;

  AchievementBattle(json) {
    this.battle = json["battle"];
  }
}
