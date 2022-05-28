import 'package:flutter/foundation.dart';

@immutable
class DurabilityStats {
  const DurabilityStats({
    required this.minHealth,
    required this.maxHealth,
    required this.minArmour,
    required this.maxArmour,
    required this.torpProtection,
  });

  final int minHealth;
  final int maxHealth;

  final int minArmour;
  final int maxArmour;

  final int torpProtection;

  String get health => '$minHealth - $maxHealth';
  String get armour => '$minArmour - $maxArmour mm';
  String get torpProtectionPercent => '$torpProtection%';
}

@immutable
class MainBatteryStats {
  const MainBatteryStats({
    required this.reloadTime,
    required this.minReloadTime,
    required this.range,
    required this.maxRange,
    required this.barrel,
    required this.guns,
    required this.dispersion,
    required this.rotationTime,
    required this.gunName,
  });

  final double reloadTime;
  final double minReloadTime;

  final double range;
  final double maxRange;

  final int barrel;
  final int guns;

  final int dispersion;

  final double rotationTime;

  final String gunName;
}
