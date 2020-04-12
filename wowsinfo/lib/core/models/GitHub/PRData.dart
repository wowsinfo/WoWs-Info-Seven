/// This is the `PRData` class, `Personal Rating Data`
class PRData {
  Map<String, AverageStats> ships;

  PRData.fromJson(Map<String, dynamic> json) {
    ships = json.map((key, value) {
      // If it is a list it means that it is an empty entry
      if (value is List) return MapEntry(key, null);
      return MapEntry(key, AverageStats.fromJson(value));
    });
  }

  Map<String, dynamic> toJson() => ships.cast<String, dynamic>();
}

/// This is the `AverageStats` class
class AverageStats {
  int averageDamageDealt;
  double averageFrag;
  double winRate;

  AverageStats.fromJson(Map<String, dynamic> json) {
    this.averageDamageDealt = json['average_damage_dealt'];
    this.averageFrag = json['average_frags'];
    this.winRate = json['win_rate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'average_damage_dealt': this.averageDamageDealt,
      'average_frags': this.averageFrag,
      'win_rate': this.winRate,
    };
  }
}
