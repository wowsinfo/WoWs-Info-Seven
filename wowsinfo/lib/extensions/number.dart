extension NumberExtension on num {
  /// Call `toStringAsFixed` and convert `nan` -> `-`
  String toFixedString(int fractionDigits) {
    if (isNaN || isInfinite) return '-';
    return toStringAsFixed(fractionDigits);
  }

  /// Convert to decimal string and remove trailing zeros if it has no decimal
  String toDecimalString() {
    // handle precision because the number can be 8.000001
    final rounded = (this * 1000).round() / 1000;
    if (rounded % 1 == 0) return rounded.toStringAsFixed(0);
    return rounded.toFixedString(2);
  }
}
