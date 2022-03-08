import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  static Utils of(BuildContext context) => Utils(context);

  /// Print only in debug mode
  static void debugPrint(Object object) {
    if (kDebugMode) print(object);
  }

  /// A simple wrapper for Future.delayed
  static Future<void> delay(int duration) {
    return Future.delayed(Duration(milliseconds: duration));
  }

  /// Check if this device is IOS
  static bool isIOS() {
    // Web doesn't support platform so prevent calling it
    if (kIsWeb) return false;
    return Platform.isIOS || Platform.isMacOS;
  }

  /// From https://stackoverflow.com/a/53912090
  /// - Check whether this is a tabler or a large screen device
  bool isTablet() {
    var size = MediaQuery.of(context).size;
    var diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));

    var isTablet = diagonal > 1100.0;
    return isTablet;
  }

  int getItemCount(int maxItem, int minItem, int itemWidth) {
    final width = MediaQuery.of(context).size.width;
    return min(maxItem, max(width / itemWidth, minItem)).toInt();
  }

  double getItemWidth(int itemWidth, {int maxCount = 0, int margin = 0}) {
    final width = MediaQuery.of(context).size.width;
    // This is the max count so scale the width up
    final count = (width / itemWidth).floor();

    // Max count is to make sure it fills the entire width
    if (maxCount != 0 && count > maxCount) return (width / maxCount) - margin;
    return (width / count) - margin;
  }
}
