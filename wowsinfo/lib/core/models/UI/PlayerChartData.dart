import 'dart:collection';

import 'package:charts_flutter/flutter.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/ChartColour.dart';
import 'package:wowsinfo/core/models/UI/ChartValue.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';

/// This handles chart data relating to player ships
class PlayerChartData {
  final PlayerShipInfo info;

  List<ChartValue> topTenByBattles = [];
  List<Series<ChartValue, String>> get topTenBattleData => _convert('battle', listData: topTenByBattles, 
    color: Color.fromHex(code: '#D32F2F'));
  List<ChartValue> topTenByWinrate = [];
  List<Series<ChartValue, String>> get topTenWinrateData => _convert('winrate', listData: topTenByWinrate,
   color: Color.fromHex(code: '#4CAF50'), labelFormatter: (v, _) => v.value.toStringAsFixed(1) + '%');
  List<ChartValue> topTenByDamage = [];
  List<Series<ChartValue, String>> get topTenDamageData => _convert('damage', listData: topTenByDamage,
    color: Color.fromHex(code: '#2196F3'), labelFormatter: (v, _) => v.value.toStringAsFixed(0));

  double totalBattle = 0;
  double _battleTier = 0;
  double battleAvgTier = 0;
  String get avgBattleTierString => '${battleAvgTier.toStringAsFixed(1)}';
  String get battleString => '${totalBattle.toStringAsFixed(0)}';

  SplayTreeMap<String, int> type = SplayTreeMap();
  List<Series<ChartValue, String>> get typeData => _convert('type', mapData: type);
  SplayTreeMap<String, int> nation = SplayTreeMap();
  List<Series<ChartValue, String>> get nationData => _convert('nation', mapData: nation);
  SplayTreeMap<String, int> tier = SplayTreeMap() ;
  List<Series<ChartValue, String>> get tierData => _convert('tier', mapData: tier);

  PlayerChartData(this.info) {
    final cached = CachedData.shared;
    info.ships.forEach((curr) {
      final ship = cached.getShip(curr.shipId);
      // Ignore removed ships
      if (ship != null) {
        // Battles by nations
        final nation = cached.getNationString(ship.nation);
        _addToMap(this.nation, nation, curr.battle);
        
        // Battles by ship types
        final type = cached.getTypeString(ship.type);
        _addToMap(this.type, type, curr.battle);

        // Battles by tiers
        _addToMap(this.tier, ship.tierString, curr.battle);
        totalBattle += curr.battle;
        _battleTier += ship.tier * curr.battle;

        // At least 3 battles I guess
        if (curr.battle > 5) {
          topTenByBattles.add(ChartValue(ship.name, curr.battle));
          // Only add those if they are not NAN
          final avgDamage = curr.pvp.avgDamage;
          if (!avgDamage.isNaN) topTenByDamage.add(ChartValue(ship.name, avgDamage));
          final winrate = curr.pvp.winrate;
          if (!winrate.isNaN) topTenByWinrate.add(ChartValue(ship.name, winrate));
        }
      }
    });

    // Calculate avg tier
    battleAvgTier = _battleTier / totalBattle;
    // Take first ten elements
    topTenByBattles = (topTenByBattles..sort(sortNum)).take(10).toList(growable: false);
    topTenByDamage = (topTenByDamage..sort(sortNum)).take(10).toList(growable: false);
    // Ignore 100% winrate
    topTenByWinrate = (topTenByWinrate..sort(sortNum)).where((e) => e.value < 99).take(10).toList(growable: false);
  }


  /// sort by value
  int sortNum(ChartValue a, ChartValue b) => (b.value.compareTo(a.value)).toInt();

  List<Series<ChartValue, String>> _convert(String id, {Map mapData, List listData, Color color, String Function(ChartValue, int) labelFormatter}) {
    return [Series<ChartValue, String>(
      data: listData ?? mapData.entries.map((e) => ChartValue(e.key, e.value)).toList(growable: false),
      id: id,
      domainFn: (v, _) => v.name,
      measureFn: (v, _) => v.value,
      labelAccessorFn: labelFormatter ?? (v, _) => v.value.toString(),
      colorFn: (_, index) => color ?? chartColours[index % chartColours.length],
    )];
  }

  void _addToMap(Map m, dynamic key, int count) {
    if (m[key] == null) m[key] = count;
    else m[key] += count;
  }
}