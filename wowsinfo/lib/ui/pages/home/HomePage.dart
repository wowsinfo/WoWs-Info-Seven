import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/pages/OriginalPage.dart';
import 'package:wowsinfo/ui/pages/SettingPage.dart';
import 'package:wowsinfo/ui/widgets/DebugProviderWidget.dart';
import 'package:wowsinfo/ui/widgets/common/ShiftingText.dart';

/// HomePage class
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pressCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ShiftingText(),
          leading: IconButton(
              icon: ImageIcon(AssetImage('assets/images/logo_white.png')),
              iconSize: 24 + (pressCount > 3 ? pressCount * 2.0 : 0.0),
              onPressed: () {
                if (pressCount > 5) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => OriginalPage()));
                } else {
                  setState(() {
                    pressCount += 1;
                  });
                }
              }),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => SettingPage()));
                })
          ],
        ),
        body: DebugProviderWidget());
  }
}
