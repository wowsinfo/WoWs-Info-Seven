import 'package:flutter/material.dart';

/// WrapBox class
class WrapBox extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final EdgeInsets itemPadding;
  final double width;
  final double spacing;
  WrapBox({
    Key key, 
    this.children, this.width, 
    this.padding = const EdgeInsets.all(0),
    this.itemPadding = const EdgeInsets.all(0),
    this.spacing = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Wrap(
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: children.map((e) => Padding(
          padding: itemPadding,
          child: SizedBox(
            width: width,
            child: e,
          ),
        )).toList(growable: false),
      ),
    );
  }
}
