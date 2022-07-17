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
    this.onTap,
    this.isNew,
  }) : super(key: key);

  final String icon;
  final double? height;
  final double? width;
  final bool? hero;
  final bool? isNew;

  final String name;
  final bool isPremium;
  final bool isSpecial;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final cell = Column(
      children: [
        ShipIcon(
          icon: icon,
          height: height,
          width: width,
          hero: hero,
          isNew: isNew,
        ),
        ShipName(name, isPremium: isPremium, isSpecial: isSpecial),
      ],
    );

    if (onTap == null) return cell;
    return InkWell(
      onTap: onTap,
      child: cell,
    );
  }
}
