import 'package:flutter/foundation.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/models/calculation.dart';

import 'weapon.dart';

typedef PvP = ModeStatistics;
typedef PvE = ModeStatistics;
typedef ClanClan = ModeStatistics;
typedef PvPDiv2 = ModeStatistics;
typedef PvPDiv3 = ModeStatistics;
typedef Rank = ModeStatistics;

/// All the statistics of a player in a certain mode.
@immutable
class ModeStatistics with Calculation {
  const ModeStatistics({
    this.maxFragsBattle,
    this.draws,
    this.maxXp,
    this.wins,
    this.planesKilled,
    this.losses,
    this.battles,
    this.maxDamageDealt,
    this.damageDealt,
    this.maxPlanesKilled,
    this.torpedoes,
    this.aircraft,
    this.ramming,
    this.mainBattery,
    this.secondaries,
    this.survivedWins,
    this.frags,
    this.xp,
    this.survivedBattles,
    this.damageToBuildings,
    this.maxShipsSpottedShipId,
    this.maxDamageScouting,
    this.artAgro,
    this.maxXpShipId,
    this.shipsSpotted,
    this.maxFragsShipId,
    this.droppedCapturePoints,
    this.maxDamageDealtToBuildings,
    this.torpedoAgro,
    this.controlCapturedPoints,
    this.battlesSince510,
    this.maxTotalAgroShipId,
    this.maxShipsSpotted,
    this.maxSuppressionsShipId,
    this.damageScouting,
    this.maxTotalAgro,
    this.capturePoints,
    this.suppressionsCount,
    this.maxSuppressionsCount,
    this.maxPlanesKilledShipId,
    this.teamCapturePoints,
    this.controlDroppedPoints,
    this.maxDamageDealtToBuildingsShipId,
    this.maxDamageDealtShipId,
    this.maxScoutingDamageShipId,
    this.teamDroppedCapturePoint,
    this.battlesSince512,
  });

  final int? maxFragsBattle;
  final int? draws;
  final int? maxXp;
  final int? wins;
  final int? planesKilled;
  final int? losses;
  final int? battles;
  final int? maxDamageDealt;
  final int? damageDealt;
  final int? maxPlanesKilled;

  // Reuse classes in PvP.dart
  final Torpedoe? torpedoes;
  final AttackAircraft? aircraft;
  final RamAttack? ramming;
  final MainBattery? mainBattery;
  final SecondaryBattery? secondaries;

  final int? survivedWins;
  final int? frags;
  final int? xp;
  final int? survivedBattles;

  final int? damageToBuildings;
  final int? maxShipsSpottedShipId;
  final int? maxDamageScouting;
  final int? artAgro;
  final int? maxXpShipId;
  final int? shipsSpotted;
  final int? maxFragsShipId;
  final int? droppedCapturePoints;
  final int? maxDamageDealtToBuildings;
  final int? torpedoAgro;
  final int? controlCapturedPoints;
  final int? battlesSince510;
  final int? maxTotalAgroShipId;
  final int? maxShipsSpotted;
  final int? maxSuppressionsShipId;
  final int? damageScouting;
  final int? maxTotalAgro;
  final int? capturePoints;
  final int? suppressionsCount;
  final int? maxSuppressionsCount;
  final int? maxPlanesKilledShipId;
  final int? teamCapturePoints;
  final int? controlDroppedPoints;
  final int? maxDamageDealtToBuildingsShipId;
  final int? maxDamageDealtShipId;
  final int? maxScoutingDamageShipId;
  final int? teamDroppedCapturePoint;
  final int? battlesSince512;

