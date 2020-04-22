import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/ui/pages/player/PlayerShipDetailPage.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerShipInfoPage')
      ),
      body: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0
          ),
          itemCount: ships.length,
          itemBuilder: (context, index) {
            final curr = ships[index];
            return WikiWarshipCell(
              ship: curr.ship,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerShipDetailPage(ship: curr))),
            );
          },
        ),
      ),
    );
  }
}
