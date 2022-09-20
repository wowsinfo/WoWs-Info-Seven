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
    return Image.asset(
      name,
      errorBuilder: (context, error, stackTrace) {
        if (placeholder == null) {
          return const Icon(
            Icons.close,
            color: Colors.red,
          );
        }

        return FadeInImage.assetNetwork(
          placeholder: placeholder!,
          image: name,
        );
      },
    );
  }
}

// class AssetImageLoader extends StatefulWidget {
//   const AssetImageLoader({
//     Key? key,
//     required this.name,
//     this.placeholder,
//   }) : super(key: key);

//   final String name;
//   final String? placeholder;

//   @override
//   State<AssetImageLoader> createState() => _AssetImageLoaderState();
// }

// class _AssetImageLoaderState extends State<AssetImageLoader> {
//   final _logger = Logger('AssetImageLoader');
//   late Future<Widget> _image;
//   late String name = widget.name;
//   late String? placeholder = widget.placeholder;

//   @override
//   void initState() {
//     super.initState();
//     _image = loadAssetImage(context);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (name != widget.name) {
//       setState(() {
//         name = widget.name;
//         placeholder = widget.placeholder;
//         _image = loadAssetImage(context);
//       });
//       _logger.fine('name changed to ${widget.name}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _image,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return snapshot.data as Widget;
//         }
//         return Container();
//       },
//     );
//   }

//   /// Load image from gamedata/ folder and some can be missing.
//   Future<Widget> loadAssetImage(BuildContext context) async {
//     final logger = Logger('AssetImageLoader');
//     try {
//       final memoryImage = await DefaultAssetBundle.of(context).load(name);
//       return Image.memory(memoryImage.buffer.asUint8List());
//     } catch (e) {
//       logger.warning('Failed to load image: $name');
//       if (placeholder == null) {
//         return const Icon(
//           Icons.close,
//           color: Colors.red,
//         );
//       }

//       return Image.asset(placeholder!);
//     }
//   }
// }
