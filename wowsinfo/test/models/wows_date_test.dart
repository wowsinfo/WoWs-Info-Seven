import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/wowsinfo/wows_date.dart';

void main() {
  test('test wows date', () {
    final date1 = WoWsDate(0);
    expect(date1.dateString, '1970.01.01');
    // the space there is needed
    expect(date1.dateTimeString, contains('1970.01.01 '));
    // the hour is based on the timezone so check minute and second only
    expect(date1.dateTimeString, contains(':00:00'));
    expect(date1.isWithinDurationFromNow(const Duration(hours: 1)), false);
    expect(
      date1.isWithinDurationFrom(
        DateTime.fromMillisecondsSinceEpoch(1000),
        const Duration(hours: 24),
      ),
      true,
    );

    // negative should throw error in debug mode
    expect((() => WoWsDate(-1)), throwsAssertionError);

    final date2 = WoWsDate(1456818816);
    expect(date2.dateString, '2016.03.01');
  });
}
