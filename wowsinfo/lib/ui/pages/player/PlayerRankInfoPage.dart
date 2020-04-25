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
    final rankEntries = rank.sortedSeasons;
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerRankInfoPage')
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          itemCount: rankEntries.length,
          itemBuilder: (context, index) {
            final curr = rankEntries[index];
            return Column(
              children: [
                Text('Season ${curr.key}')
              ],
            );
          },
        )
      ),
    );
  }
}
