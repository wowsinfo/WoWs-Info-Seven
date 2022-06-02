import 'package:flutter/material.dart';
import 'package:wowsinfo/foundation/colours.dart';

class ShipName extends StatelessWidget {
  const ShipName(
    this.name, {
    Key? key,
    required this.isPremium,
    required this.isSpecial,
  }) : super(key: key);

  final String name;
  final bool isPremium;
  final bool isSpecial;

  @override
  Widget build(BuildContext context) {
    /// Use a different colour for premium or special ships
    final TextStyle style;

    if (isPremium) {
      style = const TextStyle(
        fontSize: 14,
        color: WoWsColours.premiumShip,
        fontWeight: FontWeight.w500,
      );
    } else if (isSpecial) {
      style = const TextStyle(
        fontSize: 14,
        color: WoWsColours.specialShip,
        fontWeight: FontWeight.w500,
      );
    } else {
      style = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      );
    }

    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
