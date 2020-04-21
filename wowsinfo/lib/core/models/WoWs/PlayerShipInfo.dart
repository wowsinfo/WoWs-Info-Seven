import 'package:charts_flutter/flutter.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/ChartColour.dart';
import 'package:wowsinfo/core/models/UI/ChartValue.dart';
import 'package:wowsinfo/core/models/UI/WoWsDate.dart';

import 'PvP.dart';

/// This is the `PlayerShipInfo` class, one ship or all ships, the structure is the same
class PlayerShipInfo {
  List<ShipInfo> ships = [];
  bool get isSingleShip => ships.length == 1;

  Map<String, int> type = {};
  List<Series<ChartValue, String>> get typeData {
    return [Series<ChartValue, String>(
      data: type.entries.map((e) => ChartValue(e.key, e.value)).toList(growable: false),
      id: 'type',
      domainFn: (v, _) => v.name,
      measureFn: (v, _) => v.value,
      labelAccessorFn: (v, _) => v.value.toString(),
      colorFn: (_, index) => chartColours[index % chartColours.length],
    )];
  }

  Map<String, int> nation = {};
  List<Series<ChartValue, String>> get nationData {
    return [Series<ChartValue, String>(
      data: nation.entries.map((e) => ChartValue(e.key, e.value)).toList(growable: false),
      id: 'nation',
      domainFn: (v, _) => v.name,
      measureFn: (v, _) => v.value,
      labelAccessorFn: (v, _) => v.value.toString(),
      colorFn: (_, index) => chartColours[index % chartColours.length],
    )];
  }

  PlayerShipInfo(Map<String, dynamic> data) {
    final List json = data.values.first;
    if (json != null) {
      // Also collect some data here
      final cached = CachedData.shared;
      json.forEach((item) {
        final curr = ShipInfo(item);
        final ship = cached.getShip(curr.shipId);
        // Ignore removed ships
        if (ship != null) {
          final nation = cached.getNationString(ship.nation);
          _addToMap(this.nation, nation, curr.battle);
          
          final type = cached.getTypeString(ship.type);
          _addToMap(this.type, type, curr.battle);

          ships.add(curr);
        }
      });
    }
  }

  void _addToMap(Map<String, int> m, String key, int count) {
    if (m[key] == null) m[key] = count;
    else m[key] += count;
  }
}

/// This is the `ShipInfo` class
class ShipInfo {
  PvP pvp;
  WoWsDate lastBattleTime;
  int accountId;
  int distance;
  int updatedAt;
  int battle;
  int shipId;
  dynamic private;

  ShipInfo(Map<String, dynamic> json) {
    if (json['pvp'] != null) this.pvp = PvP(json['pvp']);
    this.lastBattleTime = WoWsDate(json['last_battle_time']);
    this.accountId = json['account_id'];
    this.distance = json['distance'];
    this.updatedAt = json['updated_at'];
    this.battle = json['battles'];
    this.shipId = json['ship_id'];
    this.private = json['private'];
  }
}
