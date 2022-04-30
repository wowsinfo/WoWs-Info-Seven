import 'package:wowsinfo/extensions/number.dart';

import 'weapon.dart';

/// The base of the PVP model
class BasePvP {
  BasePvP({
    this.maxFragsBattle,
    this.draw,
    this.maxXp,
    this.win,
    this.planesKilled,
    this.loss,
    this.battle,
    this.maxDamageDealt,
    this.damageDealt,
    this.maxPlanesKilled,
    this.torpedo,
    this.aircraft,
    this.ramming,
    this.mainBattery,
    this.secondBattery,
    this.survivedWin,
    this.frag,
    this.xp,
    this.survivedBattle,
    this.damageToBuilding,
    this.maxShipsSpottedShipId,
    this.maxDamageScouting,
    this.artAgro,
    this.maxXpShipId,
    this.shipsSpotted,
    this.maxFragsShipId,
    this.droppedCapturePoint,
    this.maxDamageDealtToBuilding,
    this.torpedoAgro,
    this.controlCapturedPoint,
    this.battlesSince510,
    this.maxTotalAgroShipId,
    this.maxShipsSpotted,
    this.maxSuppressionsShipId,
    this.damageScouting,
    this.maxTotalAgro,
    this.capturePoint,
    this.suppressionsCount,
    this.maxSuppressionsCount,
    this.maxPlanesKilledShipId,
    this.teamCapturePoint,
    this.controlDroppedPoint,
    this.maxDamageDealtToBuildingsShipId,
    this.maxDamageDealtShipId,
    this.maxScoutingDamageShipId,
    this.teamDroppedCapturePoint,
    this.battlesSince512,
  });

  final int? maxFragsBattle;
  final int? draw;
  final int? maxXp;
  final int? win;
  final int? planesKilled;
  final int? loss;
  final int? battle;
  final int? maxDamageDealt;
  final int? damageDealt;
  final int? maxPlanesKilled;

  // Reuse classes in PvP.dart
  final Torpedoe? torpedo;
  final AttackAircraft? aircraft;
  final RamAttack? ramming;
  final MainBattery? mainBattery;
  final SecondaryBattery? secondBattery;

  final int? survivedWin;
  final int? frag;
  final int? xp;
  final int? survivedBattle;

  final int? damageToBuilding;
  final int? maxShipsSpottedShipId;
  final int? maxDamageScouting;
  final int? artAgro;
  final int? maxXpShipId;
  final int? shipsSpotted;
  final int? maxFragsShipId;
  final int? droppedCapturePoint;
  final int? maxDamageDealtToBuilding;
  final int? torpedoAgro;
  final int? controlCapturedPoint;
  final int? battlesSince510;
  final int? maxTotalAgroShipId;
  final int? maxShipsSpotted;
  final int? maxSuppressionsShipId;
  final int? damageScouting;
  final int? maxTotalAgro;
  final int? capturePoint;
  final int? suppressionsCount;
  final int? maxSuppressionsCount;
  final int? maxPlanesKilledShipId;
  final int? teamCapturePoint;
  final int? controlDroppedPoint;
  final int? maxDamageDealtToBuildingsShipId;
  final int? maxDamageDealtShipId;
  final int? maxScoutingDamageShipId;
  final int? teamDroppedCapturePoint;
  final int? battlesSince512;

