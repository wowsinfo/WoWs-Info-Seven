import 'package:charts_flutter/flutter.dart';
import 'package:wowsinfo/constants/ChartColour.dart';
import 'package:wowsinfo/models/ui/ChartValue.dart';
import 'package:wowsinfo/extensions/NumberExtension.dart';

/// This is the `RecentPlayerInfo` class
class RecentPlayerInfo {
  List<RecentPvP> _recent = [];
  bool _hasData = false;
  bool get hasRecentData => _hasData;
  bool get isActive => hasRecentData;

  double avgDamage = 0;
  String get avgDamageString => '${avgDamage.myFixedString(0)}';
  double totalBattles = 0;
  String get battleString =>
      '${totalBattles.myFixedString(0)} (${(totalBattles / days).myFixedString(0)})';
  double avgWinrate = 0;
  String get avgWinrateString => '${avgWinrate.myFixedString(1)}%';
  int get days => _recent.length;

  List<ChartValue> recentBattles = [];
  List<Series<ChartValue, num>> get recentBattleData =>
      _convert('recent_battle',
          listData: recentBattles, color: Color.fromHex(code: '#2196F3'));
  List<ChartValue> recentWinrate = [];
  List<Series<ChartValue, num>> get recentWinrateData =>
      _convert('recent_winrate',
          listData: recentWinrate,
          color: Color.fromHex(code: '#4CAF50'),
          labelFormatter: (v, _) => v.value.myFixedString(1) + '%');
  List<ChartValue> recentDamage = [];
  List<Series<ChartValue, num>> get recentDamageData =>
      _convert('recent_damage',
          listData: recentDamage,
          color: Color.fromHex(code: '#D32F2F'),
          labelFormatter: (v, _) => v.value.myFixedString(0));

  RecentPlayerInfo(Map<String, dynamic> data) {
    final json = data.values.first;
    if (json != null && json['pvp'] != null) {
      // Map to list and sort by late (latest first)
      this._recent = (json['pvp'] as Map)
          .values
          .map((e) => RecentPvP(e))
          .toList()
        ..sort((b, a) => a.date.compareTo(b.date));

      // It is meaningless if there is only one item in it, at least 2 are needed
      if (_recent.length > 1) {
        _hasData = true;
        this._recent.fold(null, (prev, curr) {
          if (prev != null) prev.diff(curr);
          return curr;
        });

        // removed the first item and reverse the list
        this._recent.removeLast();
        this._recent = this._recent.reversed.toList(growable: false);

        // Make chart data
        recentBattles = _recent.map((e) {
          totalBattles += e.battle;
          return ChartValue(e.date, e.battle);
        }).toList(growable: false);
        recentDamage = _recent.map((e) {
          avgDamage += e.avgDamage;
          return ChartValue(e.date, e.avgDamage);
        }).toList(growable: false);
        recentWinrate = _recent.map((e) {
          avgWinrate += e.winrate;
          return ChartValue(e.date, e.winrate);
        }).toList(growable: false);

        // Get average value
        avgDamage /= days;
        avgWinrate /= days;
      }
    }
  }

  List<Series<ChartValue, num>> _convert(String id,
      {Map mapData,
      List listData,
      Color color,
      String Function(ChartValue, num) labelFormatter}) {
    return [
      Series<ChartValue, num>(
        data: listData ??
            mapData.entries
                .map((e) => ChartValue(e.key, e.value))
                .toList(growable: false),
        id: id,
        measureFn: (v, _) => v.value,
        domainFn: (_, index) => index,
        colorFn: (_, index) => color ?? ChartColour.from(index),
      )
    ];
  }
}

/// This is the `RecentPvP` class
/// - battle will not be 0 because entry is only visible if the player played at least one game
class RecentPvP {
  int win;
  int planesKilled;
  int battle;
  int damageDealt;
  String date;
  int xp;
  int frag;
  int survivedBattle;

  double get winrate => (win * 10000 / battle) / 100.0;
  double get avgDamage => damageDealt / battle;

  /// Make sure it is sorted
  RecentPvP diff(RecentPvP other) {
    win -= other.win;
    planesKilled -= other.planesKilled;
    battle -= other.battle;
    damageDealt -= other.damageDealt;
    xp -= other.xp;
    frag -= other.frag;
    survivedBattle -= other.survivedBattle;
    return this;
  }

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
