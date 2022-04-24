extension NumberExtension on num {
  /// Call `toStringAsFixed` and convert `nan` -> `-`
  String toFixedString(int fractionDigits) {
    if (isNaN || isInfinite) return '-';
    return toStringAsFixed(fractionDigits);
  }
}
