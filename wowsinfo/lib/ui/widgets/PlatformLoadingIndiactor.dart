import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PlatformWidget.dart';

/// PlatformLoadingIndiactor class
class PlatformLoadingIndiactor extends StatelessWidget {
  PlatformLoadingIndiactor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      android: CircularProgressIndicator(),
      ios: CupertinoActivityIndicator(
        radius: 16,
      ),
    );
  }
}
