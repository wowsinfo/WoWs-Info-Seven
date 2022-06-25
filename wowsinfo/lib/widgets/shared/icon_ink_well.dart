import 'package:flutter/material.dart';

class IconInkWell extends StatelessWidget {
  const IconInkWell({
    Key? key,
    required this.icon,
    this.onTap,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final double? size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 48;
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: onTap,
        child: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
