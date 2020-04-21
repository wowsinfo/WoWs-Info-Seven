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
              children: <Widget>[
                buildPieChart(context, info.nationData, 'Battles by ship nation', subtitle: info.battleString),
                buildPieChart(context, info.typeData, 'Battles by ship type', subtitle: info.battleString),
                buildBarChart(context, info.tierData, 'Battles by ship tier', subtitle: 'Avg tier - ${info.avgBattleTierString}'),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget buildBarChart(BuildContext context, List<Series<ChartValue, String>> data, String title, {String subtitle}) {
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
            info.tierData,
            animate: false,
            vertical: true,
            domainAxis: dAxis,
            primaryMeasureAxis: axis,
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
