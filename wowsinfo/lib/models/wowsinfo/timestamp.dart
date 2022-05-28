import 'package:flutter/foundation.dart';

/// Convert timestamp to [DateTime] with readable strings.
@immutable
class TimeStampDate {
  final int timeStamp;
  late final DateTime date;
  late final String dateString;
  late final String dateTimeString;

  TimeStampDate(this.timeStamp) {
    assert(this.timeStamp >= 0, 'timeStamp must be at least 0');
    final timeStamp = this.timeStamp >= 0 ? this.timeStamp : 0;
    date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    dateTimeString = _makeDateTimeString(date);
    dateString = dateTimeString.split(' ').first;
  }

  /// Convert [date] to `1970.01.01 00:00:00` format.
  String _makeDateTimeString(DateTime date) {
    final component = [
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second
    ].map((e) => e.toString().padLeft(2, '0')).toList(growable: false);
    return '${component[0]}.${component[1]}.${component[2]} '
        '${component[3]}:${component[4]}:${component[5]}';
  }

  /// Compare [date] with [other]
  int compareTo(TimeStampDate other) => timeStamp - other.timeStamp;

  /// Check if within [duration] from now
  bool isWithinDurationFromNow(Duration duration) =>
      isWithinDurationFrom(DateTime.now(), duration);

  /// Check if within [duration] from [date]
  bool isWithinDurationFrom(DateTime begin, Duration duration) =>
      date.isAfter(begin.subtract(duration));

  /// Check if [date] is before [other]
  bool isBefore(TimeStampDate other) => date.isBefore(other.date);
}
