import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';

/// DebugProviderWidget class
class DebugProviderWidget extends StatelessWidget {
  DebugProviderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppSettings>(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FlatButton(onPressed: () {
              app.setLocale(Locale('en'));
            }, child: Text('English')),
            FlatButton(onPressed: () {
              app.setLocale(Locale('ja'));
            }, child: Text('Japanese')),
            FlatButton(onPressed: () {
              app.setBrightness(ThemeMode.dark);
            }, child: Text('Dark')),
            FlatButton(onPressed: () {
              app.setBrightness(ThemeMode.light);
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
              app.setColor(list[index.nextInt(list.length)]);
            }, child: Text('Colour')),
          ],
        ),
      ),
    );
  }
}
