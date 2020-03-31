/// This is the `PlayerAchievement` class
class PlayerAchievement {
  Data data;

  PlayerAchievement(json) {
    this.data = json["data"];
  }
}

/// This is the `Meta` class
class Meta {
  int count;
  Null hidden;

  Meta(json) {
    this.count = json["count"];
    this.hidden = json["hidden"];
  }
}

/// This is the `Data` class
class Data {
  K2011774448 k2011774448;

  Data(json) {
    this.k2011774448 = json["2011774448"];
  }
}

/// This is the `K2011774448` class
class K2011774448 {
  Map<String, int> battle;

  K2011774448(json) {
    this.battle = json["battle"];
  }
}