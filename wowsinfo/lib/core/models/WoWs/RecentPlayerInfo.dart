/// This is the `RecentPlayerInfo` class
class RecentPlayerInfo {
  Map<String, RecentPvP> recent;

  RecentPlayerInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null) {
      this.recent = (json['pvp'] as Map).map((a, b) => MapEntry(a, RecentPvP(b)));
    }
  }
}

/// This is the `RecentPvP` class
class RecentPvP {
  int win;
  int planesKilled;
  int battle;
  int damageDealt;
  String date;
  int xp;
  int frag;
  int survivedBattle;

  RecentPvP(Map<String, dynamic> json) {
    this.win = json['wins'];
    this.planesKilled = json['planes_killed'];
    this.battle = json['battles'];
    this.damageDealt = json['damage_dealt'];
    this.date = json['date'];
    this.xp = json['xp'];
    this.frag = json['frags'];
    this.survivedBattle = json['survived_battles'];
  }
}
