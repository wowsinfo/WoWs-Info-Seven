import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/extensions/NumberExtension.dart';

/// This is the `PRData` class, `Personal Rating Data`
class PRData extends Cacheable {
  Map<String, AverageStats> ships;

  PRData.fromJson(Map<String, dynamic> json): super(json) {
    ships = json.map((key, value) {
      // If it is a list it means that it is an empty entry
      if (value == null || value is List) return MapEntry(key, null);
      return MapEntry(key, AverageStats.fromJson(value));
    });
  }

  Map<String, dynamic> toJson() => ships.cast<String, dynamic>();

  @override
  bool isValid() => ships.isNotEmpty;
}

/// This is the `AverageStats` class
class AverageStats {
  double averageDamageDealt;
  String get averageDamageString => averageDamageDealt.myFixedString(0);
  double averageFrag;
  String get averageFragString => averageFrag.myFixedString(2);
  double winRate;
  String get winRateString => winRate.myFixedString(1) + '%';

  AverageStats.fromJson(Map<String, dynamic> json) {
    this.averageDamageDealt = json['average_damage_dealt'].toDouble();
    this.averageFrag = json['average_frags'].toDouble();
    this.winRate = json['win_rate'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'average_damage_dealt': this.averageDamageDealt,
      'average_frags': this.averageFrag,
      'win_rate': this.winRate,
    };
  }
}
