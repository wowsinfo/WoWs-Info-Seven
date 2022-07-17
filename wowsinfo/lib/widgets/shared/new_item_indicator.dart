import 'package:flutter/material.dart';

class NewItemIndicator extends StatelessWidget {
  const NewItemIndicator({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 10;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          // use primary color
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ),
    );
  }
}
