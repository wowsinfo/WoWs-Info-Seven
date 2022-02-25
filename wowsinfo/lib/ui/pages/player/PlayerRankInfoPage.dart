import 'package:flutter/material.dart';
import 'package:wowsinfo/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/models/WoWs/RankPlayerInfo.dart';
import 'package:wowsinfo/models/WoWs/RankPlayerShipInfo.dart';
import 'package:wowsinfo/utils/Utils.dart';
import 'package:wowsinfo/ui/pages/player/PlayerShipInfoPage.dart';
import 'package:wowsinfo/ui/widgets/common/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/common/WrapBox.dart';
import 'package:wowsinfo/ui/widgets/player/BasicShipInfoTile.dart';
import 'package:wowsinfo/ui/widgets/player/RatingBar.dart';
import 'package:wowsinfo/ui/widgets/player/RatingTheme.dart';
import 'package:wowsinfo/ui/widgets/player/WeaponInfoTile.dart';

/// PlayerRankInfoPage class
class PlayerRankInfoPage extends StatelessWidget {
  final RankPlayerInfo rank;
  final RankPlayerShipInfo rankShip;
  PlayerRankInfoPage({Key key, this.rank, this.rankShip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rankEntries = rank.sortedSeasons;
    final width = Utils.of(context).getItemWidth(400);

    return Scaffold(
      appBar: AppBar(title: Text('PlayerRankInfoPage')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: WrapBox(
          width: width,
          children: rankEntries.map((curr) {
            final pvp = curr.value.rankSolo;
            final info = PlayerShipInfo.fromRank(rankShip, curr.key);
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => PlayerShipInfoPage(
                            info: info,
                          ))),
              child: RatingTheme(
                color: info.overallRating.colour,
                child: Column(
                  children: [
                    Text('Season ${curr.key}',
                        style: Theme.of(context).textTheme.headline6),
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
                          title: 'Max EXP',
                          value: pvp.maxExp,
                        ),
                        TextWithCaption(
                          title: 'Max Damage',
                          value: pvp.maxDamage,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: RatingBar(rating: info.overallRating),
                    ),
                    ExpansionTile(
                      title: Text('More details'),
                      children: [WeaponInfoTile(pvp: pvp, shipMode: true)],
                    )
                  ],
                ),
              ),
            );
          }).toList(growable: false),
        ),
      )),
    );
  }
}
