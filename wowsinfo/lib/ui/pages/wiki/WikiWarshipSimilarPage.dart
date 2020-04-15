import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';

/// WikiWarshipSimilarPage class
class WikiWarshipSimilarPage extends StatelessWidget {
  final Iterable<Warship> ships;
  final cached = CachedData.shared;
  WikiWarshipSimilarPage({Key key, @required this.ships}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Series<ShipValue, String>> damageList = [
      Series(
        id: 'damage', 
        data: ships.map((e) => ShipValue(
          e.name, 
          cached.getShipStats(e.shipId.toString())?.averageDamageDealt)
        ).toList(growable: false), 
        domainFn: (v, _) => v.name, 
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.toStringAsFixed(0),
      ),
    ];

    List<Series<ShipValue, String>> winrateList = [
      Series(
        id: 'win_rate', 
        data: ships.map((e) => ShipValue(
          e.name, 
          cached.getShipStats(e.shipId.toString())?.winRate)
        ).toList(growable: false), 
        domainFn: (v, _) => v.name, 
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.toStringAsFixed(1) + '%',
      ),
    ];

    List<Series<ShipValue, String>> fragList = [
      Series(
        id: 'frag', 
        data: ships.map((e) => ShipValue(
          e.name, 
          cached.getShipStats(e.shipId.toString())?.averageFrag)
        ).toList(growable: false), 
        domainFn: (v, _) => v.name, 
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.toStringAsFixed(2),
      ),
    ];

    final height = 20.0 * ships.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(ships.first.tierType)
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              buildChart(height, damageList),
              buildChart(height, winrateList),
              buildChart(height, fragList),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChart(double height, List<Series<ShipValue, String>> damageList) {
    return SizedBox(
      height: height,
      child: BarChart(
        damageList,
        animate: true,
        vertical: false,
        barRendererDecorator: BarLabelDecorator<String>(
          labelAnchor: BarLabelAnchor.end
        ),
      ),
    );
  }
}

/// This contains ship name and the value
class ShipValue {
  String name;
  double value;

  ShipValue(this.name, this.value);
}