import 'package:flutter/material.dart';

/// TextWithCaption class
class TextWithCaption extends StatelessWidget {
  final String title;
  final String value;
  const TextWithCaption({Key key, this.title = '', this.value = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Text(
          title, 
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption,
          maxLines: 2,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}
