import 'package:charts_flutter/flutter.dart';

/// A name and a value
class ChartValue<T, V> {
  T name;
  V value;

  ChartValue(this.name, this.value);
}

class ChartUtils {
  /// A list of colours for the chart
  static final List<Color> colours = [
    MaterialPalette.blue.shadeDefault,
    MaterialPalette.red.shadeDefault,
    MaterialPalette.yellow.shadeDefault,
    MaterialPalette.green.shadeDefault,
    MaterialPalette.purple.shadeDefault,
    MaterialPalette.cyan.shadeDefault,
    MaterialPalette.deepOrange.shadeDefault,
    MaterialPalette.indigo.shadeDefault,
    MaterialPalette.lime.shadeDefault,
    MaterialPalette.pink.shadeDefault,
    MaterialPalette.teal.shadeDefault,
    MaterialPalette.gray.shadeDefault,
  ];

  static Color from(int index) => colours[index % colours.length];

  static final damageColour = Color.fromHex(code: '#D32F2F');
  static final fragsColour = Color.fromHex(code: '#2196F3');
  static final winrateColour = Color.fromHex(code: '#4CAF50');
  static final battleColour = Color.fromHex(code: '#FF9800');

  static List<Series<ChartValue<T, V>, T>> convert<T, V>(
    String id, {
    required List<ChartValue<T, V>> values,
    required Color color,
    required T Function(ChartValue<T, V>, int?) domainFn,
    required num? Function(ChartValue<T, V>, int?) measureFn,
    required String Function(ChartValue<T, V>, int?)? labelFormatter,
  }) {
    return [
      Series(
        id: id,
        data: values,
        domainFn: domainFn,
        measureFn: measureFn,
        labelAccessorFn: labelFormatter,
        colorFn: (v, _) => color,
      ),
    ];
  }

  static List<Series<ChartValue<T, num>, T>> convertDefault<T>(
    String id, {
    required List<ChartValue<T, num>> values,
    required Color color,
    required String Function(ChartValue<T, num>, int?)? labelFormatter,
  }) {
    return convert(
      id,
      values: values,
      color: color,
      domainFn: (v, _) => v.name,
      measureFn: (v, _) => v.value,
      labelFormatter: labelFormatter,
    );
  }
}
