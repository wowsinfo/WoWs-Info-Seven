extension DateTimeExtension on DateTime {
  /// returns a human readable string
  String toHumanString() {
    return [this.year, this.month, this.day].join('-');
  }

  /// returns difference between two dates in days
  int dayDifference(DateTime other) {
    final duration = other.difference(this);
    return duration.inDays.abs();
  }
}
