import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'package:wowsinfo/ui/widgets/ImageTile.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// BasicPlayerTile class, it shows the classic 6 cell
class BasicPlayerTile extends StatelessWidget {
  final Statistic stats;
  BasicPlayerTile({Key key, this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapBox(
      width: 120,
      padding: const EdgeInsets.all(8),
      itemPadding: const EdgeInsets.only(bottom: 8),
      children: [
        ImageTile(
          image: AssetImage('assets/images/battle.png'),
          title: 'Battle',
          value: '123',
        ),
        ImageTile(
          image: AssetImage('assets/images/winrate.png'),
          title: 'Battle',
          value: '123',
        ),
        ImageTile(
          image: AssetImage('assets/images/damage.png'),
          title: 'Battle',
          value: '123',
        ),
        ImageTile(
          image: AssetImage('assets/images/exp.png'),
          title: 'Battle',
          value: '123',
        ),
        ImageTile(
          image: AssetImage('assets/images/killdeathratio.png'),
          title: 'Battle',
          value: '123',
        ),
        ImageTile(
          image: AssetImage('assets/images/hitratio.png'),
          title: 'Battle',
          value: '123',
        ),
      ],
    );
  }
}
