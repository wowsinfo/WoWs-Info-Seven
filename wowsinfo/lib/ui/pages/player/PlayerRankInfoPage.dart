import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerInfo.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/pages/player/PlayerShipDetailPage.dart';
import 'package:wowsinfo/ui/pages/player/PlayerShipInfoPage.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';
import 'package:wowsinfo/ui/widgets/player/BasicShipInfoTile.dart';
import 'package:wowsinfo/ui/widgets/player/WeaponInfoTile.dart';

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
        child: SingleChildScrollView(
          child: WrapBox(
            width: 400,
            children: rankEntries.map((curr) {
              final pvp = curr.value.rankSolo;
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerShipInfoPage(
                  info: PlayerShipInfo.fromRank(rankShip, curr.key),
                ))),
                child: Column(
                  children: [
                    Text('Season ${curr.key}', style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 10),
                    BasicShipInfoTile(stats: pvp, compact: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextWithCaption(
                          title: 'Max Frags',
                          value: pvp.maxFrag,
                        ),
                        TextWithCaption(
                          title: 'Max Plane',
                          value: pvp.maxPlane,
                        ),
                        TextWithCaption(
                          title: 'Max EXP',
                          value: pvp.maxExp,
                        ),
                        TextWithCaption(
                          title: 'Max Damage',
                          value: pvp.maxDamage,
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text('More details'),
                      children: [
                        WeaponInfoTile(pvp: pvp, shipMode: true)
                      ],
                    )
                  ],
                ),
              );
            }).toList(growable: false),
          ),
        )
      ),
    );
  }
}
