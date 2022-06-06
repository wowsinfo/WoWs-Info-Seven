import 'package:intl/intl.dart';

extension NumberExtension on num {
  /// Call `toStringAsFixed` and convert `nan` -> `-`
  String toFixedString(int fractionDigits) {
    if (isNaN || isInfinite) return '-';
    return toStringAsFixed(fractionDigits);
  }

  /// Convert to decimal string and remove trailing zeros if it has no decimal
  String toDecimalString() {
    // Overall, NumberFormat is the best
    final formatter = NumberFormat();
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;
    return formatter.format(this);
  }

  /// Convert as percent string without rounding
  String asPercentString() {
    return '${toDecimalString()}%';
  }

  /// Convert to percent string with rounding
  String toPercentString() {
    return (this * 100).asPercentString();
  }
}
