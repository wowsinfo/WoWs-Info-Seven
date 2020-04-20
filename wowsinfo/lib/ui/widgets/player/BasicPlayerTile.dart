import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// BasicPlayerTile class, it shows the classic 6 cell
class BasicPlayerTile extends StatelessWidget {
  final Statistic stats;
  BasicPlayerTile({Key key, this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapBox(
      width: 100,
      children: [

      ],
    );
  }
}
