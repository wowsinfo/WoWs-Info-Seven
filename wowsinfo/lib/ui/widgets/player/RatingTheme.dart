import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';

/// RatingTheme class
class RatingTheme extends StatelessWidget {
  final Widget child;
  final MaterialColor color;
  const RatingTheme({Key key, this.color, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: this.color == null 
      ? theme
      : buildBasedOnBrightness(context),
      child: child,
    );
}

  ThemeData buildBasedOnBrightness(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light) return ThemeData(primarySwatch: color);
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: color,
      accentColor: color.shade500,
      indicatorColor: color.shade500,
    );
  }
}
