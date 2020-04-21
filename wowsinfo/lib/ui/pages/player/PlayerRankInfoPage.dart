import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';

/// PlayerRankInfoPage class
class PlayerRankInfoPage extends StatelessWidget {
  final RankPlayerInfo rank;
  final RankPlayerShipInfo rankShip;
  PlayerRankInfoPage({Key key, this.rank, this.rankShip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerRankInfoPage')
      ),
      body: Container(),
    );
  }
}
