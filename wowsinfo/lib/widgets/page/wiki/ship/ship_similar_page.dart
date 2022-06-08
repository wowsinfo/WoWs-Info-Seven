import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/foundation/helpers/chart_utils.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/providers/wiki/similar_ship_provider.dart';

class ShipSimilarPage extends StatelessWidget {
  const ShipSimilarPage({Key? key, required this.ship}) : super(key: key);

  final Ship ship;

  @override
  Widget build(BuildContext context) {
    final provider = SimilarShipProvider(ship)..extractShipAdditional();
    final chartHeight = provider.chartHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisation.of(context).warship_compare_similar),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          buildChart(
            context,
            height: chartHeight,
            list: provider.damageSeries,
            title: Localisation.of(context).warship_avg_damage,
            subtitle: provider.averageDamage,
          ),
          buildChart(
            context,
            height: chartHeight,
            list: provider.winrateSeries,
            title: Localisation.of(context).warship_avg_winrate,
            subtitle: provider.averageWinrate,
          ),
          buildChart(
            context,
            height: chartHeight,
            list: provider.fragsSeries,
            title: Localisation.of(context).warship_avg_frag,
            subtitle: provider.averageFrags,
          ),
        ]),
      ),
    );
  }

  Widget buildChart(
    BuildContext context, {
    required double height,
    required List<Series<ChartValue, String>> list,
    required String title,
    required String subtitle,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final axis = NumericAxisSpec(
        renderSpec: SmallTickRendererSpec(
      labelStyle: TextStyleSpec(
        color: isDark ? Color.white : Color.black,
      ),
    ));

    final dAxis = AxisSpec<String>(
        renderSpec: SmallTickRendererSpec(
      labelStyle: TextStyleSpec(
        color: isDark ? Color.white : Color.black,
      ),
    ));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
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
                labelAnchor: BarLabelAnchor.end,
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
