import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/widgets/PlatformWidget.dart';

/// LoadingOverlay class
/// - It shows a full screen overlay
/// - Maybe display some messages as well
class LoadingOverlay extends StatefulWidget {
  LoadingOverlay({Key key}) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      // Only here, the overlay is blue and white text should be used
      data: ThemeData(
        accentColor: Colors.white,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white)
        )
      ),
      child: Builder(builder: (c) {
        return Container(
          color: Colors.blue,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('lib/assets/logo_white.png')),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Hello', style: Theme.of(c).textTheme.subtitle1),
                ),
                PlatformWidget(
                  android: CircularProgressIndicator(),
                  ios: CupertinoActivityIndicator(
                    radius: 16,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
