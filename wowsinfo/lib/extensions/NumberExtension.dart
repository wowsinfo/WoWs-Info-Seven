extension NumberExtension on num {
  /// Convert `num` to a string but it will make `nan` -> `0`
  String myFixedString(fractionDigits) {
    if (this.isNaN) return (0).toStringAsFixed(fractionDigits);
    return this.toStringAsFixed(fractionDigits);
  }
}
