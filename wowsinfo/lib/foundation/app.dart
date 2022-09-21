import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class App {
  static const appVersion = '1.7.0';
  static const githubLink = 'https://github.com/WoWs-Info/WoWs-Info-Seven';
  static const appstoreLink = 'https://itunes.apple.com/app/id1202750166';
  static const playstoreLink =
      'https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo';
  static const latestRelease = '$githubLink/releases/latest';
  static const newIssueLink = '$githubLink/issues/new';
  static const emailToLink =
      'mailto:development.henryquan@gmail.com?subject=[WoWs Info $appVersion] ';

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

  static void launch(String url) async {
    final canLaunch = await canLaunchUrlString(url);
    if (canLaunch) {
      await launchUrlString(url);
    } else {
      assert(false, 'Could not launch $url');
    }
  }
}
