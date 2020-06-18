import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/UI/ChartValue.dart';
import 'package:wowsinfo/core/models/UI/PlayerChartData.dart';
import 'package:wowsinfo/core/models/WoWs/RecentPlayerInfo.dart';
import 'package:wowsinfo/core/utils/Utils.dart';
import 'package:wowsinfo/ui/widgets/common/WrapBox.dart';

/// PlayerChartPage class
class PlayerChartPage extends StatelessWidget {
  final PlayerChartData info;
  final RecentPlayerInfo recent;
  PlayerChartPage({Key key, this.info, this.recent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Utils.of(context).getItemWidth(400, margin: 60);
    final shouldRenderRecent = recent.totalBattles > 0;
    final shouldRenderRest = info.totalBattle > 0;

    return Scaffold(
      appBar: AppBar(title: Text('PlayerChartPage')),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: WrapBox(
            width: width,
            height: 300,
            itemPadding: const EdgeInsets.only(top: 8, bottom: 8),
            children: <Widget>[
              // So at least one battle, no battle no stats
              if (shouldRenderRecent)
                buildLineChart(
                    context, recent.recentBattleData, 'Recent battles',
                    subtitle: recent.battleString),
              if (shouldRenderRecent)
                buildLineChart(
                    context, recent.recentWinrateData, 'Recent average winrate',
                    subtitle: recent.avgWinrateString),
              if (shouldRenderRecent)
                buildLineChart(
                    context, recent.recentDamageData, 'Recent average damage',
                    subtitle: recent.avgDamageString),
              // No battle no stats
              if (shouldRenderRest)
                buildPieChart(
                    context, info.nationData, 'Battles by ship nation',
                    subtitle: info.battleString),
              if (shouldRenderRest)
                buildPieChart(context, info.typeData, 'Battles by ship type',
                    subtitle: info.battleString),
              if (shouldRenderRest)
                buildBarChart(context, info.tierData, 'Battles by ship tier',
                    subtitle: 'Avg tier - ${info.avgBattleTierString}'),
              // They are 0 by default so a simple check can determine whether they should be rendered
              if (info.topTenByBattles.length > 0)
                buildBarChart(
                    context, info.topTenBattleData, 'Top ten ships by battles',
                    vertical: false),
              if (info.topTenByWinrate.length > 0)
                buildBarChart(
                    context, info.topTenWinrateData, 'Top ten ships by winrate',
                    vertical: false),
              if (info.topTenByDamage.length > 0)
                buildBarChart(
                    context, info.topTenDamageData, 'Top ten ships by damage',
                    vertical: false),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildLineChart(
      BuildContext context, List<Series<ChartValue, num>> data, String title,
      {String subtitle}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: <Widget>[
        buildChartTitle(title, context),
        buildChartSubtitle(subtitle),
        Expanded(
          child: LineChart(
            data,
            animate: false,
            domainAxis: NumericAxisSpec(
                showAxisLine: true, renderSpec: NoneRenderSpec()),
            primaryMeasureAxis: NumericAxisSpec(
                showAxisLine: true,
                renderSpec: SmallTickRendererSpec(
                  labelStyle: TextStyleSpec(
                    color: isDark ? Color.white : Color.black,
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildBarChart(
      BuildContext context, List<Series<ChartValue, String>> data, String title,
      {String subtitle, bool vertical = true}) {
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

    return Column(
      children: <Widget>[
        buildChartTitle(title, context),
        buildChartSubtitle(subtitle),
        Expanded(
          child: BarChart(
            data,
            animate: false,
            vertical: vertical,
            domainAxis: dAxis,
            primaryMeasureAxis: axis,
            barRendererDecorator: vertical == true
                ? null
                : BarLabelDecorator<String>(labelAnchor: BarLabelAnchor.end),
          ),
        ),
      ],
    );
  }

  Widget buildPieChart(
      BuildContext context, List<Series<ChartValue, String>> data, String title,
      {String subtitle}) {
    return Column(
      children: <Widget>[
        buildChartTitle(title, context),
        buildChartSubtitle(subtitle),
        Expanded(
          child: PieChart(
            data,
            animate: false,
            behaviors: [
              DatumLegend(
                outsideJustification: OutsideJustification.middleDrawArea,
                position: BehaviorPosition.end,
                showMeasures: true,
                cellPadding: new EdgeInsets.all(0),
                legendDefaultMeasure: LegendDefaultMeasure.firstValue,
              )
            ],
          ),
        ),
      ],
    );
  }

  Text buildChartTitle(String title, BuildContext context) {
    return Text(title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6);
  }

  Widget buildChartSubtitle(String subtitle) {
    if (subtitle == null) return SizedBox.shrink();
    return Text(subtitle);
  }
}
