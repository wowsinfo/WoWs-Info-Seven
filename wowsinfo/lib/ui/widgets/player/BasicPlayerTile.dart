import 'package:flutter/material.dart';
import 'package:wowsinfo/models/WoWs/PvP.dart';
import 'package:wowsinfo/utils/Utils.dart';
import 'package:wowsinfo/ui/widgets/common/ImageTile.dart';
import 'package:wowsinfo/ui/widgets/common/WrapBox.dart';
import 'package:wowsinfo/ui/widgets/player/BasicShipInfoTile.dart';

/// BasicPlayerTile class, it shows the classic 6 cell
class BasicPlayerTile extends StatelessWidget {
  final PvP stats;
  BasicPlayerTile({Key key, this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stats == null || !stats.hasBattle) return SizedBox.shrink();
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        BasicShipInfoTile(stats: stats),
        buildBottom(context),
      ],
    );
  }

  WrapBox buildBottom(BuildContext context) {
    final width = Utils.of(context).getItemWidth(100);
    return WrapBox(
      width: width,
      padding: const EdgeInsets.only(top: 16),
      itemPadding: const EdgeInsets.only(bottom: 8),
      children: this.buildChilren(),
    );
  }

  List<Widget> buildChilren() {
    final tiles = [
      ImageTile(
        image: AssetImage('assets/images/exp.png'),
        title: 'Battle',
        value: stats.avgExpString,
      ),
      ImageTile(
        image: AssetImage('assets/images/killdeathratio.png'),
        title: 'Battle',
        value: stats.killDeathString,
      ),
      // Hide this if it is cv
      // TODO: consider what to add more cv
      if (stats.canHit)
        ImageTile(
          image: AssetImage('assets/images/hitratio.png'),
          title: 'Battle',
          value: stats.mainHitRatioString,
        ),
    ];

    return tiles;
  }
}
