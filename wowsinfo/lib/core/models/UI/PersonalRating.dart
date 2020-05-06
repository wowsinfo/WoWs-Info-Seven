import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/core/extensions/NumberExtension.dart';

/// It should handle one ships and a list of ships
class PersonalRating {
  int battle = 0;
  int index = -1;

  double experiencePoint = 0;
  double personalRating = 0;

  int actualDmg = 0;
  int actualFrags = 0;
  int actualWins = 0;

  double expectedDmg = 0;
  double expectedFrags = 0;
  double expectedWins = 0;

  MaterialColor get colour => index == -1 ? Colors.blueGrey : _ratingColours[index];
  bool get hasRating => index >= 0;

  MaterialColor getColour(int index) => index == -1 ? Colors.blueGrey : _ratingColours[index];
  /// Colors for each ratings
  final List<MaterialColor> _ratingColours = [
    Colors.red, Colors.orange, 
    Colors.amber, Colors.lightGreen, 
    Colors.green, Colors.cyan,
    Colors.purple, Colors.deepPurple
  ];

  PersonalRating();
  PersonalRating.fromShip(ShipInfo ship) {
    final prData = CachedData.shared.getShipStats(ship.shipId.toString());
    final pvp = ship.pvp;
    if (prData != null && pvp != null) {
      battle = pvp.battle;
      if (battle > 0) {
        actualDmg = pvp.damageDealt;
        actualFrags = pvp.frag;
        actualWins = pvp.win;

        expectedDmg = prData.averageDamageDealt * battle;
        expectedFrags = prData.averageFrag * battle;
        expectedWins = prData.winRate * battle / 100;

        this.calculate();
      }
    }
  }

  void calculate() {
    // No battle, no rating
    if (battle == 0) return;

    final double rDmg = actualDmg / expectedDmg;
    final double rFrags = actualFrags / expectedFrags;
    final double rWins = actualWins / expectedWins;

    final double nDmg = max(0, (rDmg - 0.4) / (1 - 0.4));
    final double nFrags = max(0, (rFrags - 0.1) / (1 - 0.1));
    final double nWins = max(0, (rWins - 0.7) / (1 - 0.7));

    personalRating = 700 * nDmg + 300 * nFrags + 150 * nWins;
    experiencePoint = log(battle) * personalRating;
    index = _getRatingIndex(personalRating);
  }

  int _getRatingIndex(double rating) {
    // If it is nah, just return -1
    if (rating.isNaN) return -1;
    else if (rating < 750) return 0;
    else if (rating < 1100) return 1;
    else if (rating < 1350) return 2;
    else if (rating < 1550) return 3;
    else if (rating < 1750) return 4;
    else if (rating < 2100) return 5;
    else if (rating < 2450) return 6;
    else return 7;
  }

  /// Add another ships
  void add(PersonalRating rating) {
    if (rating.battle == 0) return;
    battle += rating.battle;
    actualDmg += rating.actualDmg;
    expectedDmg += rating.expectedDmg;
    actualFrags += rating.actualFrags;
    expectedFrags += rating.expectedFrags;
    actualWins += rating.actualWins;
    expectedWins += rating.expectedWins;
  }

  List<MapEntry<String, String>> getRatingMap(BuildContext context) {
    final lang = AppLocalization.of(context);
    return {
      lang.localised('rating_bad'): '0 - 750',
      lang.localised('rating_below_average'): '750 - 1100',
      lang.localised('rating_average'): '1100 - 1350',
      lang.localised('rating_good'): '1350 - 1550',
      lang.localised('rating_very_good'): '1550 - 1750',
      lang.localised('rating_great'): '1750 - 2100',
      lang.localised('rating_unicum'): '2100 - 2450',
      lang.localised('rating_super_unicum'): '2450 - 9999+',
    }.entries.toList(growable: false);
  }

  /// Context is needed for localization to work
  String getComment(BuildContext context) {
    final lang = AppLocalization.of(context);
    String comment = '';
    switch (index) {
      case -1:
        return lang.localised('rating_no_info');
      case 0:
        return lang.localised('rating_bad');
      case 1:
        comment = lang.localised('rating_below_average');
        break;
      case 2:
        comment = lang.localised('rating_average');
        break;
      case 3:
        comment = lang.localised('rating_good');
        break;
      case 4:
        comment = lang.localised('rating_very_good');
        break;
      case 5:
        comment = lang.localised('rating_great');
        break;
      case 6:  
        comment = lang.localised('rating_unicum');
        break;
      default:
        comment = lang.localised('rating_super_unicum');
        break;
    }
    return '$comment - ${personalRating.myFixedString(0)}';
  }
}
