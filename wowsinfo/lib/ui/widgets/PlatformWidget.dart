import 'dart:io';

import 'package:flutter/material.dart';

/// PlatformWidget class
/// - It renders base on the Platform
/// - If `ios` is not provided, `android` will be used
class PlatformWidget extends StatelessWidget {
  /// Only use IOS widget for IOS or Mac
  final bool renderIOS = Platform.isIOS || Platform.isMacOS;
  final Widget android;
  final Widget ios;
  PlatformWidget({Key key, @required this.android, this.ios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (renderIOS && ios != null) return ios;
    return android;
  }
}
