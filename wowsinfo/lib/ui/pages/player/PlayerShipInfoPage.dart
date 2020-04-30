import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/pages/player/PlayerShipDetailPage.dart';
import 'package:wowsinfo/ui/widgets/player/BasicShipInfoTile.dart';
import 'package:wowsinfo/ui/widgets/player/RatingBar.dart';
import 'package:wowsinfo/ui/widgets/player/RatingTheme.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// PlayerShipInfoPage class
class PlayerShipInfoPage extends StatefulWidget {
  final PlayerShipInfo info;
  PlayerShipInfoPage({Key key, this.info}) : super(key: key);

  @override
  _PlayerShipInfoPageState createState() => _PlayerShipInfoPageState();
}

class _PlayerShipInfoPageState extends State<PlayerShipInfoPage> {
  @override
  Widget build(BuildContext context) {
    final ships = widget.info.ships;
    if (widget.info.canSort) ships.sort((b, a) => a.lastBattleTime.compareTo(b.lastBattleTime));

    // 120 can place 3 on iPhone 11
    final util = Utils.of(context);
    const count = 6;
    const width = 180;
    final itemCount = util.getItemCount(count, 1, width);
    final itemWidth = util.getItemWidth(width, maxCount: count);
    final rating = widget.info.overallRating;
    
    return RatingTheme(
      color: rating.colour,
      child: Scaffold(
        appBar: AppBar(
          title: Text(rating.getComment(context)),
          actions: [
            IconButton(
              icon: Icon(Icons.sort), 
              onPressed: ( ) {}
            ),
          ],
        ),
        body: SafeArea(
          child: Scrollbar(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemCount,
                childAspectRatio: itemWidth / 250
              ),
              itemCount: ships.length,
              itemBuilder: (context, index) {
                final curr = ships[index];
                return WikiWarshipCell(
                  ship: curr.ship,
                  hero: true,
                  bottom: Column(
                    children: [
                      RatingTheme(
                        color: curr.rating.colour,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BasicShipInfoTile(stats: curr.pvp, compact: true),
                        ),
                      ),
                      RatingBar(rating: curr.rating, compact: true)
                    ],
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerShipDetailPage(ship: curr))),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
