import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/GitHub/PRData.dart';
import 'package:wowsinfo/core/models/WoWs/PvP.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';

/// ShipAverageStatistics class, it shows ship average myStats and compare it to your myStats if provided
class ShipAverageStatistics extends StatelessWidget {
  final int shipId;
  final PvP myShip;
  final cached = CachedData.shared;
  ShipAverageStatistics({Key key, @required this.shipId, this.myShip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ship = cached.getShipStats(shipId.toString());
    final lang = AppLocalization.of(context);
    if (ship == null) return SizedBox.shrink();
    // Make sure there is at least 1 battle, no battle no stats
    if (myShip != null && myShip.battle > 0) return buildComparison(lang, ship);
    return buildNormal(lang, ship);
  }

  /// When my ship is null
  Row buildNormal(AppLocalization lang, AverageStats ship) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextWithCaption(
          title: lang.localised('warship_avg_damage'),
          value: ship.averageDamageString,
        ),
        TextWithCaption(
          title: lang.localised('warship_avg_winrate'),
          value: ship.winRateString,
        ),
        TextWithCaption(
          title: lang.localised('warship_avg_frag'),
          value: ship.averageFragString,
        ),
      ],
    );
  }

  /// Only inside ship detail page
  Row buildComparison(AppLocalization lang, AverageStats ship) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextWithCaption(
          title: lang.localised('warship_avg_damage'),
          valueWidget: buildStatistics(ship.averageDamageString, 
            myShip.avgDamage, ship.averageDamageDealt, (d) => d.toStringAsFixed(0)),
        ),
        TextWithCaption(
          title: lang.localised('warship_avg_winrate'),
          valueWidget: buildStatistics(ship.winRateString, 
            myShip.winrate, ship.winRate, (d) => d.toStringAsFixed(1) + '%'),
        ),
        TextWithCaption(
          title: lang.localised('warship_avg_frag'),
          valueWidget: buildStatistics(ship.averageFragString, 
            myShip.avgFrag, ship.averageFrag, (d) => d.toStringAsFixed(2)),
        ),
      ],
    );
  }

  /// basically a wrapper around diff text
  Widget buildStatistics(String first, double mine, double expected, String Function(double) formatter) {
    return buildDiffText(mine - expected, formatter);
  }

  Widget buildDiffText(double value, String Function(double) formatter) {
    if (value > 0) {
      return Text('+' + formatter(value), style: TextStyle(color: Colors.green));
    } else if (value < 0) {
      return Text(formatter(value), style: TextStyle(color: Colors.red));
    } else {
      return Text(formatter(value));
    }
  }
}
