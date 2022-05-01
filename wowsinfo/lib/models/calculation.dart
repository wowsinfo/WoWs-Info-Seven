mixin Calculation {
  /// Calculate the average of [value] by dividing it by [base].
  double average(num? value, num? base) {
    if (value == null) return double.nan;
    if (base == null) return double.nan;
    return value / base.toDouble();
  }

  /// Calculate the percentage of [value] by dividing it by [base].
  double rate(num? value, num? base) {
    if (value == null) return double.nan;
    if (base == null) return double.nan;
    return (value * 10000 / base) / 100.0;
  }
}