  factory BasePvP.fromJson(Map<String, dynamic> json) => BasePvP(
        maxFragsBattle: json['max_frags_battle'],
        draw: json['draw'],
        maxXp: json['max_xp'],
        win: json['win'],
        planesKilled: json['planes_killed'],
        loss: json['loss'],
        battle: json['battle'],
        maxDamageDealt: json['max_damage_dealt'],
        damageDealt: json['damage_dealt'],
        maxPlanesKilled: json['max_planes_killed'],
        torpedo:
            json['torpedo'] == null ? null : Torpedoe.fromJson(json['torpedo']),
        aircraft: json['aircraft'] == null
            ? null
            : AttackAircraft.fromJson(json['aircraft']),
        ramming: json['ramming'] == null
            ? null
            : RamAttack.fromJson(json['ramming']),
        mainBattery: json['main_battery'] == null
            ? null
            : MainBattery.fromJson(json['main_battery']),
        secondBattery: json['second_battery'] == null
            ? null
            : SecondaryBattery.fromJson(json['second_battery']),
        survivedWin: json['survived_win'],
        frag: json['frag'],
        xp: json['xp'],
        survivedBattle: json['survived_battle'],
        damageToBuilding: json['damage_to_buildings'],
        maxShipsSpottedShipId: json['max_ships_spotted_ship_id'],
        maxDamageScouting: json['max_damage_scouting'],
        artAgro: json['art_agro'],
        maxXpShipId: json['max_xp_ship_id'],
        shipsSpotted: json['ships_spotted'],
        maxFragsShipId: json['max_frags_ship_id'],
        droppedCapturePoint: json['dropped_capture_points'],
        maxDamageDealtToBuilding: json['max_damage_dealt_to_buildings'],
        torpedoAgro: json['torpedo_agro'],
        controlCapturedPoint: json['control_captured_points'],
        battlesSince510: json['battles_since_510'],
        maxTotalAgroShipId: json['max_total_agro_ship_id'],
        maxShipsSpotted: json['max_ships_spotted'],
        maxSuppressionsShipId: json['max_suppressions_ship_id'],
        damageScouting: json['damage_scouting'],
        maxTotalAgro: json['max_total_agro'],
        capturePoint: json['capture_points'],
        suppressionsCount: json['suppressions_count'],
        maxSuppressionsCount: json['max_suppressions_count'],
        maxPlanesKilledShipId: json['max_planes_killed_ship_id'],
        teamCapturePoint: json['team_capture_points'],
        controlDroppedPoint: json['control_dropped_points'],
        maxDamageDealtToBuildingsShipId:
            json['max_damage_dealt_to_buildings_ship_id'],
        maxDamageDealtShipId: json['max_damage_dealt_ship_id'],
        maxScoutingDamageShipId: json['max_scouting_damage_ship_id'],
        teamDroppedCapturePoint: json['team_dropped_capture_points'],
        battlesSince512: json['battles_since_512'],
      );

  /// Calculate the average of [value] by dividing it by [battle].
  double _avg(int? value) {
    if (value == null) return double.nan;
    if (battle == null) return double.nan;
    return value / battle!;
  }

  /// Calculate the rate of [value] by dividing it by [battle].
  double _rate(int? value) {
    if (value == null) return double.nan;
    if (battle == null) return double.nan;
    return (value * 10000 / battle!) / 100.0;
  }

  bool get hasBattle => battle != null && battle != 0;
  bool get hasHit => (mainBattery?.shot ?? 0) > 0;

  int get sunkBattle {
    if (survivedBattle == null) return 0;
    if (battle == null) return 0;
    return battle! - survivedBattle!;
  }

  double get killDeath {
    if (frag == null) return double.nan;
    return frag! / sunkBattle;
  }

  double get winrate => _rate(win);
  double get survivedWinrate => _rate(survivedWin);
  double get survivedRate => _rate(survivedBattle);

  double get avgExp => _avg(xp);
  double get avgDamage => _avg(damageDealt);
  double get avgFrag => _avg(frag);
  double get avgPlaneDestroyed => _avg(planesKilled);

  double get avgSpottingDamage => _avg(damageScouting);
  double get avgSpottedShips => _avg(shipsSpotted);
  double get avgPotentialDamage => _avg((artAgro ?? 0) + (torpedoAgro ?? 0));

  String get battleString => battleString.toString();
  String get winrateString => '${winrate.toFixedString(1)}%';
  String get avgDamageString => avgDamage.toFixedString(0);
  String get avgExpString => avgExp.toFixedString(0);
  String get killDeathString => killDeath.toFixedString(2);
  double get mainHitRatio => mainBattery?.hitRatio ?? double.nan;
  String get mainHitRatioString => '${mainHitRatio.toFixedString(2)}%';

  String get mostDamage => maxDamageDealt.toString();
  String get mostExp => maxXp.toString();
  String get mostFrag => maxFragsBattle.toString();
  String get mostPlane => maxPlanesKilled.toString();

  String get mostDamageToBuilding => maxDamageDealtToBuilding.toString();
  String get mostSpottingDamage => maxDamageScouting.toString();
  String get mostSpotted => maxShipsSpotted.toString();
  String get mostSupression => maxSuppressionsCount.toString();
  String get mostPotential => maxTotalAgro.toString();
}
