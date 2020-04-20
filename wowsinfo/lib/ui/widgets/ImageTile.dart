import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';

/// ImageTile class
class ImageTile extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String value;
  ImageTile({Key key, this.image, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: image),
        TextWithCaption(
          title: title,
          value: value,
        )
      ],
    );
  }
}
