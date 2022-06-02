import 'package:flutter/material.dart';

class ShipName extends StatelessWidget {
  const ShipName(
    this.name, {
    Key? key,
    required this.isPremium,
    required this.isSpecial,
  }) : super(key: key);

  final String name;
  final bool isPremium;
  final bool isSpecial;

  @override
  Widget build(BuildContext context) {
    /// Use a different colour for premium or special ships
    var style = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    );

    if (isPremium) {
      style = TextStyle(
        fontSize: 14,
        color: Colors.orange[300],
        fontWeight: FontWeight.w500,
      );
    } else if (isSpecial) {
      style = TextStyle(
        fontSize: 14,
        color: Colors.deepOrangeAccent[100],
        fontWeight: FontWeight.w600,
      );
    }

    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
