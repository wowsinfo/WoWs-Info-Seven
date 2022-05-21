import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class AssetImageLoader extends StatelessWidget {
  const AssetImageLoader({
    Key? key,
    required this.name,
    this.placeholder,
  }) : super(key: key);

  final String name;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAssetImage(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        }
        return Container();
      },
    );
  }

  /// Load image from gamedata/ folder and some can be missing.
  Future<Widget> loadAssetImage(BuildContext context) async {
    final _logger = Logger('ImageLoader');
    try {
      final memoryImage = await DefaultAssetBundle.of(context).load(name);
      return Image.memory(memoryImage.buffer.asUint8List());
    } catch (e) {
      _logger.warning('Failed to load image: $name');
      if (placeholder == null) {
        return const Icon(
          Icons.close,
          color: Colors.red,
        );
      }

      return Image.asset(placeholder!);
    }
  }
}
