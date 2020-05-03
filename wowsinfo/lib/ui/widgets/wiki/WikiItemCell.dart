import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/Wiki/WikiItem.dart';

/// WikiItemCell class
class WikiItemCell extends StatelessWidget {
  final WikiItem item;
  final void Function() onTap;
  WikiItemCell({Key key, this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Tooltip(
        message: item.name,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: FittedBox(child: Image.network(item.image)),
        ),
      ),
    );
  }
}
