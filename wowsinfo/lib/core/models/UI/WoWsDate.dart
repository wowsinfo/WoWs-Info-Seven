/// Format timestamp to date, datetime in a readable form
class WoWsDate {
  final int time;
  DateTime date;
  String dateString = '???';
  String dateTimeString = '???';

  WoWsDate(this.time) {
    if (time != null && time > 0) {
      this.date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
      final formatted = [
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second
      ].map((e) => e.toString().padLeft(2, '0')).toList(growable: false);

      this.dateTimeString =
          '${formatted[0]}.${formatted[1]}.${formatted[2]} ${formatted[3]}:${formatted[4]}:${formatted[5]}';
      this.dateString = dateTimeString.split(' ').first;
    }
  }

  int compareTo(WoWsDate date) => this.time - date.time;

  /// Less than a period so `this.date` must be after the date
  bool lessThan(Duration d) =>
      this.date?.isAfter(DateTime.now().subtract(d)) ?? false;

  /// Before a certain `WoWsDate`
  bool isBefore(WoWsDate date) => this.date?.isBefore(date.date) ?? false;
}
