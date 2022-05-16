extension NumberExtension on num {
  /// Call `toStringAsFixed` and convert `nan` -> `-`
  String toFixedString(int fractionDigits) {
    if (isNaN || isInfinite) return '-';
    return toStringAsFixed(fractionDigits);
  }

  /// Convert to decimal string and remove trailing zeros if it has no decimal
  String toDecimalString() {
    if (this % 1 == 0) return toStringAsFixed(0);
    return toString();
  }
}
