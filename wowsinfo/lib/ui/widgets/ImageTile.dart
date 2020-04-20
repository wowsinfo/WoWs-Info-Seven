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
    final size = 36.0;
    return Column(
      children: [
        Image(
          image: image,
          width: size, height: size,
          color: Theme.of(context).accentColor,
        ),
        TextWithCaption(
          title: title,
          value: value,
        )
      ],
    );
  }
}
