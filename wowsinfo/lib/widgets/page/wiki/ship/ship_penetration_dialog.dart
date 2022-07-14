import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/ship.dart';
import 'package:wowsinfo/providers/wiki/ship_penetratio_provider.dart';

void showShipPenetrationDialog(
  BuildContext context,
  Ship ship,
) {
  final provider = ShipPenetrationProvider(context, ship);
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          provider.penetrationSeries,
          behaviors: [
            SeriesLegend(position: BehaviorPosition.bottom),
          ],
          // add mm to the y-axis
          primaryMeasureAxis: NumericAxisSpec(
            // start from 300
            tickProviderSpec: provider.buildPenetrationSpec(12),
            tickFormatterSpec: BasicNumericTickFormatterSpec(
              (mm) => '${mm?.toInt()}${Localisation.instance.millimeter}',
            ),
            renderSpec: GridlineRendererSpec(
              labelStyle: TextStyleSpec(
                color: provider.getThemePalette(),
              ),
            ),
          ),
          // add m to the x-axis
          secondaryMeasureAxis: NumericAxisSpec(
            tickFormatterSpec: BasicNumericTickFormatterSpec(
              (sec) => '${sec?.toInt()}${Localisation.instance.second}',
            ),
            // fixed 12 specs
            tickProviderSpec: const BasicNumericTickProviderSpec(
              desiredTickCount: 12,
            ),
            renderSpec: GridlineRendererSpec(
              labelStyle: TextStyleSpec(
                color: provider.getThemePalette(),
              ),
            ),
          ),
          domainAxis: NumericAxisSpec(
            tickFormatterSpec: BasicNumericTickFormatterSpec(
              (m) => '${(m ?? 0) ~/ 1000}${Localisation.instance.kilometer}',
            ),
            tickProviderSpec: provider.buildDistanceSpec(),
            renderSpec: GridlineRendererSpec(
              lineStyle: const LineStyleSpec(
                color: MaterialPalette.transparent,
              ),
              labelStyle: TextStyleSpec(
                color: provider.getThemePalette(),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
