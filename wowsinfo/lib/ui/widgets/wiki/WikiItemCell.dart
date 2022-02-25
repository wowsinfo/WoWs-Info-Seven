import 'package:flutter/material.dart';
import 'package:wowsinfo/models/Wiki/WikiItem.dart';

/// WikiItemCell class
class WikiItemCell extends StatelessWidget {
  final WikiItem item;
  final void Function() onTap;
  final bool fit;
  final bool asset;

  const WikiItemCell(
      {Key key,
      @required this.item,
      this.onTap,
      this.fit = true,
      this.asset = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = asset ? Image.asset(item.image) : Image.network(item.image);
    return InkWell(
      onTap: this.onTap,
      child: Tooltip(
        message: item.name,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: fit ? FittedBox(child: image) : image,
        ),
      ),
    );
  }
}
