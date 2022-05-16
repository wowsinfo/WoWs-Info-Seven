import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class App {
  /// The shared instance of the App.
  static final App instance = App._init();
  App._init();

  late final BuildContext _context;

  /// TODO: this is nice to have but not sure if this introduces memory leaks
  void inject(BuildContext context) {
    _context = context;
  }

  /// Check if the app is running on Web.
  static const bool isWeb = kIsWeb;

  /// Check if the app is running on iOS.
  static final bool isIOS = Platform.isIOS;

  /// Check if the app is running on Android.
  static final bool isAndroid = Platform.isAndroid;

  /// Check if the app is running on iOS or Android.
  static final bool isMobile = !isWeb && (isIOS || isAndroid);

  /// Check if the app is running on Desktop.
  static final bool isDesktop = !isWeb && !isMobile;

  /// Check if this device is IOS or MacOS
  static final bool isApple = !isWeb && (isIOS || Platform.isMacOS);

  /// TODO: need to make sure the size changes and not fixed
  Size screenSize() {
    return MediaQuery.of(_context).size;
  }

  /// From https://stackoverflow.com/a/53912090
  bool isTablet() {
    // Desktop is always true
    if (isDesktop) return true;

    // This is for iPhone, iPad and Android phones & tablets
    final size = screenSize();
    final width = size.width;
    final height = size.height;

    final diagonal = sqrt(width * width + height * height);

    var isTablet = diagonal > 1100.0;
    return isTablet;
  }

  /// Platform specific page route to distinguish between mobile and desktop.
  static PageRoute platformPageRoute({
    required Widget Function(BuildContext context) builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    if (isMobile) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      );
    } else {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return builder(context);
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    }
  }
}
