import 'package:charts_flutter/flutter.dart';

class ChartColour {
  /// A list of colours for the chart
  static final List<Color> list = [
    MaterialPalette.red.shadeDefault,
    MaterialPalette.blue.shadeDefault,
    MaterialPalette.green.shadeDefault,
    MaterialPalette.purple.shadeDefault,
    MaterialPalette.deepOrange.shadeDefault,
    MaterialPalette.cyan.shadeDefault,
    MaterialPalette.indigo.shadeDefault,
    MaterialPalette.lime.shadeDefault,
    MaterialPalette.pink.shadeDefault,
    MaterialPalette.gray.shadeDefault,
    MaterialPalette.teal.shadeDefault,
    MaterialPalette.yellow.shadeDefault,
  ];

  static Color from(int index) => list[index % list.length];
}