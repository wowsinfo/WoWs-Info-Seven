
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PvP.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// Extra info for pvp
class PvPInfo extends StatelessWidget {
  final PvP pvp;

  const PvPInfo({
    Key key,
    @required this.pvp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pvp == null || !pvp.hasBattle) return SizedBox.shrink();
    return WrapBox(
      width: 100,
      children: [
        TextWithCaption(
          title: 'argo',
          value: pvp.artAgro.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.draw.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.controlCapturedPoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.controlDroppedPoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.droppedCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.artAgro.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.draw.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.droppedCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.loss.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.planesKilled.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.shipsSpotted.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.survivedBattle.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.survivedWin.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.teamCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.teamDroppedCapturePoint.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.torpedoAgro.toString(),
        ),
        TextWithCaption(
          title: '510',
          value: pvp.win.toString(),
        ),
        TextWithCaption(
          title: 'argo',
          value: pvp.xp.toString(),
        ),
      ],
    );
  }
}
