import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/utils/Utils.dart';

/// PlatformWidget class
/// - It renders base on the Platform
/// - If `ios` is not provided, `android` will be used
class PlatformWidget extends StatelessWidget {
  /// Only use IOS widget for IOS or Mac
  final Widget android;
  final Widget ios;
  PlatformWidget({Key key, @required this.android, this.ios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Utils.isIOS() && ios != null) return ios;
    return android;
  }
}
