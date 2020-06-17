import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/providers/GlobalAppSettings.dart';

/// DebugProviderWidget class
class DebugProviderWidget extends StatelessWidget {
  DebugProviderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<GlobalAppSettings>(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FlatButton(onPressed: () {
              app.locale = Locale('en');
            }, child: Text('English')),
            FlatButton(onPressed: () {
              app.locale = Locale('ja');
            }, child: Text('日本語')),
            FlatButton(onPressed: () {
              app.locale = Locale('zh');
            }, child: Text('简体中文')),
            FlatButton(onPressed: () {
              app.brightness = ThemeMode.dark;
            }, child: Text('Dark')),
            FlatButton(onPressed: () {
              app.brightness = ThemeMode.light;
            }, child: Text('Light')),
            FlatButton(onPressed: () {
              final list = [
                Colors.blue,
                Colors.red,
                Colors.deepOrange,
                Colors.deepPurple,
                Colors.green,
                Colors.grey,
                Colors.orange,
                Colors.yellow,
                Colors.purple,
                Colors.pink,
                Colors.cyan,
                Colors.lightBlue,
                Colors.lightGreen,
                Colors.lime,
                Colors.teal,
                Colors.amber,
              ];
              final index = Random();
              app.color = list[index.nextInt(list.length)];
            }, child: Text('Colour')),
          ],
        ),
      ),
    );
  }
}
