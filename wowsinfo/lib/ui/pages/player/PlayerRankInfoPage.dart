import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/widgets/player/BasicShipInfoTile.dart';

/// PlayerRankInfoPage class
class PlayerRankInfoPage extends StatelessWidget {
  final RankPlayerInfo rank;
  final RankPlayerShipInfo rankShip;
  PlayerRankInfoPage({Key key, this.rank, this.rankShip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rankEntries = rank.sortedSeasons;
    final itemCount = Utils.of(context).getItemCount(4, 1, 400);

    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerRankInfoPage')
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: itemCount,
            childAspectRatio: 3,
          ),
          itemCount: rankEntries.length,
          itemBuilder: (context, index) {
            final curr = rankEntries[index];
            return Column(
              children: [
                Text('Season ${curr.key}', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 10),
                BasicShipInfoTile(stats: curr.value.rankSolo, compact: true),
              ],
            );
          },
        )
      ),
    );
  }
}
