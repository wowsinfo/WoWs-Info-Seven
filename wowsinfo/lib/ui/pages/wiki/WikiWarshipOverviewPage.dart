import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/providers/CachedData.dart';
import 'package:wowsinfo/core/models/UI/ChartValue.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';

/// WikiWarshipOverviewPage class
class WikiWarshipOverviewPage extends StatelessWidget {
  WikiWarshipOverviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cached = Provider.of<CachedData>(context, listen: false);
    final overview = WikiWarshipOverview(cached.sortedWarshipList);
    // final lang = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Overview')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: BarChart(
                      overview.overallData,
                      animate: true,
                      vertical: false,
                      barRendererDecorator: BarLabelDecorator<String>(
                          labelAnchor: BarLabelAnchor.end),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: BarChart(
                      overview.tierData,
                      animate: true,
                      barRendererDecorator: BarLabelDecorator<String>(
                          labelAnchor: BarLabelAnchor.end),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: BarChart(
                      overview.typeData,
                      animate: true,
                      vertical: false,
                      barRendererDecorator: BarLabelDecorator<String>(
                          labelAnchor: BarLabelAnchor.end),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 300,
                    child: BarChart(
                      overview.nationData,
                      animate: true,
                      vertical: false,
                      barRendererDecorator: BarLabelDecorator<String>(
                          labelAnchor: BarLabelAnchor.end),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// This class calculate data and it is everything about ships
class WikiWarshipOverview {
  final List<Warship> ships;
  int get total => ships.length;
  int get normal => total - premium - special;

  Map<String, int> types = {};
  List<Series<ChartValue, String>> get typeData {
    return [
      Series<ChartValue, String>(
        data: types.entries
            .map((e) => ChartValue(e.key.toString(), e.value))
            .toList(growable: false),
        id: 'type',
        domainFn: (v, _) => v.name,
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.toString(),
      )
    ];
  }

  Map<String, int> nations = {};
  List<Series<ChartValue, String>> get nationData {
    return [
      Series<ChartValue, String>(
        data: nations.entries
            .map((e) => ChartValue(e.key.toString(), e.value))
            .toList(growable: false),
        id: 'nation',
        domainFn: (v, _) => v.name,
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.toString(),
      )
    ];
  }

  Map<int, int> tiers = {};
  List<Series<ChartValue, String>> get tierData {
    return [
      Series<ChartValue, String>(
        data: tiers.entries
            .map((e) => ChartValue(e.key.toString(), e.value))
            .toList(growable: false),
        id: 'tier',
        domainFn: (v, _) => v.name,
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.toString(),
      )
    ];
  }

  int premium = 0;
  int special = 0;
  List<Series<ChartValue, String>> get overallData {
    return [
      Series<ChartValue, String>(
        data: [
          ChartValue('Total', total),
          ChartValue('Premium', premium),
          ChartValue('Special', special),
          ChartValue('Normal', normal),
        ],
        id: 'overall',
        domainFn: (v, _) => v.name,
        measureFn: (v, _) => v.value,
        labelAccessorFn: (v, _) => v.value.toString(),
      )
    ];
  }

  WikiWarshipOverview(this.ships) {
    ships.forEach((element) {
      types.update(element.type, (value) => value + 1, ifAbsent: () => 0);
      nations.update(element.nation, (value) => value + 1, ifAbsent: () => 0);
      tiers.update(element.tier, (value) => value + 1, ifAbsent: () => 0);
      premium += element.isPremium ? 1 : 0;
      special += element.isSpecial ? 1 : 0;
    });
  }
}
