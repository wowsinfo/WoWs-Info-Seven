import 'package:flutter/material.dart';
import 'package:wowsinfo/widgets/shared/asset_image_loader.dart';
import 'package:wowsinfo/widgets/shared/new_item_indicator.dart';

class ShipIcon extends StatelessWidget {
  const ShipIcon({
    Key? key,
    required this.icon,
    this.height,
    this.width,
    this.hero,
    this.isNew,
  }) : super(key: key);

  final String icon;
  final double? height;
  final double? width;
  final bool? hero;
  final bool? isNew;

  @override
  Widget build(BuildContext context) {
    final fullIcon = 'gamedata/app/assets/ships/$icon.png';
    final box = SizedBox(
      height: height ?? 80,
      width: width,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          AssetImageLoader(
            name: fullIcon,
            placeholder: 'gamedata/app/assets/ships/_default.png',
          ),
          if (isNew ?? false) const NewItemIndicator(),
        ],
      ),
    );

    if (hero != null && hero!) {
      return Hero(
        tag: icon,
        child: box,
      );
    } else {
      return box;
    }
  }
}
