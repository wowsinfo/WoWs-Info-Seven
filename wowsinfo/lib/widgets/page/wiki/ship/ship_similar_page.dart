import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/foundation/helpers/chart_utils.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/providers/wiki/similar_ship_provider.dart';
import 'package:wowsinfo/widgets/shared/max_width_box.dart';

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
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runAlignment: WrapAlignment.center,
              children: [
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
                buildChart(
                  context,
                  height: chartHeight,
                  list: provider.battleSeries,
                  title: Localisation.instance.battles,
                  subtitle: provider.totalBattles,
                ),
              ],
            ),
          ),
        ),
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
      ),
    );

    final dAxis = AxisSpec<String>(
      renderSpec: SmallTickRendererSpec(
        labelStyle: TextStyleSpec(
          color: isDark ? Color.white : Color.black,
        ),
      ),
    );

    const maxWidth = 500.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final double chartWidth;
    if (maxWidth * 4 < screenWidth) {
      // the size is too wide, just fill the screen
      chartWidth = screenWidth / 4;
    } else if (maxWidth * 2 < screenWidth) {
      // fill with 2 charts
      chartWidth = screenWidth / 2;
    } else {
      // small size, one only
      chartWidth = screenWidth;
    }

    final logger = Logger('ShipSimilarPage');
    logger.fine('chartWidth: $chartWidth');
    logger.fine('screenWidth: $screenWidth');

    return RepaintBoundary(
      child: MaxWidthBox(
        maxWidth: chartWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.headline5),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.subtitle1,
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
        ),
      ),
    );
  }
}
