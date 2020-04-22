import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PvP.dart';
import 'package:wowsinfo/ui/widgets/ImageTile.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// BasicShipInfoTile class
class BasicShipInfoTile extends StatelessWidget {
  final PvP stats;
  final bool compact;
  BasicShipInfoTile({Key key, this.stats, this.compact = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buildChildren(),
      );
    } else {
      return WrapBox(
        width: 100,
        padding: const EdgeInsets.only(top: 16),
        itemPadding: const EdgeInsets.only(bottom: 8),
        children: buildChildren(),
      );
    }
  }

  List<Widget> buildChildren() {
    return [
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
    ];
  }
}
