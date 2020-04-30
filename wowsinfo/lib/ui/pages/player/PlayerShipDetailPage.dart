import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';
import 'package:wowsinfo/ui/widgets/player/BasicPlayerTile.dart';
import 'package:wowsinfo/ui/widgets/player/PvPInfo.dart';
import 'package:wowsinfo/ui/widgets/player/RatingBar.dart';
import 'package:wowsinfo/ui/widgets/player/RatingTheme.dart';
import 'package:wowsinfo/ui/widgets/player/WeaponInfoTile.dart';
import 'package:wowsinfo/ui/widgets/wiki/ShipAverageStatistics.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// PlayerShipDetailPage class
class PlayerShipDetailPage extends StatelessWidget {
  final ShipInfo ship;
  const PlayerShipDetailPage({Key key, this.ship}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = ship.rating;
    return RatingTheme(
      color: rating.colour,
      child: Scaffold(
        appBar: AppBar(
          title: Text(ship.shipId.toString()),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: WikiWarshipCell(ship: ship.ship, hero: true, showDetail: true)
                  ),
                  if (!ship.isRank) WrapBox(
                    width: 120,
                    padding: const EdgeInsets.only(bottom: 8),
                    children: [
                      TextWithCaption(
                        title: 'Last battle',
                        value: ship.lastBattleDate,
                      ),
                      TextWithCaption(
                        title: 'Total battle',
                        value: ship.totalBattleString,
                      ),
                      TextWithCaption(
                        title: 'Distance travelled',
                        value: ship.distanceString,
                      ),
                    ],
                  ),
                  RatingBar(rating: rating),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: ShipAverageStatistics(shipId: ship.shipId, myShip: ship.pvp),
                  ),
                  BasicPlayerTile(stats: ship.pvp),
                  PvPInfo(pvp: ship.pvp),
                  WeaponInfoTile(pvp: ship.pvp, shipMode: true)
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
