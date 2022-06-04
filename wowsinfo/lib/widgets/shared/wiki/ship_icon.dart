import 'package:flutter/material.dart';
import 'package:wowsinfo/widgets/shared/asset_image_loader.dart';

class ShipIcon extends StatelessWidget {
  const ShipIcon({
    Key? key,
    required this.name,
    this.height,
    this.width,
    this.hero,
  }) : super(key: key);

  final String name;
  final double? height;
  final double? width;
  final bool? hero;

  @override
  Widget build(BuildContext context) {
    final icon = 'gamedata/app/assets/ships/$name.png';
    final box = SizedBox(
      height: height ?? 80,
      width: width,
      child: AssetImageLoader(
        name: icon,
        placeholder: 'gamedata/app/assets/ships/_default.png',
      ),
    );

    if (hero != null && hero!) {
      return Hero(
        tag: name,
        child: box,
      );
    } else {
      return box;
    }
  }
}
