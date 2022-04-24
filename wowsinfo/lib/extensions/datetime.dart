extension DateTimeExtension on DateTime {
  /// returns a human readable string, 2022-01-02
  String toHumanString() {
    // Add `0` in front of the date, otherwise, it won't work
    return [year, month, day]
        .map((e) => e.toString().padLeft(2, '0'))
        .join('-');
  }

  /// returns difference between two dates in days
  int diffInDay(DateTime other) {
    final duration = other.difference(this);
    return duration.inDays.abs();
  }

  /// returns a date time object from time stamp
  static DateTime fromTimeStamp(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  }
}