  factory ModeStatistics.fromJson(Map<String, dynamic> json) => ModeStatistics(
        maxFragsBattle: json['max_frags_battle'],
        draws: json['draws'],
        maxXp: json['max_xp'],
        wins: json['wins'],
        planesKilled: json['planes_killed'],
        losses: json['losses'],
        battles: json['battles'],
        maxDamageDealt: json['max_damage_dealt'],
        damageDealt: json['damage_dealt'],
        maxPlanesKilled: json['max_planes_killed'],
        torpedoes: json['torpedoes'] == null
            ? null
            : Torpedoe.fromJson(json['torpedoes']),
        aircraft: json['aircraft'] == null
            ? null
            : AttackAircraft.fromJson(json['aircraft']),
        ramming: json['ramming'] == null
            ? null
            : RamAttack.fromJson(json['ramming']),
        mainBattery: json['main_battery'] == null
            ? null
            : MainBattery.fromJson(json['main_battery']),
        secondaries: json['second_battery'] == null
            ? null
            : SecondaryBattery.fromJson(json['second_battery']),
        survivedWins: json['survived_wins'],
        frags: json['frags'],
        xp: json['xp'],
        survivedBattles: json['survived_battles'],
        damageToBuildings: json['damage_to_buildings'],
        maxShipsSpottedShipId: json['max_ships_spotted_ship_id'],
        maxDamageScouting: json['max_damage_scouting'],
        artAgro: json['art_agro'],
        maxXpShipId: json['max_xp_ship_id'],
        shipsSpotted: json['ships_spotted'],
        maxFragsShipId: json['max_frags_ship_id'],
        droppedCapturePoints: json['dropped_capture_points'],
        maxDamageDealtToBuildings: json['max_damage_dealt_to_buildings'],
        torpedoAgro: json['torpedo_agro'],
        controlCapturedPoints: json['control_captured_points'],
        battlesSince510: json['battles_since_510'],
        maxTotalAgroShipId: json['max_total_agro_ship_id'],
        maxShipsSpotted: json['max_ships_spotted'],
        maxSuppressionsShipId: json['max_suppressions_ship_id'],
        damageScouting: json['damage_scouting'],
        maxTotalAgro: json['max_total_agro'],
        capturePoints: json['capture_points'],
        suppressionsCount: json['suppressions_count'],
        maxSuppressionsCount: json['max_suppressions_count'],
        maxPlanesKilledShipId: json['max_planes_killed_ship_id'],
        teamCapturePoints: json['team_capture_points'],
        controlDroppedPoints: json['control_dropped_points'],
        maxDamageDealtToBuildingsShipId:
            json['max_damage_dealt_to_buildings_ship_id'],
        maxDamageDealtShipId: json['max_damage_dealt_ship_id'],
        maxScoutingDamageShipId: json['max_scouting_damage_ship_id'],
        teamDroppedCapturePoint: json['team_dropped_capture_points'],
        battlesSince512: json['battles_since_512'],
      );

  // TODO: maybe we can put all these calculations in `calculation.dart`
  bool get hasBattle => battles != null && battles != 0;
  bool get hasHit => (mainBattery?.shots ?? 0) > 0;

  int get sunkBattle {
    if (survivedBattles == null) return 0;
    if (battles == null) return 0;
    return battles! - survivedBattles!;
  }

  double get killDeath {
    if (frags == null) return double.nan;
    return frags! / sunkBattle;
  }

  int get totalPotentialDamage => (artAgro ?? 0) + (torpedoAgro ?? 0);

  double get winrate => rate(wins, battles);
  double get survivedWinrate => rate(survivedWins, battles);
  double get survivedRate => rate(survivedBattles, battles);

  double get avgExp => average(xp, battles);
  double get avgDamage => average(damageDealt, battles);
  double get avgFrag => average(frags, battles);
  double get avgPlaneDestroyed => average(planesKilled, battles);

  double get avgSpottingDamage => average(damageScouting, battles);
  double get avgSpottedShips => average(shipsSpotted, battles);
  double get avgPotentialDamage => average(totalPotentialDamage, battles);

  String get battleString => battles.toString();
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

  String get mostDamageToBuilding => maxDamageDealtToBuildings.toString();
  String get mostSpottingDamage => maxDamageScouting.toString();
  String get mostSpotted => maxShipsSpotted.toString();
  String get mostSupression => maxSuppressionsCount.toString();
  String get mostPotential => maxTotalAgro.toString();
}
