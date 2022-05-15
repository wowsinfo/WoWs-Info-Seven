import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/gamedata/projectile.dart';

const _penetration_value = 0.5561613;
const _gravity = 9.80665;
const _sea_level_temperature = 288.15;
const _temperature_lapse_rate = 0.0065;
const _sea_level_pressure = 101325.0;
const _univ_gas_constant = 8.31447;
const _mass_air = 0.0289644;

/// quadrtic drag coefficient
const _cw_quadratic = 1;

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
  );

  final ArmorPiecingInfo info;
  final double range;

  /// Calculate AP Penetration
  List calculatePenetration() {
    final weight = info.weight;
    final diameter = info.diameter;
    final drag = info.drag;
    final velocity = info.velocity;
    final krupp = info.krupp;

    /// linear drag coefficient
    final cw_linear = 100 + 1000 / 3 * diameter;
    final penetration_value = _penetration_value * krupp / 2400;
    final drag_constant = 0.5 * drag * pow((diameter / 2), 2) * pi / weight;

    return [];
  }
}
