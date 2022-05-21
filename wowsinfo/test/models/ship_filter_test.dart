import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';

void main() {
  final shipFilter = ShipFilter(
    name: '',
    tiers: [1, 2, 3],
    regions: ['Germany'],
    types: ['Destroyer'],
  );

  test('test ship filter', () {
    expect(shipFilter.isEmpty, false);
  });
}
