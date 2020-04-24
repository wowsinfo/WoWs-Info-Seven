import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/ui/widgets/player/BasicPlayerTile.dart';
import 'package:wowsinfo/ui/widgets/player/RatingBar.dart';
import 'package:wowsinfo/ui/widgets/player/WeaponInfoTile.dart';
import 'package:wowsinfo/ui/widgets/wiki/ShipAverageStatistics.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// PlayerShipDetailPage class
class PlayerShipDetailPage extends StatelessWidget {
  final ShipInfo ship;
  PlayerShipDetailPage({Key key, this.ship}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ship.shipId.toString())
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
                RatingBar(rating: ship.rating),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ShipAverageStatistics(shipId: ship.shipId, myShip: ship.pvp),
                ),
                BasicPlayerTile(stats: ship.pvp),
                WeaponInfoTile(pvp: ship.pvp, shipMode: true)
              ],
            )
          ),
        ),
      ),
    );
  }
}
