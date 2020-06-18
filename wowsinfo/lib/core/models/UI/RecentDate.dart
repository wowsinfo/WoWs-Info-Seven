class RecentDate {
  final DateTime _curr = DateTime.now();
  String _tenDay;
  String get tenDayString => _tenDay;

  RecentDate() {
    // Get recent 10 days from yesterday to ten days ago
    final ten = List.generate(10, (index) => index + 1, growable: false);
    final temp =
        ten.map((element) => _convert(_curr.subtract(Duration(days: element))));
    _tenDay = temp.join('%2C');
  }

  String _convert(DateTime date) => [date.year, date.month, date.day]
      .map((e) => e.toString().padLeft(2, '0'))
      .join();
}
