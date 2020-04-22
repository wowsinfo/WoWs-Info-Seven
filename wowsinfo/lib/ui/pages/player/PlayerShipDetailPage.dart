import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';

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
      body: Container(),
    );
  }
}
