import 'package:flutter/material.dart';
import 'package:wowsinfo/widgets/shared/asset_image_loader.dart';

class ShipIcon extends StatelessWidget {
  const ShipIcon({
    Key? key,
    required this.name,
    this.height,
  }) : super(key: key);

  final String name;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final icon = 'gamedata/app/assets/ships/$name.png';
    return SizedBox(
      height: height ?? 80,
      child: AssetImageLoader(
        name: icon,
        placeholder: 'gamedata/app/assets/ships/_default.png',
      ),
    );
  }
}
