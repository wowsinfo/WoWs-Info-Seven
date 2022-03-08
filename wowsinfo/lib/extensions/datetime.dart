extension DateTimeExtension on DateTime {
  /// returns a human readable string
  String toHumanString() {
    // Add `0` in front of the date, otherwise, it won't work
    return [year, month, day]
        .map((e) => e.toString().padLeft(2, '0'))
        .join('-');
  }

  /// returns difference between two dates in days
  int dayDifference(DateTime other) {
    final duration = other.difference(this);
    return duration.inDays.abs();
  }
}
