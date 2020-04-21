import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// PlayerChartPage class
class PlayerChartPage extends StatelessWidget {
  final PlayerShipInfo info;
  PlayerChartPage({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerChartPage')
      ),
      body: SafeArea(
        child: WrapBox(
          width: 400,
          height: 200,
          children: <Widget>[
            PieChart(
              info.nationData,
              animate: true,
              behaviors: [DatumLegend(
                desiredMaxRows: 9,
                outsideJustification: OutsideJustification.middleDrawArea,
                position: BehaviorPosition.end,
                showMeasures: true,
                entryTextStyle: TextStyleSpec(fontSize: 12),
                cellPadding: new EdgeInsets.all(0),
                legendDefaultMeasure: LegendDefaultMeasure.firstValue,
              )],
            ),
            PieChart(
              info.typeData,
              animate: true,
              behaviors: [DatumLegend(
                position: BehaviorPosition.end,
                cellPadding: new EdgeInsets.all(0),
                showMeasures: true,
                legendDefaultMeasure: LegendDefaultMeasure.firstValue,
              )],
            ),
          ],
        )
      ),
    );
  }

}
