import 'dart:html';

import 'package:flutter/material.dart';

// Everything about screen size in one place
class ScreenSize {
  final BuildContext context;

  ScreenSize._(this.context);
  static of(BuildContext context) => ScreenSize._(context);

  static const maxDialogWidth = 500.0;

  Size get screenSize => MediaQuery.of(context).size;

  bool isPhone() {
    return screenSize.width < 600;
  }

  bool isTablet() {
    return screenSize.width >= 600;
  }

  /// Based on the material design,
  /// https://m3.material.io/foundations/adaptive-design/large-screens/overview
  bool isSmallTablet() {
    final width = screenSize.width;
    return width >= 600 && width < 840;
  }

  bool isLargeTablet() {
    return screenSize.width >= 840;
  }

  /// Check if the device is iPhone 8 size (375 x 667)
  bool isPhone8() {
    final width = screenSize.width;
    return width <= 375;
  }

  /// Check if the device is iPhone X size (320 x 568)
  bool isPhoneSE() {
    final width = screenSize.width;
    return width <= 320;
  }
}
