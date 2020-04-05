import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'WoWs Info Re',
      android: (_) => MaterialAppData(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
      ios: (_) => CupertinoAppData(
        theme: CupertinoThemeData(
          primaryColor: Colors.blue,
        )
      ),
      home: InitialPage(),
    );
  }
}
