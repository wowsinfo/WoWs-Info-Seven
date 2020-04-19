/// Format timestamp to date, datetime in a readable form
class WoWsDate {
  final int time;
  String dateString;
  String dateTimeString;

  WoWsDate(this.time) {
    final date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    final formatted = [date.year, date.month, date.day, date.hour, date.minute, date.year, date.second]
      .map((e) => e.toString().padLeft(2, '0'))
      .toList(growable: false);

    this.dateTimeString = '${formatted[0]}.${formatted[1]}.${formatted[2]} ${formatted[3]}.${formatted[5]}.${formatted[6]}';
    this.dateString = dateTimeString.split(' ').first;
  }
}