
import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/UI/RecordValue.dart';
import 'package:wowsinfo/core/models/WoWs/PvP.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

class RecordTile extends StatelessWidget {
  final PvP pvp;
  final bool shipMode;

  const RecordTile({
    Key key,
    @required this.pvp,
    this.shipMode = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pvp == null) return SizedBox.shrink();
    final cached = CachedData.shared;
    final width = Utils.of(context).getItemWidth(shipMode ? 120 : 150);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Text('Records', style: Theme.of(context).textTheme.headline6),
          WrapBox(
            width: width,
            itemPadding: const EdgeInsets.only(top: 8),
            children: [
              RecordValue(pvp.maxDamageDealtShipId, 'damage', pvp.maxDamage),
              RecordValue(pvp.maxXpShipId, 'max exp', pvp.maxExp),
              RecordValue(pvp.maxFragsShipId, 'max frag', pvp.maxFrag),
              RecordValue(pvp.maxTotalAgroShipId, 'max potential', pvp.maxPotential),
              RecordValue(pvp.maxShipsSpottedShipId, 'max spotted', pvp.maxSpotted),
              RecordValue(pvp.maxScoutingDamageShipId, 'max spotting', pvp.maxSpottingDamage),
              RecordValue(pvp.maxPlanesKilledShipId, 'max plane destoryed', pvp.maxPlane),
              RecordValue(pvp.maxDamageDealtToBuildingsShipId, 'damage to buildings', pvp.maxDamageToBuilding),
              RecordValue(pvp.maxSuppressionsShipId, 'max supression', pvp.maxSupression),
            // ship mode is safe by default (removed 0s) and only check for normal mode
            ].where((e) => (shipMode && e.value != '0') || cached.getShip(e.shipId) != null)
            .map((e) => buildCell(cached, e)).toList(growable: false),
          ),
        ],
      ),
    );
  }

  /// For ship mode, warship cell is not needed
  Widget buildCell(CachedData cached, RecordValue e) {
    final bottom = TextWithCaption(
      title: e.title,
      value: e.value,
    );

    if (shipMode) return bottom;
    return SizedBox(
      height: 150,
      child: WikiWarshipCell(
        showDetail: true,
        ship: cached.getShip(e.shipId),
        bottom: bottom
      ),
    );
  }
}
