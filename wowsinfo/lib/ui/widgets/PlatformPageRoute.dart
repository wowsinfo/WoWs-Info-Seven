import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// PlatformPageRoute class
class PlatformPageRoute extends PageRoute {
  final MaterialPageRoute material;
  final CupertinoPageRoute cupertino;
  final bool renderIOS = Platform.isIOS || Platform.isMacOS;
  PageRoute route;

  PlatformPageRoute({Key key, @required this.material, this.cupertino}) {
    if (renderIOS && cupertino != null) route = cupertino;
    else route = material;
  }

  @override
  Color get barrierColor => route.barrierColor;

  @override
  String get barrierLabel => route.barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return route.buildPage(context, animation, secondaryAnimation);
  }

  @override
  bool get maintainState => route.maintainState;

  @override
  Duration get transitionDuration => route.transitionDuration;
}
