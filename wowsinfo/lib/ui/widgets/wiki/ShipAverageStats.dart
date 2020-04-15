import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/GitHub/PRData.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';

/// ShipAverageStats class, it shows ship average myStats and compare it to your myStats if provided
class ShipAverageStats extends StatelessWidget {
  final int shipId;
  final AverageStats myStats;
  final cached = CachedData.shared;
  ShipAverageStats({Key key, @required this.shipId, this.myStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ship = cached.getShipStats(shipId.toString());
    final lang = AppLocalization.of(context);
    if (ship == null) return SizedBox.shrink();
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
}
