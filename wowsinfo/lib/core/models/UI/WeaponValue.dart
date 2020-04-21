import 'package:wowsinfo/core/models/WoWs/PvP.dart';

/// Stores all value relating to record (max something)
class WeaponValue {
  Weapon weapon;
  String title;

  int get shipId => weapon.maxFragsShipId;
  bool get hasHitRatio => weapon.hasHitRatio;
  double get hitRatio => weapon.hitRatio;
  String get maxFrag => weapon.maxFrag;
  String get totalFrag => weapon.totalFrag;

  WeaponValue(this.weapon, this.title);
}
