import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/data/Preference.dart';

void main() {
  test('Test Preference.shared', () {
    final a = Preference.shared;
    final b = Preference.shared;
    expect(identical(a, b), isTrue);
  });
}
