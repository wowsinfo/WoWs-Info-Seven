import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/GitHub/PRData.dart';
import 'package:wowsinfo/core/models/UI/ChartValue.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/core/extensions/NumberExtension.dart';

/// WikiWarshipSimilarPage class
class WikiWarshipSimilarPage extends StatelessWidget {
  final Iterable<Warship> ships;
  final cached = CachedData.shared;
  WikiWarshipSimilarPage({Key key, @required this.ships}) : super(key: key);

  List<Series<ChartValue, String>> convert(String id, List<ChartValue> values, 
    Color color, String Function(ChartValue, int) labelFormatter) {
    return [
      Series(
        id: id, 
        data: values, 
        domainFn: (v, _) => v.name, 
        measureFn: (v, _) => v.value,
        labelAccessorFn: labelFormatter,
        colorFn: (v, _) => color,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final avg = Average();
    ships.forEach((e) => avg.add(cached.getShipStats(e.shipId.toString())));
    avg.average();

    final damageList = convert('damage', ships.map((e) => ChartValue(
      e.name, 
      cached.getShipStats(e.shipId.toString())?.averageDamageDealt)
    ).toList(growable: false), Color.fromHex(code: '#D32F2F'), (v, _) => v.value.myFixedString(0));

    List<Series<ChartValue, String>> winrateList = [
      Series(
        id: 'win_rate', 
        data: ships.map((e) => ChartValue(
          e.name, 
          cached.getShipStats(e.shipId.toString())?.winRate)
        ).toList(growable: false), 
        domainFn: (v, _) => v.name, 
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.myFixedString(1) + '%',
        colorFn: (v, _) => Color.fromHex(code: '#4CAF50')
      ),
    ];

    List<Series<ChartValue, String>> fragList = [
      Series(
        id: 'frag', 
        data: ships.map((e) => ChartValue(
          e.name, 
          cached.getShipStats(e.shipId.toString())?.averageFrag)
        ).toList(growable: false), 
        domainFn: (v, _) => v.name, 
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.myFixedString(2),
        colorFn: (v, _) => Color.fromHex(code: '#2196F3')
      ),
    ];

    final lang = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(ships.first.tierType)
      ),
      body: SafeArea(
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildChart(context, damageList, lang.localised('warship_avg_damage'), avg.damageString),
                  buildChart(context, winrateList, lang.localised('warship_avg_winrate'), avg.winrateString),
                  buildChart(context, fragList, lang.localised('warship_avg_frag'), avg.fragString),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChart(BuildContext context, List<Series<ChartValue, String>> list, String title, String subtitle) {
    final height = 20.0 * max(ships.length, 5).toDouble();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final axis = NumericAxisSpec(
      renderSpec: SmallTickRendererSpec(
        labelStyle: TextStyleSpec(
          color: isDark ? Color.white : Color.black,
        ),
      )
    );

    final dAxis = AxisSpec<String>(
      renderSpec: SmallTickRendererSpec(
        labelStyle: TextStyleSpec(
          color: isDark ? Color.white : Color.black,
        ),
      )
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.headline5),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(subtitle, style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(
            height: height,
            child: BarChart(
              list,
              animate: true,
              vertical: false,
              barRendererDecorator: BarLabelDecorator<String>(
                labelAnchor: BarLabelAnchor.end
              ),
              domainAxis: dAxis,
              primaryMeasureAxis: axis,
            ),
          ),
        ],
      ),
    );
  }
}

class Average {
  double damage = 0;
  String get damageString => damage.myFixedString(0);
  double winrate = 0;
  String get winrateString => winrate.myFixedString(1) + '%';
  double frag = 0;
  String get fragString => frag.myFixedString(2);
  int count = 0;

  void add(AverageStats stats) {
    if (stats != null) {
      damage += stats.averageDamageDealt;
      winrate += stats.winRate;
      frag += stats.averageFrag;
      count += 1;
    }
  }

  void average() {
    damage /= count;
    winrate /= count;
    frag /= count;
  }
}
