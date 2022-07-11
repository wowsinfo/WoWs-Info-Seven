import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/models/gamedata/projectile.dart';
import 'package:wowsinfo/models/wowsinfo/ap_penetration.dart';

void main() {
  const info = ArmorPiecingInfo(
    diameter: 0.381,
    weight: 879,
    drag: 0.3379,
    velocity: 836,
    krupp: 2250,
  );

  const pen = ApPenetration(
    info: info,
    range: 15650.0,
    verticalAngle: 40.0,
  );

  test('test ap penetration angles', () {
    final angles = pen.angles().toList();
    expect(angles.length, 400);
    expect(angles[0], 0.0);
    expect(angles[1] - 0.0017, lessThan(0.1));
    expect(angles[399] - 22562, lessThan(0.1));
  });

  test('test ap penetration calculation', () {
    final penInfo = pen.calculatePenetration();
    for (var time in penInfo.time) {
      expect(time, isNotNaN);
    }
    for (var pen in penInfo.penetration) {
      expect(pen, isNotNaN);
    }
    for (var distance in penInfo.distance) {
      expect(distance, isNotNaN);
    }

    // distance should increase over time
    penInfo.distance.reduce((value, element) {
      expect(element, greaterThan(value));
      return element;
    });
    // time should also increase
    penInfo.time.reduce((value, element) {
      expect(element, greaterThan(value));
      return element;
    });
    // penetration should decrease over time
    penInfo.penetration.reduce((value, element) {
      expect(element, lessThan(value));
      return element;
    });
  });
}
