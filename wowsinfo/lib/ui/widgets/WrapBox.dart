import 'package:flutter/material.dart';

/// WrapBox class
class WrapBox extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final double width;
  WrapBox({Key key, this.children, this.width, this.padding = const EdgeInsets.all(0)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: children.map((e) => SizedBox(
          width: width,
          child: e,
        )).toList(growable: false),
      ),
    );
  }
}
