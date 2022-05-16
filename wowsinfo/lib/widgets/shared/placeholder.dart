import 'package:flutter/material.dart';

@immutable
class IconPlaceholder extends StatelessWidget {
  const IconPlaceholder({Key? key, this.size = 64}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    // Show a blue rounded container with the app logo
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
