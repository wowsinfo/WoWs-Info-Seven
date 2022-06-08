import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/foundation/helpers/chart_utils.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/models/wowsinfo/average_counter.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class SimilarShipProvider extends ChangeNotifier {
  final _logger = Logger('SimilarShipProvider');
  final Ship _ship;
  SimilarShipProvider(this._ship);

  bool get hasSimilarShips => _similarShips.isNotEmpty;
  List<Ship> get similarShips => _similarShips;

  late final _similarShips = _getSimilarShips();
  List<Ship> _getSimilarShips() {
    final ships = GameRepository.instance.shipList;
    // same tier, same region, same group
    return ships
        .where((ship) =>
            ship.id != _ship.id &&
            ship.type == _ship.type &&
            ship.tier == _ship.tier &&
            ship.isSpecialGroup == _ship.isSpecialGroup)
        .toList();
  }

  late final _chartHeight = 20.0 * max(_similarShips.length, 5).toDouble();
  double get chartHeight => _chartHeight;

  late final double _averageDamage;
  String get averageDamage => _averageDamage.round().toDecimalString();

  late final double _averageWinrate;
  String get averageWinrate => _averageWinrate.asPercentString();

  late final double _averageFrags;
  String get averageFrags => _averageFrags.toDecimalString();

  late final List<Series<ChartValue, String>> _winrateSeries;
  List<Series<ChartValue, String>> get winrateSeries => _winrateSeries;

  late final List<Series<ChartValue, String>> _fragsSeries;
  List<Series<ChartValue, String>> get fragsSeries => _fragsSeries;

  late final List<Series<ChartValue, String>> _damageSeries;
  List<Series<ChartValue, String>> get damageSeries => _damageSeries;

  // filter out winrate, damage and frags of similar ships
  void extractShipAdditional() {
    final damage = AverageCounter();
    final frags = AverageCounter();
    final winrate = AverageCounter();
    final List<ChartValue> damageChart = [];
    final List<ChartValue> fragsChart = [];
    final List<ChartValue> winrateChart = [];

    for (final ship in _similarShips) {
      final info = GameRepository.instance.shipAdditionalOf(ship.id.toString());
      if (info == null) {
        _logger.warning('No ship additional info for ${ship.name}');
        continue;
      }

      damage.add(info.damage);
      frags.add(info.frags);
      winrate.add(info.winrate);

      final shipName = Localisation.instance.stringOf(ship.name);
      if (shipName == null) {
        assert(false, 'No localisation for ${ship.name}, unknown ship');
        continue;
      }

      damageChart.add(ChartValue(
        shipName,
        info.damage,
      ));
      fragsChart.add(ChartValue(
        shipName,
        info.frags,
      ));
      winrateChart.add(ChartValue(
        shipName,
        info.winrate,
      ));
    }

    _averageDamage = damage.average;
    _averageFrags = frags.average;
    _averageWinrate = winrate.average;

    _damageSeries = ChartUtils.convertDefault(
      'damage',
      values: damageChart,
      color: ChartUtils.damageColour,
      labelFormatter: (v, _) => v.value.toDecimalString(),
    );

    _fragsSeries = ChartUtils.convertDefault(
      'frags',
      values: fragsChart,
      color: ChartUtils.fragsColour,
      labelFormatter: (v, _) => v.value.toDecimalString(),
    );

    _winrateSeries = ChartUtils.convertDefault(
      'winrate',
      values: winrateChart,
      color: ChartUtils.winrateColour,
      labelFormatter: (v, _) => v.value.asPercentString(),
    );
  }
}
