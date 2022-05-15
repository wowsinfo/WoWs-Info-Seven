import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/gamedata/projectile.dart';

const _penetrationValue = 0.5561613;
const _gravity = 9.80665;
const _seaLevelTemperature = 288.15;
const _temperatureLapseRate = 0.0065;
const _seaLevelPressure = 101325.0;
const _univGasConstant = 8.31447;
const _massAir = 0.0289644;

/// quadrtic drag coefficient
const _cwQuadratic = 1;

const _angleInterval = 0.1;
const _step = 0.1; // time step

/// This is used to calculate AP Penetration in World of Warships
///
/// original matlab code from https://pastebin.com/1NEwkf7R,
/// converted to python using http://www.ompclib.appspot.com/m2py,
/// used https://github.com/EdibleBug/WoWSFT-Kotlin/blob/master/WoWSFT-Data/src/main/kotlin/WoWSFT/utils/PenetrationUtils.kt as a reference,
/// modified by HenryQuan
@immutable
class ApPenetration {
  const ApPenetration(
    this.info,
    this.range,
    this.verticalAngle,
  );

  final ArmorPiecingInfo info;
  final double range;
  final double verticalAngle;

  /// Calculate AP Penetration
  ApPenetrationInfo calculatePenetration() {
    final weight = info.weight;
    final diameter = info.diameter;
    final drag = info.drag;
    final velocity = info.velocity;
    final krupp = info.krupp;

    /// linear drag coefficient
    final cwLinear = 100.0 + 1000.0 / 3.0 * diameter;
    final penetrationValue = _penetrationValue * krupp / 2400.0;
    final dragConstant = 0.5 * drag * pow((diameter / 2.0), 2.0) * pi / weight;

    final penInfo = ApPenetrationInfo();

    // for each alpha angle do
    for (final angle in angles()) {
      var vX = cos(angle) * velocity;
      var vY = sin(angle) * velocity;

      var x = 0.0;
      var y = 0.0;
      var t = 0.0; // time taken

      // follow flight path until shell hits ground again
      while (y >= 0) {
        x += vX * _step;
        y += vY * _step;

        final temperature = _seaLevelTemperature - _temperatureLapseRate * y;
        final pressure = _seaLevelPressure *
            pow(
              1 - _temperatureLapseRate * y / _seaLevelTemperature,
              _gravity * _massAir / (_univGasConstant * _temperatureLapseRate),
            );
        final density = pressure * _massAir / (_univGasConstant * temperature);

        vX -= (_step * dragConstant * density) *
            (_cwQuadratic * pow(vX, 2.0) + cwLinear * vX);
        vY -= (_step * _gravity) -
            (_step * dragConstant * density) *
                (_cwQuadratic * pow(vY, 2.0) + cwLinear * vY.abs()) *
                vY.sign;

        t += _step;
      }

      if (x > range * 1.2) break;
      // TODO: consider ricochet and also maybe we should set a max distance

      final distance = sqrt(pow(vX, 2.0) + pow(vY, 2.0));
      // penetration formaula
      final penetration = penetrationValue *
          pow(distance, 1.1) *
          pow(weight, 0.55) /
          pow(diameter * 1000, 0.65);
      // impact angle on belt armour
      final impactAngle = atan(vY.abs() / vX.abs());

      penInfo.penetration.add(penetration * cos(impactAngle));
      penInfo.distance.add(x);
      // scaling of in-game time
      penInfo.time.add(t / 3.0);
    }

    return penInfo;
  }

  /// Get all angles between 0 and [verticalAngle]
  Iterable<double> angles() {
    return Iterable.generate(
      (verticalAngle / _angleInterval).ceil(),
      (i) => i / 10 * pi / 180,
    );
  }
}

@immutable
class ApPenetrationInfo {
  ApPenetrationInfo();

  final List<double> penetration = [];
  final List<double> distance = [];
  final List<double> time = [];
}
