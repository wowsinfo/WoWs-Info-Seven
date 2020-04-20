import 'package:flutter/material.dart';

/// TextWithCaption class
class TextWithCaption extends StatelessWidget {
  final String title;
  final Widget titleWidget;
  final String value;
  final Widget valueWidget;
  const TextWithCaption({
    Key key, 
    this.title = '', this.value = '', 
    this.titleWidget, this.valueWidget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          buildTitle(context),
          buildValue(),
        ],
      ),
    );
  }

  Text buildValue() {
    if (valueWidget != null) return valueWidget;
    return Text(
      value,
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  Text buildTitle(BuildContext context) {
    if (titleWidget != null) return titleWidget;
    return Text(
      title, 
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.caption,
      maxLines: 2,
    );
  }
}
