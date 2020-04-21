import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PvP.dart';
import 'package:wowsinfo/ui/widgets/ImageTile.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// BasicPlayerTile class, it shows the classic 6 cell
class BasicPlayerTile extends StatelessWidget {
  final PvP stats;
  BasicPlayerTile({Key key, this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapBox(
      width: 100,
      padding: const EdgeInsets.only(top: 16),
      itemPadding: const EdgeInsets.only(bottom: 8),
      children: [
        ImageTile(
          image: AssetImage('assets/images/battle.png'),
          title: 'Battle',
          value: stats.battleString,
        ),
        ImageTile(
          image: AssetImage('assets/images/winrate.png'),
          title: 'Battle',
          value: stats.winrateString,
        ),
        ImageTile(
          image: AssetImage('assets/images/damage.png'),
          title: 'Battle',
          value: stats.avgDamageString,
        ),
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
        ImageTile(
          image: AssetImage('assets/images/hitratio.png'),
          title: 'Battle',
          value: stats.mainHitRatioString,
        ),
      ],
    );
  }
}
