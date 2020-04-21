import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';
import 'package:wowsinfo/core/models/UI/ChartValue.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// PlayerChartPage class
class PlayerChartPage extends StatelessWidget {
  final PlayerShipInfo info;
  final app = AppSettings.shared;
  PlayerChartPage({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerChartPage')
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: WrapBox(
              width: 400,
              height: 300,
              itemPadding: const EdgeInsets.all(8),
              children: <Widget>[
                buildPieChart(context, info.nationData, 'Battles by ship nation', subtitle: info.battleString),
                buildPieChart(context, info.typeData, 'Battles by ship type', subtitle: info.battleString),
                buildBarChart(context, info.tierData, 'Battles by ship tier', subtitle: 'Avg tier - ${info.avgBattleTierString}'),
                buildBarChart(context, info.topTenBattleData, 'Top ten ships by battles', vertical: false),
                buildBarChart(context, info.topTenWinrateData, 'Top ten ships by winrate', vertical: false),
                buildBarChart(context, info.topTenDamageData, 'Top ten ships by damage', vertical: false),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget buildBarChart(BuildContext context, List<Series<ChartValue, String>> data, String title, {String subtitle, bool vertical = true}) {
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
            barRendererDecorator: vertical == true ? null : BarLabelDecorator<String>(
              labelAnchor : BarLabelAnchor.end
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPieChart(BuildContext context, List<Series<ChartValue, String>> data, String title, {String subtitle}) {
    return Column(
      children: <Widget>[
        buildChartTitle(title, context),
        buildChartSubtitle(subtitle),
        Expanded(
          child: PieChart(
            data,
            animate: false,
            behaviors: [DatumLegend(
              outsideJustification: OutsideJustification.middleDrawArea,
              position: BehaviorPosition.end,
              showMeasures: true,
              cellPadding: new EdgeInsets.all(0),
              legendDefaultMeasure: LegendDefaultMeasure.firstValue,
            )],
          ),
        ),
      ],
    );
  }

  Text buildChartTitle(String title, BuildContext context) {
    return Text(
      title, textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6
    );
  }

  Widget buildChartSubtitle(String subtitle) {
    if (subtitle == null) return SizedBox.shrink();
    return Text(subtitle);
  }
}
