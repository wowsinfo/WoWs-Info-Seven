import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart' as Wiki;

/// WikiWarshipCell class
class WikiWarshipCell extends StatelessWidget {
  final Wiki.Warship ship;
  WikiWarshipCell({Key key, @required this.ship}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(ship.smallImage), 
              ),
            ),
            buildText('${ship.tierString} ${ship.name}'),
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
