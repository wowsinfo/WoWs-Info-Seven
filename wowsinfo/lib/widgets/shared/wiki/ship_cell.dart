import 'package:flutter/material.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_icon.dart';
import 'package:wowsinfo/widgets/shared/wiki/ship_name.dart';

/// ShipIcon and ShipName in one widget
class ShipCell extends StatelessWidget {
  const ShipCell({
    Key? key,
    required this.icon,
    required this.name,
    required this.isPremium,
    required this.isSpecial,
    this.height,
    this.width,
    this.hero,
  }) : super(key: key);

  final String icon;
  final double? height;
  final double? width;
  final bool? hero;

  final String name;
  final bool isPremium;
  final bool isSpecial;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShipIcon(icon: icon, height: height, width: width, hero: hero),
        ShipName(name, isPremium: isPremium, isSpecial: isSpecial),
      ],
    );
  }
}
