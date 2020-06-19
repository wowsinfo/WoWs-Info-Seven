class RecentDate {
  /// It returns string like 20200304%2C20200305
  /// - dateProvider is main for testing purpose
  static String getRecentDateString({int length = 10, DateTime dateProvider}) {
    // If data provider is not null, use it or use current time
    final DateTime _curr = dateProvider ?? DateTime.now();

    // Get recent 10 days from yesterday to ten days ago
    final ten = List.generate(length, (index) => index + 1, growable: false);
    final temp =
        ten.map((element) => _convert(_curr.subtract(Duration(days: element))));
    return temp.join('%2C');
  }

  /// Convert to 20200304 format
  String _convert(DateTime date) => [date.year, date.month, date.day]
      .map((e) => e.toString().padLeft(2, '0'))
      .join();
}
