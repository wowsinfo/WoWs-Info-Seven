import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wowsinfo/core/Utils.dart';
import 'package:wowsinfo/ui/pages/HomePage.dart';

/// InitialPage class
/// - It shows a full screen overlay
/// - Maybe display some messages as well
class InitialPage extends StatefulWidget {
  InitialPage({Key key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    Utils.delay(2000).then((_) {
      Navigator.of(context).pushReplacement(
        platformPageRoute(context: context, builder: (c) => HomePage())
      );
    });

    return Theme(
      // Only here, the overlay is blue and white text should be used
      data: ThemeData(
        accentColor: Colors.white,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white)
        ),
      ),
      child: Builder(builder: (c) {
        return Stack(
          children: <Widget>[
            // This app bar will update the status bar color
            AppBar(brightness: Brightness.dark),
            Container(
              color: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage('lib/assets/logo_white.png')),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Hello World', style: Theme.of(c).textTheme.subtitle1),
                    ),
                    PlatformCircularProgressIndicator(
                      ios: (_) => CupertinoProgressIndicatorData(
                        radius: 16
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
