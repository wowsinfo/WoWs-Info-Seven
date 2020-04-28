
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/UI/WeaponValue.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';
import 'package:wowsinfo/core/extensions/NumberExtension.dart';

class WeaponInfoTile extends StatelessWidget {
  final cached = CachedData.shared;
  final RankPvP pvp;
  final bool shipMode;
  WeaponInfoTile({Key key, @required this.pvp, this.shipMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pvp == null) return SizedBox.shrink();
    final width = Utils.of(context).getItemWidth(300, maxCount: 5, margin: 30);
    return WrapBox(
      width: width,
      height: !shipMode ? 160 : 70,
      padding: const EdgeInsets.all(8),
      itemPadding: const EdgeInsets.all(8),
      children: [
        WeaponValue(pvp.mainBattery, cached.shipModule.artillery),
        WeaponValue(pvp.secondBattery, 'Secondary'),
        WeaponValue(pvp.torpedo, cached.shipModule.torpedo),
        WeaponValue(pvp.aircraft, 'Aircraft'),
        WeaponValue(pvp.ramming, 'Ramming'),
        // It is kinda crazy here but for ship mode, it needs to have at least 1 frag
        // For player mode, it needs to make sure the ship id is not null
      ].where((e) => (e.weapon != null) 
        && (
          (shipMode && e.hasFrag) 
          || cached.getShip(e.shipId) != null
      )).map((e) => Column(
        children: <Widget>[
          Text(e.title, style: Theme.of(context).textTheme.headline6),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildWarshipCell(e),
                Expanded(child: buildValue(e)),
              ],
            ),
          ),
        ],
      )).toList(growable: false),
    );
  }

  Widget buildValue(WeaponValue e) {
    final values = [
      TextWithCaption(
        title: 'Max Frag',
        value: e.maxFrag,
      ),
      TextWithCaption(
        title: 'Total Frag',
        value: e.totalFrag,
      ),
    ];

    if (e.hasHitRatio) values.add(
      TextWithCaption(
        title: 'Hit Ratio',
        value: e.hitRatio.myFixedString(2) + '%',
      )
    );

    if (shipMode) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: values,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: values,
      );
    }
  }

  Widget buildWarshipCell(WeaponValue e) {
    if (shipMode) return SizedBox.shrink();
    return WikiWarshipCell(
      showDetail: true,
      ship: cached.getShip(e.shipId),
    );
  }
}
