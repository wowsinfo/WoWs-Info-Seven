import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart' as Wiki;
import 'package:wowsinfo/ui/pages/wiki/WikiWarShipInfoPage.dart';

/// WikiWarshipCell class
class WikiWarshipCell extends StatelessWidget {
  final Wiki.Warship ship;
  final bool showDetail;
  WikiWarshipCell({Key key, @required this.ship, this.showDetail = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: showDetail ? () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => WikiWarShipInfoPage(ship: ship))) : null,
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: ship.shipId,
                child: Image(
                  image: NetworkImage(ship.smallImage), 
                ),
              ),
            ),
            buildText(ship.tierName),
          ],
        ),
      ),
    );
  }

  /// Use a different colour for premium or special ships
  Text buildText(String name) {
    var style = TextStyle(fontSize: 14, fontWeight: FontWeight.w300);
    if (ship.isSpecialOrPremium) style = TextStyle(fontSize: 14, color: Colors.orange);

    return Text(
      name, 
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: style
    );
  }
}
