import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class AssetImageLoader extends StatefulWidget {
  const AssetImageLoader({
    Key? key,
    required this.name,
    this.placeholder,
  }) : super(key: key);

  final String name;
  final String? placeholder;

  @override
  State<AssetImageLoader> createState() => _AssetImageLoaderState();
}

class _AssetImageLoaderState extends State<AssetImageLoader> {
  late Future<Widget> image;
  final _logger = Logger('ImageLoader');

  @override
  void initState() {
    super.initState();
    image = loadAssetImage(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: image,
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
    final imageName = widget.name;
    try {
      final memoryImage = await DefaultAssetBundle.of(context).load(imageName);
      return Image.memory(memoryImage.buffer.asUint8List());
    } catch (e) {
      _logger.warning('Failed to load image: $imageName');
      final placeholder = widget.placeholder;
      if (placeholder == null) {
        return const Icon(
          Icons.close,
          color: Colors.red,
        );
      }

      return Image.asset(placeholder);
    }
  }
}
