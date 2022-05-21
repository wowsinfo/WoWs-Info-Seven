import 'package:flutter/material.dart';

/// Show a normal text with a caption on top.
class TextWithCaption extends StatelessWidget {
  const TextWithCaption({
    Key? key,
    this.title = '',
    this.value = '',
    this.titleWidget,
    this.valueWidget,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final String value;
  final Widget? valueWidget;

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

  Widget buildValue() {
    if (valueWidget != null) return valueWidget!;
    return Text(
      value,
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  Widget buildTitle(BuildContext context) {
    if (titleWidget != null) return titleWidget!;
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.caption,
      maxLines: 2,
    );
  }
}
