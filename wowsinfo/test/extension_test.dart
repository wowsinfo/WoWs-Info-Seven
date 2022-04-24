import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/extensions/datetime.dart';
import 'package:wowsinfo/extensions/number.dart';

void main() {
  test('test number extension', () {
    num n1 = 1 / 0;
    expect(n1.toFixedString(2), '-');
    num n2 = 0 / 0;
    expect(n2.toFixedString(2), '-');

    int n3 = 1;
    expect(n3.toFixedString(2), '1.00');
    expect(n3.toFixedString(0), '1');
    expect(n3.toFixedString(1), '1.0');
  });

  test('test datetime extension', () {
    DateTime d1 = DateTime(2022, 1, 2);
    expect(d1.toHumanString(), '2022-01-02');
    DateTime d2 = DateTime(2022, 1, 5);
    expect(d2.toHumanString(), '2022-01-05');
    expect(d2.diffInDay(d1), 3);
    expect(d1.diffInDay(d2), 3);

    // notice that it is not `DateTime.fromTimeStamp`
    DateTime d3 = DateTimeExtension.fromTimeStamp(1456818816);
    expect(d3.toHumanString(), '2016-03-01');
  });
}
