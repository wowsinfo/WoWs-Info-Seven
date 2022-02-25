import 'package:flutter/material.dart';
import 'package:wowsinfo/models/Wiki/WikiWarship.dart' as Wiki;
import 'package:wowsinfo/ui/pages/wiki/WikiWarShipInfoPage.dart';

/// WikiWarshipCell class
class WikiWarshipCell extends StatelessWidget {
  final Wiki.Warship ship;
  final bool showDetail;
  final bool hero;
  final Widget bottom;
  final void Function() onTap;

  WikiWarshipCell({
    Key key,
    @required this.ship,
    this.showDetail = false,
    this.hero = false,
    this.bottom = const SizedBox.shrink(),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageWidget = ship?.smallImage == null
        ? AspectRatio(
            // This is the ratio of the image from the API
            aspectRatio: 1.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo_white.png',
                color: Colors.blue,
              ),
            ),
          )
        : Image.network(ship?.smallImage);

    return InkWell(
      onTap: showDetail ? () => this.gotoWiki(context) : this.onTap,
      child: Column(
        children: [
          Expanded(
              child: hero
                  ? Hero(
                      tag: ship.shipId,
                      child: imageWidget,
                    )
                  : imageWidget),
          buildText(ship.tierName),
          bottom,
        ],
      ),
    );
  }

  void gotoWiki(BuildContext context) {
    // Wiki is not available for removed ships
    if (ship.hasImage) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (c) => WikiWarShipInfoPage(ship: ship)));
    }
  }

  /// Use a different colour for premium or special ships
  Text buildText(String name) {
    var style = TextStyle(fontSize: 14, fontWeight: FontWeight.w300);
    if (ship.isPremium)
      style = TextStyle(
          fontSize: 14, color: Colors.orange[300], fontWeight: FontWeight.w500);
    if (ship.isSpecial)
      style = TextStyle(
          fontSize: 14,
          color: Colors.deepOrangeAccent[100],
          fontWeight: FontWeight.w600);

    return Text(name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: style);
  }
}
