import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PlatformWidget.dart';

/// PlatformAlertDialog class
class PlatformAlertDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget> androidActions;
  /// THis must be cupertino dialog alert
  final List<Widget> iosActions;
  PlatformAlertDialog({Key key, @required this.title, @required this.content, @required this.androidActions, @required this.iosActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      android: AlertDialog(
        title: title,
        content: content,
        actions: androidActions,
      ),
      ios: CupertinoAlertDialog(
        title: title,
        content: content,
        actions: iosActions,
      ),
    );
  }
}
